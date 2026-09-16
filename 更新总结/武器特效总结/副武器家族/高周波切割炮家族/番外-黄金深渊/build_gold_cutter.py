# -*- coding: utf-8 -*-
# 黄金深渊（cutter_gold）五级形态主构建脚本 - 20260917
# 依据：work/recon-full.json（模板形状边界/填充）、work/acceptance-report.json（素材验收）
# 产出：work/sub1130-gold.xml（FFDec XML，单棵树手术）→ 由 xml2swf 转 SWF
# 断言：底稿哈希、ID 顺延、模板引用映射完备、定义先于引用
import xml.etree.ElementTree as ET
import numpy as np
from PIL import Image
import hashlib, json, os, zlib, copy

BASE_SWF = "work/sub1130-base.swf"
BASE_XML = "work/sub1130-base.xml"
OUT_XML = "work/sub1130-gold.xml"
SRC = r"D:\superalloy\相关素材\黄金深渊"

# ---------- 0. 底稿哈希断言 ----------
h = hashlib.sha256(open(BASE_SWF, "rb").read()).hexdigest().upper()
assert h.startswith("CB34BF6A"), "底稿 sub1130 哈希不符: %s" % h
print("[0] 底稿哈希 PASS (CB34BF6A)")

tree = ET.parse(BASE_XML)
tags = tree.getroot().find("tags")

# ---------- 1. ID 分配（全库最大 2777，顺延） ----------
MAXID = 2777
for it in tags:
    for k in ("shapeId", "characterID", "spriteId", "soundId"):
        v = it.get(k)
        if v and v.isdigit():
            global_max = int(v)
            assert global_max <= MAXID, "发现超过预期最大 ID 的定义: %s=%s" % (k, v)
_next = [MAXID + 1]
def alloc():
    v = _next[0]; _next[0] += 1; return v

# ---------- 2. 画师 PNG -> DefineBitsLossless2 (format5 预乘 ARGB) ----------
def png_to_lossless2(png_path):
    img = Image.open(png_path).convert("RGBA")
    a = np.array(img, dtype=np.uint16)
    alpha = a[..., 3]
    prem = np.empty_like(a)
    prem[..., 3] = alpha
    for c in range(3):
        prem[..., c] = (a[..., c] * alpha + 127) // 255
    px = prem.astype(np.uint32)
    argb = (px[..., 3] << 24) | (px[..., 0] << 16) | (px[..., 1] << 8) | px[..., 2]
    raw = argb.astype(">u4").tobytes()
    comp = zlib.compress(raw, 9)
    return img.size[0], img.size[1], comp.hex()

def bitmap_item(cid, png_path):
    w, hgt, hexdata = png_to_lossless2(png_path)
    el = ET.Element("item", {
        "type": "DefineBitsLossless2Tag", "bitmapFormat": "5",
        "bitmapWidth": str(w), "bitmapHeight": str(hgt),
        "characterID": str(cid), "forceWriteAsLong": "true",
        "zlibBitmapData": hexdata})
    return el

# ---------- 3. 形状构建 ----------
def nbits_signed(*vals):
    return max((abs(v).bit_length() + 1) for v in vals) if vals else 1

def matrix_attrs(tx, ty, sx=20.0, sy=20.0):
    return {"type": "MATRIX", "hasRotate": "false", "hasScale": "true",
            "nRotateBits": "0", "nScaleBits": "22",
            "nTranslateBits": str(nbits_signed(tx, ty)),
            "scaleX": ("%g" % sx), "scaleY": ("%g" % sy),
            "translateX": str(tx), "translateY": str(ty)}

def fill_item(bitmap_id, tx, ty):
    e = ET.Element("item", {"type": "FILLSTYLE", "bitmapId": str(bitmap_id), "fillStyleType": "67"})
    ET.SubElement(e, "bitmapMatrix", matrix_attrs(tx, ty))
    return e

def placeholder_fill():
    e = ET.Element("item", {"type": "FILLSTYLE", "bitmapId": "65535", "fillStyleType": "67"})
    ET.SubElement(e, "bitmapMatrix", matrix_attrs(0, 0))
    return e

