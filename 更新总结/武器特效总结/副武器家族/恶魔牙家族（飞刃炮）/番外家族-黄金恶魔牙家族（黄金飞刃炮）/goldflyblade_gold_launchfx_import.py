# -*- coding: utf-8 -*-
# 黄金恶魔牙家族（黄金飞刃炮）金色发射特效导入脚本（2026-09-16）
# 画师交付：相关素材\黄金恶魔爪拓展\发射能量1~8.png —— 现行大圈链（2650/2655/2660/2665/2670/2675/2680/2683）
#           的金色重绘版。1~6 号位画布与 alpha 通道与现行渲染逐位一致（maxDiff=0 实测），原矩阵零位移替换；
#           7/8 号位画布不同（93x59 / 95x56 vs 105x43 / 116x46），按 alpha 质心对位换算 translate
#           （换算基准：FFDec 全量精灵导出 render/sprites/DefineSprite_2680|2683/1.png，基准值见 OLD_CENTROIDS）。
# 挂接：391（goldflyBlade_lv1）d17 f3~f10 与 399（goldflyBlade_lv2）d4 f3~f10 共 16 处放置改指新精灵，
#       blend=5 等放置属性原样保留；共享方 882/885/888/891/894/897（flyBlade lv1~6 本体）不受影响。
# 结构：沿守望者 debris3 先例——PNG→DefineBitsLossless2(预乘ARGB fmt5)→供体形状30克隆 1:1 矩形包裹→单帧精灵；
#       每帧 位图+形状+精灵 三件套共 24 项新 ID 2732~2755。
# 铁律：底稿新鲜转储并断言 manifest 哈希；全程单棵 ElementTree。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys, zlib
from PIL import Image
sys.stdout.reconfigure(encoding='utf-8')

TGT_SWF = r"..\swf\sub1130.swf"
OUT_XML = "sub1130-gold-launchfx.xml"
OUT_SWF = "sub1130-gold-launchfx.swf"
FFDEC = r"..\tools\packaging\ffdec\ffdec-cli.exe"
SRC_DIR = r"D:\superalloy\相关素材\黄金恶魔爪拓展"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"

# 大圈链旧角色 → (发射能量帧号, 画布尺寸必须等于旧渲染画布, 旧渲染alpha质心px)
# 1~6 号位新旧画布/alpha 全等 → 质心差恒 0，translate 不动
OLD_CENTROIDS = {
    2650: (1, (51, 34), (22.8, 15.4)),
    2655: (2, (51, 38), (22.9, 16.8)),
    2660: (3, (50, 41), (22.4, 18.3)),
    2665: (4, (48, 48), (22.0, 20.8)),
    2670: (5, (64, 57), (30.7, 27.4)),
    2675: (6, (95, 80), (44.2, 38.7)),
    2680: (7, (105, 43), (50.92155482633439, 20.2548374312392)),
    2683: (8, (116, 46), (52.54851606096782, 21.07913416067446)),
}
BODY_SPRITES = ('391', '399')        # 黄金两级本体（唯一允许改动的两个精灵）
SHARED_USERS = ('882', '885', '888', '891', '894', '897')  # flyBlade lv1~6 本体，只断言不动

# ---------- 0. 底稿哈希断言 ----------
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper(), f"底稿 {actual} != manifest {manifest_line}"
print("底稿哈希断言 PASS:", actual[:8])

tree = ET.parse('sub1130-cur.xml'); root = tree.getroot()
parent = {c: p for p in root.iter() for c in p}

def alpha_centroid(path):
    a = np_arr = Image.open(path).convert('RGBA')
    import numpy as np
    arr = np.array(a); al = arr[..., 3].astype(float); tot = al.sum()
    ys, xs = np.mgrid[0:arr.shape[0], 0:arr.shape[1]]
    return arr.shape[1], arr.shape[0], float((xs * al).sum() / tot), float((ys * al).sum() / tot)