def rect_shape(shape_id, x0, y0, x1, y1, bitmap_id, fill_tx=None, fill_ty=None):
    """单填充矩形包裹形状（1924 模式）: 矩形 (x0,y0)-(x1,y1) twips，位图 1:1 从 fill translate 铺起"""
    ftx = x0 if fill_tx is None else fill_tx
    fty = y0 if fill_ty is None else fill_ty
    w, hh = x1 - x0, y1 - y0
    el = ET.Element("item", {"type": "DefineShape2Tag", "forceWriteAsLong": "false", "shapeId": str(shape_id)})
    nb = nbits_signed(x0, x1, y0, y1)
    ET.SubElement(el, "shapeBounds", {"type": "RECT",
        "Xmax": str(x1), "Xmin": str(x0), "Ymax": str(y1), "Ymin": str(y0), "nbits": str(nb)})
    shapes = ET.SubElement(el, "shapes", {"type": "SHAPEWITHSTYLE", "numFillBits": "2", "numLineBits": "0"})
    fsa = ET.SubElement(shapes, "fillStyles", {"type": "FILLSTYLEARRAY"})
    fs = ET.SubElement(fsa, "fillStyles")
    fs.append(placeholder_fill())
    fs.append(fill_item(bitmap_id, ftx, fty))
    ET.SubElement(shapes, "lineStyles", {"type": "LINESTYLEARRAY"}).append(
        ET.Element("lineStyles", {}))
    recs = ET.SubElement(shapes, "shapeRecords")
    mb = nbits_signed(x1, y1)
    recs.append(ET.Element("item", {"type": "StyleChangeRecord", "fillStyle1": "2",
        "moveBits": str(mb), "moveDeltaX": str(x1), "moveDeltaY": str(y1),
        "stateFillStyle0": "false", "stateFillStyle1": "true", "stateLineStyle": "false",
        "stateMoveTo": "true", "stateNewStyles": "false"}))
    eb = nbits_signed(w, hh)
    recs.append(ET.Element("item", {"type": "StraightEdgeRecord", "deltaX": str(-w),
        "generalLineFlag": "false", "numBits": str(eb), "vertLineFlag": "false"}))
    recs.append(ET.Element("item", {"type": "StraightEdgeRecord", "deltaY": str(-hh),
        "generalLineFlag": "false", "numBits": str(eb), "vertLineFlag": "true"}))
    recs.append(ET.Element("item", {"type": "StraightEdgeRecord", "deltaX": str(w),
        "generalLineFlag": "false", "numBits": str(eb), "vertLineFlag": "false"}))
    recs.append(ET.Element("item", {"type": "StraightEdgeRecord", "deltaY": str(hh),
        "generalLineFlag": "false", "numBits": str(eb), "vertLineFlag": "true"}))
    recs.append(ET.Element("item", {"type": "EndShapeRecord", "endOfShape": "0"}))
    return el

# ---------- 4. 数据准备 ----------
recon = json.load(open("work/recon-full.json", encoding="utf-8"))
def rect_of(shape_id):
    for ch in recon["chains"].values():
        for info in ch:
            if info["shapeId"] == shape_id:
                r = info["rectTw"]; return r
    if str(shape_id) in recon["bodies"]:
        return recon["bodies"][str(shape_id)]["rectTw"]
    raise KeyError(shape_id)

new_defs = []          # (元素) 按依赖顺序
idmap = {}             # 说明表
name_pairs = []        # (charId, exportName)

# ---------- 5. 本体位图 + 形状 ----------
body_png = {1: "1黑绳/1黄金黑绳.png", 2: "2叫唤/2叫唤.png", 3: "3焦热/3黄金焦热.png",
            4: "4无间/4黄金无间.png"}  # lv5 复用 1988