# ---------- 1. ID 分配（含 soundId/fontId 查重） ----------
DEF_ATTRS = ('characterID', 'shapeId', 'spriteId', 'soundId', 'fontId')
used = set()
for it in root.iter('item'):
    for k in DEF_ATTRS:
        v = it.get(k)
        if v and v.isdigit() and int(v) != 65535:
            used.add(int(v))
next_id = max(used) + 1
assert next_id == 2732, f"最大 ID 预期 2731，实际 {next_id - 1}"
print("当前最大角色 ID:", max(used), " 新 ID 从", next_id, "起")

def take_id():
    global next_id
    while next_id in used:
        next_id += 1
    used.add(next_id)
    return next_id

# ---------- 2. PNG -> DefineBitsLossless2 (format 5, 预乘 BGRA) ----------
def lossless2_hex(path):
    img = Image.open(path).convert('RGBA')
    w, h = img.size
    raw = bytearray()
    for r, g, b, a in img.getdata():
        # Lossless2 format5 = 预乘 ARGB（字节序与预乘均经守望者位图29/2714 实证）
        raw += bytes((a, r * a // 255, g * a // 255, b * a // 255))
    comp = zlib.compress(bytes(raw), 9)
    return w, h, comp.hex()

def make_bitmap_elem(cid, path):
    w, h, hexdata = lossless2_hex(path)
    el = ET.Element('item', {'type': 'DefineBitsLossless2Tag', 'forceWriteAsLong': 'true',
                             'characterID': str(cid), 'bitmapFormat': '5',
                             'bitmapWidth': str(w), 'bitmapHeight': str(h),
                             'zlibBitmapData': hexdata})
    return el, w, h

# ---------- 3. 克隆供体形状 30 -> 1:1 矩形形状 ----------
donor = None
for it in root.iter('item'):
    if it.get('shapeId') == '30' and it.get('type') == 'DefineShapeTag':
        donor = it
        break
assert donor is not None

def make_shape_elem(sid, bid, w, h):
    el = copy.deepcopy(donor)
    el.set('shapeId', str(sid))
    W, H = w * 20, h * 20
    b = el.find('shapeBounds')
    for k, v in (('Xmin', 0), ('Ymin', 0), ('Xmax', W), ('Ymax', H), ('nbits', 13)):
        b.set(k, str(v))
    fills = [f for f in el.iter('item') if f.get('type') == 'FILLSTYLE']
    assert len(fills) == 2
    real = fills[1]
    real.set('bitmapId', str(bid))
    bm = real.find('bitmapMatrix')
    bm.set('translateX', '0'); bm.set('translateY', '0')
    bm.set('nTranslateBits', '1')
    recs = el.find('.//shapeRecords')
    items = list(recs)
    sc = items[0]
    sc.set('moveBits', '13'); sc.set('moveDeltaX', str(W)); sc.set('moveDeltaY', str(H))
    e1, e2, e3, e4 = items[1:5]
    for e, attr, val, vert in ((e1, 'deltaX', -W, 'false'), (e2, 'deltaY', -H, 'true'),
                               (e3, 'deltaX', W, 'false'), (e4, 'deltaY', H, 'true')):
        e.set(attr, str(val))
        e.set('numBits', '13'); e.set('vertLineFlag', vert)
    return el

# ---------- 4. 单帧精灵（属性照单帧链精灵 2650 构造） ----------
template = None
for it in root.iter('item'):
    if it.get('spriteId') == '2650' and 'DefineSprite' in (it.get('type') or ''):
        template = it
        break
SPRITE_ATTRS = {k: v for k, v in template.attrib.items() if k not in ('spriteId', 'frameCount')}

def make_sprite_elem(sid, shape_id):
    el = ET.Element('item', dict(SPRITE_ATTRS, spriteId=str(sid), frameCount='1'))
    sub = ET.SubElement(el, 'subTags')
    po = ET.SubElement(sub, 'item', {'type': 'PlaceObject2Tag', 'characterId': str(shape_id), 'depth': '1',
                                     'placeFlagHasCharacter': 'true', 'placeFlagHasClipActions': 'false',
                                     'placeFlagHasClipDepth': 'false', 'placeFlagHasColorTransform': 'false',
                                     'placeFlagHasMatrix': 'true', 'placeFlagHasName': 'false',
                                     'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'})
    ET.SubElement(po, 'matrix', {'type': 'MATRIX', 'hasRotate': 'false', 'hasScale': 'false',
                                 'nRotateBits': '0', 'nScaleBits': '0', 'nTranslateBits': '0',
                                 'translateX': '0', 'translateY': '0'})
    ET.SubElement(sub, 'item', {'type': 'ShowFrameTag'})
    return el

# ---------- 5. 生成 8 套（位图/形状/精灵）+ 换算矩阵 ----------
sprites_all = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
# 改动前引用快照（断言共享方不受影响）
def ref_map():
    m = {}
    for sid, sp in sprites_all.items():
        for po in sp.iter('item'):
            cid = po.get('characterId')
            if cid and cid.isdigit() and int(cid) in OLD_CENTROIDS:
                m.setdefault(sid, []).append(int(cid))
    return m
before_refs = ref_map()

new_elems = []
char_to_newspr = {}
for old_cid in sorted(OLD_CENTROIDS):
    idx, (ow, oh), (ocx, ocy) = OLD_CENTROIDS[old_cid]
    bmp_id, shp_id, spr_id = take_id(), take_id(), take_id()
    src = rf"{SRC_DIR}\发射能量{idx}.png"
    nw, nh, ncx, ncy = alpha_centroid(src)
    # 1~6 号位画布必须与旧渲染全等；7/8 号位为画师新构图，只断言尺寸与取证时一致
    if idx <= 6:
        assert (nw, nh) == (ow, oh), f"能量{idx} 画布 {(nw, nh)} != 旧 {ow}x{oh}"
    dtx = round((ocx - ncx) * 20)
    dty = round((ocy - ncy) * 20)
    b_el, w, h = make_bitmap_elem(bmp_id, src)
    s_el = make_shape_elem(shp_id, bmp_id, w, h)
    p_el = make_sprite_elem(spr_id, shp_id)
    new_elems += [b_el, s_el, p_el]
    char_to_newspr[old_cid] = (spr_id, dtx, dty)
    print(f"发射能量{idx}: bitmap={bmp_id}({w}x{h}) shape={shp_id} sprite={spr_id} ← char {old_cid} translateΔ=({dtx},{dty})")

# 插入定义：位于 391 定义之前（定义先于引用）
anchor = sprites_all['391']
anchor_parent = parent[anchor]
ins = list(anchor_parent).index(anchor)
for i, el in enumerate(new_elems):
    anchor_parent.insert(ins + i, el)
print(f"已插入 {len(new_elems)} 项定义（锚点 sprite391 之前）")

# ---------- 6. 时间轴改指 ----------
changed = {}
for sid in BODY_SPRITES:
    sp = sprites_all[sid]
    n = 0
    for po in sp.iter('item'):
        cid = po.get('characterId')
        if cid and cid.isdigit() and int(cid) in char_to_newspr:
            spr_id, dtx, dty = char_to_newspr[int(cid)]
            po.set('characterId', str(spr_id))
            if dtx or dty:
                m = po.find('matrix')
                assert m is not None
                m.set('translateX', str(int(m.get('translateX')) + dtx))
                m.set('translateY', str(int(m.get('translateY')) + dty))
            n += 1
    changed[sid] = n
    print(f"sprite {sid}: 改指 {n} 处")
assert changed == {'391': 8, '399': 8}, changed

# ---------- 7. 回归断言：其余精灵引用零变化 ----------
after_refs = ref_map()
for sid, refs in before_refs.items():
    if sid in BODY_SPRITES:
        assert sid not in after_refs, f"{sid} 仍有旧链引用"
    else:
        assert after_refs.get(sid) == refs, f"{sid} 引用被意外改动"
shared_ok = all(after_refs.get(s) == before_refs[s] for s in SHARED_USERS)
print("共享方 flyBlade lv1~6 引用断言:", "PASS" if shared_ok else "FAIL")
assert shared_ok

# ---------- 8. 写出 ----------
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