# 内容对位补偿（验收表）：新 rect origin = 原 rect origin + (orig_tl - artist_tl)*20
body_rect_src = {1: 1835, 2: 1864, 3: 1893, 4: 1922, 5: 1956}
body_delta = {1: (-4, -2), 2: (0, 0), 3: (0, 0), 4: (0, 0), 5: (0, 0)}  # px

body_bmp = {}
for lv in (1, 2, 3, 4):
    bid = alloc()
    body_bmp[lv] = bid
    new_defs.append(bitmap_item(bid, os.path.join(SRC, body_png[lv])))
    idmap["body%d_bmp" % lv] = bid
body_bmp[5] = 1988  # 画师 lv5 图与现行金体位图逐像素一致（验收 色差=0.0），零成本复用
idmap["body5_bmp"] = 1988
print("[5] 本体位图:", {k: v for k, v in body_bmp.items()})

body_shape = {}
for lv in (1, 2, 3, 4, 5):
    sid = alloc()
    body_shape[lv] = sid
    r = dict(rect_of(body_rect_src[lv]))
    dx, dy = body_delta[lv]
    x0 = r["Xmin"] + dx * 20
    y0 = r["Ymin"] + dy * 20
    # 新 rect 尺寸 = 画师画布尺寸
    sizes = {1: (51, 29), 2: (51, 29), 3: (57, 33), 4: (83, 39), 5: (88, 41)}
    w, hh = sizes[lv]
    new_defs.append(rect_shape(sid, x0, y0, x0 + w * 20, y0 + hh * 20, body_bmp[lv]))
    idmap["body%d_shape" % lv] = sid
print("[5] 本体形状:", body_shape)

# ---------- 6. 特效件位图 + 形状 ----------
piece_png = {
    "lv1": [(1, "1黑绳/黑绳特效1.png"), (2, "1黑绳/黑绳特效2.png"), (3, "1黑绳/黑绳特效3.png"),
            (4, "1黑绳/黑绳特效4.png"), (5, "1黑绳/黑绳特效5.png"), (6, "1黑绳/黑绳特效6.png"),
            (7, "1黑绳/黑绳特效7.png"), (8, "1黑绳/黑绳特效8.png"), (9, "1黑绳/黑绳特效9.png"),
            (10, "1黑绳/黑绳特效10.png"), (11, "1黑绳/黑绳特效11.png"), (12, "1黑绳/黑绳特效12.png"),
            (13, "1黑绳/黑绳特效13.png")],
    "lv2": [(i, "2叫唤/叫唤特效%d.png" % i) for i in range(1, 14)],
    "lv3": [(i, "3焦热/焦热特效%d.png" % i) for i in range(1, 14)],
    "charge": [(i, "4无间/V4V5公用特效%d.png" % i) for i in range(1, 6)],
    "flame": [(i, "4无间/V4V5公用特效%d.png" % (i + 5)) for i in range(1, 8)],
}
# 模板形状 id（与 recon chains 顺序一致）
tmpl_shapes = {
    "lv1": list(range(1837, 1863, 2)),
    "lv2": list(range(1866, 1892, 2)),
    "lv3": list(range(1895, 1921, 2)),
    "charge": [1924, 1926, 1928, 1930, 1932],
    "flame": [1935, 1938, 1941, 1944, 1947, 1950, 1953],
}
# 验收补偿（fill 平移，px→twips）：仅 lv1件11 (+1,+1)
fill_comp = {("lv1", 11): (20, 20)}

piece_bmp, piece_shape = {}, {}
for fam in ("lv1", "lv2", "lv3", "charge", "flame"):
    for idx, rel in piece_png[fam]:
        bid = alloc(); piece_bmp[(fam, idx)] = bid
        new_defs.append(bitmap_item(bid, os.path.join(SRC, rel)))
for fam in ("lv1", "lv2", "lv3", "charge", "flame"):
    for i, tmpl in enumerate(tmpl_shapes[fam], 1):
        idx = i if fam != "flame" else i  # flame i=1..7 对应件6..12 的 png 已按序取
        sid = alloc()
        piece_shape[(fam, i)] = sid
        r = rect_of(tmpl)
        comp = fill_comp.get((fam, i), (0, 0))
        new_defs.append(rect_shape(sid, r["Xmin"], r["Ymin"], r["Xmax"], r["Ymax"],
                                   piece_bmp[(fam, i)], r["Xmin"] + comp[0], r["Ymin"] + comp[1]))
idmap["piece_bmp"] = {"%s_%d" % k: v for k, v in piece_bmp.items()}
idmap["piece_shape"] = {"%s_%d" % k: v for k, v in piece_shape.items()}
print("[6] 特效件: 位图 %d 项 形状 %d 项" % (len(piece_bmp), len(piece_shape)))

# ---------- 7. lv1件7 双填充合成（克隆 1849：底层=金体位图，顶层=画师件7） ----------
gold7_id = alloc()
tmpl1849 = None
for it in tags:
    if it.get("shapeId") == "1849":
        tmpl1849 = copy.deepcopy(it); break
assert tmpl1849 is not None
tmpl1849.set("shapeId", str(gold7_id))
nswap = 0
for f in tmpl1849.iter("item"):
    if f.get("type") == "FILLSTYLE" and f.get("bitmapId") == "1834":
        f.set("bitmapId", str(body_bmp[1]))
        mx = f.find("bitmapMatrix")
        # 内容对位：1834 内容 tl=(0,0)，金体内容 tl=(4,2) → translate += (-80,-40)
        mx.set("translateX", str(int(mx.get("translateX")) - 80))
        mx.set("translateY", str(int(mx.get("translateY")) - 40))
        nswap += 1
    elif f.get("type") == "FILLSTYLE" and f.get("bitmapId") == "1848":
        f.set("bitmapId", str(piece_bmp[("lv1", 7)]))
        nswap += 1
assert nswap == 2, "件7 填充替换数异常: %d" % nswap
new_defs.append(tmpl1849)  # 追加在全部位图/形状之后（其引用的 lv1_7 位图与金体位图均已定义）
piece_shape[("lv1", 7)] = gold7_id
idmap["piece_shape"]["lv1_7"] = gold7_id
print("[7] 件7 合成形状:", gold7_id, "(底层=金体%d 顶层=件7位图%d)" % (body_bmp[1], piece_bmp[("lv1", 7)]))

# ---------- 8. 五条时间轴（镜像本家同级，锚点/RO/音效逐标签照抄） ----------
sprites = {int(it.get("spriteId")): it for it in tags if it.get("spriteId")}
gold_body_sprite, gold_bullet_sprite = {}, {}
timeline_map = {
    1: (1260, {1835: body_shape[1], **{t: piece_shape[("lv1", i)] for i, t in enumerate(tmpl_shapes["lv1"], 1)}}),
    2: (1241, {1864: body_shape[2], **{t: piece_shape[("lv2", i)] for i, t in enumerate(tmpl_shapes["lv2"], 1)}}),
    3: (1224, {1893: body_shape[3], **{t: piece_shape[("lv3", i)] for i, t in enumerate(tmpl_shapes["lv3"], 1)}}),
    4: (1207, {1922: body_shape[4],
               **{t: piece_shape[("charge", i)] for i, t in enumerate(tmpl_shapes["charge"], 1)},
               **{t: piece_shape[("flame", i)] for i, t in enumerate(tmpl_shapes["flame"], 1)}}),
    5: (1204, {1956: body_shape[5],
               **{t: piece_shape[("charge", i)] for i, t in enumerate(tmpl_shapes["charge"], 1)},
               **{t: piece_shape[("flame", i)] for i, t in enumerate(tmpl_shapes["flame"], 1)}}),
}
for lv in (1, 2, 3, 4, 5):
    tmpl_sid, charmap = timeline_map[lv]
    newsid = alloc()
    gold_body_sprite[lv] = newsid
    sp = copy.deepcopy(sprites[tmpl_sid])
    sp.set("spriteId", str(newsid))
    swapped = 0
    for po in sp.find("subTags"):
        if "PlaceObject" in (po.get("type") or ""):
            cid = po.get("characterId")
            if cid is not None and int(cid) in charmap:
                po.set("characterId", str(charmap[int(cid)]))
                swapped += 1
    exp = sum(1 for po in sprites[tmpl_sid].find("subTags")
              if "PlaceObject" in (po.get("type") or "") and po.get("characterId")
              and int(po.get("characterId")) in charmap)
    assert swapped == exp, "lv%d 时间轴替换数 %d != 模板放置数 %d" % (lv, swapped, exp)
    new_defs.append(sp)
    name_pairs.append((newsid, "cutter_gold_lv%d" % lv))
    idmap["body%d_sprite" % lv] = newsid
print("[8] 本体时间轴:", gold_body_sprite)

# ---------- 9. 五颗子弹精灵（共享形状 1991 + 缩放矩阵；黄金系列一律用黄金弹） ----------
bullet_scales = {1: (48 / 104, 30 / 59), 2: (68 / 104, 38 / 59), 3: (83 / 104, 47 / 59),
                 4: (1.0, 1.0), 5: (112 / 104, 64 / 59)}
for lv in (1, 2, 3, 4, 5):
    newsid = alloc()
    gold_bullet_sprite[lv] = newsid
    sx, sy = bullet_scales[lv]
    sp = ET.Element("item", {"type": "DefineSpriteTag", "forceWriteAsLong": "false",
                             "frameCount": "1", "hasEndTag": "true", "spriteId": str(newsid)})
    sub = ET.SubElement(sp, "subTags")
    po = ET.SubElement(sub, "item", {"type": "PlaceObject2Tag", "characterId": "1991", "depth": "1",
        "forceWriteAsLong": "false", "placeFlagHasCharacter": "true", "placeFlagHasClipActions": "false",
        "placeFlagHasClipDepth": "false", "placeFlagHasColorTransform": "false",
        "placeFlagHasMatrix": "true", "placeFlagHasName": "false", "placeFlagHasRatio": "false",
        "placeFlagMove": "false"})
    ET.SubElement(po, "matrix", matrix_attrs(0, 0, 20.0 * sx, 20.0 * sy))
    ET.SubElement(sub, "item", {"type": "ShowFrameTag", "forceWriteAsLong": "false"})
    new_defs.append(sp)
    name_pairs.append((newsid, "cutter_gold_lv%d_bullet" % lv))
    idmap["bullet%d_sprite" % lv] = newsid
print("[9] 子弹精灵:", gold_bullet_sprite, "(全部引用黄金弹形状 1991，缩放=%.4f..)" % bullet_scales[1][0])

# ---------- 10. 注入（定义先于引用：整块插在 1266 之前）+ SymbolClass 追加 ----------
insert_at = None
for i, it in enumerate(tags):
    if it.get("spriteId") == "1266":
        insert_at = i; break
assert insert_at is not None
for offset, d in enumerate(new_defs):
    tags.insert(insert_at + offset, d)
print("[10] 注入 %d 项新定义 @ tags[%d]（sprite 1266 之前）" % (len(new_defs), insert_at))

sc = None
for it in tags:
    if it.get("type") == "SymbolClassTag":
        sc = it; break
assert sc is not None
t_arr = sc.find("tags"); n_arr = sc.find("names")
n_before = len(t_arr)
assert len(n_arr) == n_before
for cid, nm in name_pairs:
    ET.SubElement(t_arr, "item").text = str(cid)
    ET.SubElement(n_arr, "item").text = nm
assert len(t_arr) == n_before + 10 and len(n_arr) == len(t_arr)
print("[10] SymbolClass %d -> %d（+10: %s）" % (n_before, len(t_arr), [n for _, n in name_pairs]))

# ---------- 11. 写盘 ----------
tree.write(OUT_XML, encoding="utf-8", xml_declaration=True)
json.dump(idmap, open("work/idmap.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("[11] 写出", OUT_XML, "新 ID 区间: 2778..%d（共 %d）" % (_next[0] - 1, _next[0] - 2778))
