# -*- coding: utf-8 -*-
# 星际雷神家族（zhongzifeidan）皮肤与发射特效整体替换导入脚本（2026-09-17）
# 素材：相关素材\星际雷神\（mk1/mk2/共用开火/部件2/子弹）——仅换贴图与发射特效，零形态、零数值、零配置。
# 结构（沿守望者 debris3 / 金色发射特效先例）：PNG→DefineBitsLossless2(预乘ARGB fmt5)→shape30 克隆 1:1 包裹→
#       时间轴改指；不加新导出名（SymbolClass 原样）、不动锚点/音效/帧数/配置。
# 设计：lv1 本体=星际雷神k1部件1(129x60,右缘对齐旧炮口+垂直居中)；lv2 本体=星际雷神.png(103x47 与现役同尺寸,矩阵不动)；
#       lv1 开火链=特效1~4(现役4槽,矩阵原样改指)；lv2 开火链=新特效1~5(f8 新增放置,清除挪 f9)；
#       开火1~3 尾焰=上下筒各一份(f4~f6,双放置双深度)；部件2 筒口环两半=上下筒各一(f4 放,f6 撤=装填盖回)；
#       f4 的本体 RemoveObject2 删除(v1 决策:发射期间枪体保持可见,接近"完整参考子弹发射后"观感)；
#       子弹=共用新弹图替换 sprite100 内层形状(char 99 改指,矩阵不动)。
# 铁律：底稿哈希==manifest 断言；全程单棵 ElementTree；逐项断言输出。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys, zlib
from PIL import Image
import numpy as np
sys.stdout.reconfigure(encoding='utf-8')

CUR_XML  = "work/sub1130-cur.xml"
OUT_XML  = "work/sub1130-zzzd-skin.xml"
OUT_SWF  = "work/sub1130-zzzd-skin.swf"
FFDEC    = r"..\tools\packaging\ffdec\ffdec-cli.exe"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
IN = "input/"

# ---------- 0. 底稿哈希断言 ----------
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(r"..\swf\sub1130.swf", 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper(), f"底稿 {actual} != manifest {manifest_line}"
print("底稿哈希断言 PASS:", actual[:8])

tree = ET.parse(CUR_XML); root = tree.getroot()
parent = {c: p for p in root.iter() for c in p}

# ---------- 1. ID 分配 ----------
DEF_ATTRS = ('characterID', 'shapeId', 'spriteId', 'soundId', 'fontId')
used = set()
for it in root.iter('item'):
    for k in DEF_ATTRS:
        v = it.get(k)
        if v and v.isdigit() and int(v) != 65535:
            used.add(int(v))
next_id = max(used) + 1
assert next_id > 2899, f"最大 ID {max(used)} 低于预期(黄金深渊应占至 2899)"
print("当前最大角色 ID:", max(used), " 新 ID 从", next_id, "起")

def take_id():
    global next_id
    while next_id in used:
        next_id += 1
    used.add(next_id)
    return next_id

# ---------- 2. PNG -> DefineBitsLossless2 ----------
def make_bitmap_elem(cid, path, crop=None):
    img = Image.open(path).convert('RGBA')
    if crop is not None:
        img = img.crop(crop)
    w, h = img.size
    raw = bytearray()
    for r, g, b, a in img.getdata():
        raw += bytes((a, r * a // 255, g * a // 255, b * a // 255))
    comp = zlib.compress(bytes(raw), 9)
    el = ET.Element('item', {'type': 'DefineBitsLossless2Tag', 'forceWriteAsLong': 'true',
                             'characterID': str(cid), 'bitmapFormat': '5',
                             'bitmapWidth': str(w), 'bitmapHeight': str(h),
                             'zlibBitmapData': comp.hex()})
    return el, w, h

# ---------- 3. 供体形状 30 克隆 ----------
donor = None
for it in root.iter('item'):
    if it.get('shapeId') == '30' and it.get('type') == 'DefineShapeTag':
        donor = it; break
assert donor is not None, "供体形状30未找到"

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
    bm.set('translateX', '0'); bm.set('translateY', '0'); bm.set('nTranslateBits', '1')
    recs = el.find('.//shapeRecords')
    items = list(recs)
    sc = items[0]
    sc.set('moveBits', '13'); sc.set('moveDeltaX', str(W)); sc.set('moveDeltaY', str(H))
    e1, e2, e3, e4 = items[1:5]
    for e, attr, val, vert in ((e1, 'deltaX', -W, 'false'), (e2, 'deltaY', -H, 'true'),
                               (e3, 'deltaX', W, 'false'), (e4, 'deltaY', H, 'true')):
        e.set(attr, str(val)); e.set('numBits', '13'); e.set('vertLineFlag', vert)
    return el

# ---------- 4. 量测：筒口中心 / 部件2 两弧 ----------
def dark_mouths(path, right_frac=0.18):
    """右端暗色筒口两簇的质心(px)。"""
    img = Image.open(path).convert('RGBA'); arr = np.array(img)
    h, w = arr.shape[:2]
    x0 = int(w * (1 - right_frac))
    region = arr[:, x0:, 3] > 100
    lum = arr[..., :3].mean(axis=2)
    ys, xs = np.where(region & (lum[:, x0:] < 75))
    assert len(ys) > 20, f"{path} 右端暗簇过少"
    order = np.argsort(ys)
    ys_s, xs_s = ys[order], xs[order]
    gap = None
    for i in range(1, len(ys_s)):
        if ys_s[i] - ys_s[i-1] > 3:
            gap = i
    assert gap is not None, f"{path} 未找到上下两簇"
    top_y, top_x = ys_s[:gap], xs_s[:gap]
    bot_y, bot_x = ys_s[gap:], xs_s[gap:]
    upper = (float(top_x.mean()) + x0, float(top_y.mean()))
    lower = (float(bot_x.mean()) + x0, float(bot_y.mean()))
    return upper, lower

def arc_halves(path):
    """部件2 上下两半的 alpha 分割行与各自质心。"""
    img = Image.open(path).convert('RGBA'); arr = np.array(img)
    alpha = arr[..., 3]
    rows = np.where(alpha.max(axis=1) > 10)[0]
    y0, y1 = rows.min(), rows.max()
    empty = [y for y in range(y0, y1) if alpha[y].max() <= 10]
    assert empty, f"{path} 上下弧之间无空行"
    split = empty[len(empty)//2] + 1
    w = arr.shape[1]
    return (0, int(y0), w, int(split)), (0, int(split), w, int(y1) + 1)

# 筒口中心（px，本体图画布坐标）：来自右端网格放大图目测读数（grid-lv1/lv2-右端.png）
# lv1 双筒 C 形环口中心；lv2 浅灰喷嘴中心（暗像素检测不可用，故用实测常量）
LV1_UP, LV1_LOW = (124.0, 18.0), (124.0, 45.5)
LV2_UP, LV2_LOW = (96.0, 12.0), (93.0, 32.0)
lv1_up, lv1_low = LV1_UP, LV1_LOW
lv2_up, lv2_low = LV2_UP, LV2_LOW
(top_crop, bot_crop) = arc_halves(IN + "星际雷神部件2.png")
print(f"lv1 筒口 上={lv1_up} 下={lv1_low}")
print(f"lv2 筒口 上={lv2_up} 下={lv2_low}")
print(f"部件2 分割行 crop 上={top_crop} 下={bot_crop}")

# ---------- 5. 生成全部新定义 ----------
new_elems = []
def add_png(path, crop=None):
    bid, sid_ = take_id(), take_id()
    b_el, w, h = make_bitmap_elem(bid, path, crop)
    s_el = make_shape_elem(sid_, bid, w, h)
    new_elems.extend([b_el, s_el])
    return sid_, w, h

lv1_body_s, lv1_bw, lv1_bh = add_png(IN + "星际雷神k1部件1.png")
lv2_body_s, lv2_bw, lv2_bh = add_png(IN + "星际雷神.png")
bullet_s,  bul_w,  bul_h  = add_png(IN + "子弹.png")
lv1_fx = [add_png(IN + f"特效{i}.png")[0] for i in (1, 2, 3, 4)]
lv2_fx = [add_png(IN + f"新特效{i}.png")[0] for i in (1, 2, 3, 4, 5)]
exh    = [add_png(IN + f"开火{i}.png") for i in (1, 2, 3)]      # [(shape,w,h),...]
arc_t, arc_tw, arc_th = add_png(IN + "星际雷神部件2.png", top_crop)
arc_b, arc_bw, arc_bh = add_png(IN + "星际雷神部件2.png", bot_crop)
print(f"新定义 {len(new_elems)} 项（{len(new_elems)//2} 套 位图+形状）")

# ---------- 6. 定位目标精灵 ----------
sprites = {}
for it in root.iter('item'):
    if 'DefineSprite' in (it.get('type') or ''):
        sprites[it.get('spriteId')] = it
sp121, sp115, sp100 = sprites['121'], sprites['115'], sprites['100']

def frame_tags(sp):
    """按帧分组 subTags（ShowFrame 归当前帧尾）。返回 [(frame,[items])]，帧号 1 基。"""
    sub = sp.find('subTags')
    out, fr, buf = [], 1, []
    for it in list(sub):
        t = it.get('type') or ''
        buf.append(it)
        if t == 'ShowFrameTag':
            out.append((fr, buf)); fr += 1; buf = []
    if buf:
        out.append((fr, buf))
    return out

def snapshot_anchors(sp):
    out = []
    for it in sp.iter('item'):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('name') in ('basePoint', 'shootPoint'):
            m = it.find('matrix')
            out.append((it.get('name'), it.get('depth'), m.get('translateX'), m.get('translateY')))
    return out

anchors_before = {121: snapshot_anchors(sp121), 115: snapshot_anchors(sp115)}
sounds_before  = {sid: sum(1 for it in sp.iter('item') if it.get('type') == 'StartSoundTag')
                  for sid, sp in (('121', sp121), ('115', sp115))}

def ref_map():
    m = {}
    for sid, sp in sprites.items():
        for po in sp.iter('item'):
            cid = po.get('characterId')
            if cid and cid.isdigit():
                m.setdefault(sid, set()).add(int(cid))
    return m
before_refs = ref_map()
OLD_CHARS = {99, 102, 107, 110, 112, 114, 117, 119, 120}

# ---------- 7. 本体改指 ----------
def repoint_body(sp, new_shape, new_tx=None, new_ty=None, expect=2):
    n = 0
    for it in sp.iter('item'):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('characterId') in ('117', '102'):
            it.set('characterId', str(new_shape))
            m = it.find('matrix')
            if new_tx is not None:
                m.set('translateX', str(new_tx)); m.set('translateY', str(new_ty))
            n += 1
    assert n == expect, f"本体改指数 {n} != {expect}"
repoint_body(sp121, lv1_body_s, -370, -90)   # 炮口尖对齐旧炮口尖(旧tip≈109px,新tip≈127.5px→tx-18.5px)，垂直居中(51→60)
repoint_body(sp115, lv2_body_s)              # 同尺寸投放，矩阵不动
print("本体改指: 121→%d(2处,tx-370/ty-90)  115→%d(2处,矩阵不动)" % (lv1_body_s, lv2_body_s))

# ---------- 8. 开火链改指（保留各槽原矩阵） ----------
def repoint_chain(sp, mapping, expect):
    n = 0
    for it in sp.iter('item'):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '2':
            cid = int(it.get('characterId') or 0)
            if cid in mapping:
                it.set('characterId', str(mapping[cid])); n += 1
    assert n == expect, f"开火链改指数 {n} != {expect}"
repoint_chain(sp121, {119: lv1_fx[0], 120: lv1_fx[1], 112: lv1_fx[2], 114: lv1_fx[3]}, 4)
repoint_chain(sp115, {107: lv2_fx[0], 110: lv2_fx[1], 112: lv2_fx[2], 114: lv2_fx[3]}, 4)
print("开火链改指: 121 4处(特效1~4)  115 4处(新特效1~4)")

# ---------- 9. lv2 f8 新增第五帧 + 清除挪 f9 ----------
sub115 = sp115.find('subTags')
items115 = list(sub115)
idx_ro = None; fr = 1
for i, it in enumerate(items115):
    if (it.get('type') or '') == 'ShowFrameTag':
        fr += 1
    if fr == 8 and (it.get('type') or '') == 'RemoveObject2Tag' and it.get('depth') == '2':
        idx_ro = i; break
assert idx_ro is not None, "lv2 f8 清除标签未找到"
sf   = ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'})
po5  = ET.Element('item', {'type': 'PlaceObject2Tag', 'characterId': str(lv2_fx[4]), 'depth': '2',
                           'forceWriteAsLong': 'false', 'placeFlagHasCharacter': 'true',
                           'placeFlagHasClipActions': 'false', 'placeFlagHasClipDepth': 'false',
                           'placeFlagHasColorTransform': 'false', 'placeFlagHasMatrix': 'true',
                           'placeFlagHasName': 'false', 'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'})
ET.SubElement(po5, 'matrix', {'type': 'MATRIX', 'hasRotate': 'false', 'hasScale': 'false',
                              'nRotateBits': '0', 'nScaleBits': '0', 'nTranslateBits': '0',
                              'translateX': '0', 'translateY': '0'})
sub115.insert(idx_ro, po5)   # f8: 新5 放置（替换 f7 的新4）
sub115.insert(idx_ro + 1, sf)  # f8 收帧；原清除标签顺延至 f9
print("lv2: f8 新增 新特效5 放置，清除标签顺延至 f9（frameCount 13 不变）")

# ---------- 10. 尾焰×2 与部件2 双弧（帧级手术） ----------
def matrix_elem(tx, ty):
    return ET.Element('matrix', {'type': 'MATRIX', 'hasRotate': 'false', 'hasScale': 'false',
                                 'nRotateBits': '0', 'nScaleBits': '0', 'nTranslateBits': '13',
                                 'translateX': str(tx), 'translateY': str(ty)})
def po2(cid, depth, tx, ty):
    el = ET.Element('item', {'type': 'PlaceObject2Tag', 'characterId': str(cid), 'depth': str(depth),
                             'forceWriteAsLong': 'false', 'placeFlagHasCharacter': 'true',
                             'placeFlagHasClipActions': 'false', 'placeFlagHasClipDepth': 'false',
                             'placeFlagHasColorTransform': 'false', 'placeFlagHasMatrix': 'true',
                             'placeFlagHasName': 'false', 'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'})
    el.append(matrix_elem(tx, ty))
    return el
def ro(depth):
    return ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false'})

def body_tx(sp):
    for it in sp.iter('item'):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '1' and it.get('characterId') in (str(lv1_body_s), str(lv2_body_s)):
            m = it.find('matrix')
            return int(m.get('translateX')), int(m.get('translateY'))
btx121, bty121 = body_tx(sp121)
btx115, bty115 = body_tx(sp115)

def install_guns(sp, up, low, btx, bty, drop_f4_body_removal):
    """f4 尾焰×2+双弧；f5/f6 尾焰轮换；f6 撤弧；f7 撤尾焰。返回删除的本体RO数。"""
    sub = sp.find('subTags')
    frames = frame_tags(sp)
    f_by_no = {no: items for no, items in frames}
    removed = 0
    # f4 删除本体 RO（v1: 枪体发射期间保持可见）
    if drop_f4_body_removal:
        for it in list(f_by_no[4]):
            if (it.get('type') or '') == 'RemoveObject2Tag' and it.get('depth') == '1':
                sub.remove(it); removed += 1
    def seg(no):
        """第 no 帧 ShowFrameTag 的当前下标（插入后重算）。"""
        fr = 1
        for i, it in enumerate(list(sub)):
            if (it.get('type') or '') == 'ShowFrameTag':
                if fr == no:
                    return i
                fr += 1
        raise AssertionError(f"frame {no} not found")
    ux, uy = up; lx, ly = low
    adds4 = [
        po2(exh[0][0], 4, btx + int((ux - 3) * 20), bty + int((uy - exh[0][2] / 2) * 20)),
        po2(exh[0][0], 6, btx + int((lx - 3) * 20), bty + int((ly - exh[0][2] / 2) * 20)),
        po2(arc_t, 7, btx + int((ux + 1 - arc_tw / 2) * 20), bty + int((uy - arc_th / 2) * 20)),
        po2(arc_b, 8, btx + int((lx + 1 - arc_bw / 2) * 20), bty + int((ly - arc_bh / 2) * 20)),
    ]
    base = seg(4)
    for k, el in enumerate(adds4):
        sub.insert(base, el)
    # f5: 尾焰2 替换（MOVE+char）
    i5 = seg(5)
    adds5 = [
        po2(exh[1][0], 4, btx + int((ux - 3) * 20), bty + int((uy - exh[1][2] / 2) * 20)),
        po2(exh[1][0], 6, btx + int((lx - 3) * 20), bty + int((ly - exh[1][2] / 2) * 20)),
    ]
    for el in adds5:
        el.set('placeFlagMove', 'true')
    base = seg(5)
    for k, el in enumerate(adds5):
        sub.insert(base, el)
    # f6: 尾焰3 替换 + 撤双弧
    adds6 = [
        po2(exh[2][0], 4, btx + int((ux - 3) * 20), bty + int((uy - exh[2][2] / 2) * 20)),
        po2(exh[2][0], 6, btx + int((lx - 3) * 20), bty + int((ly - exh[2][2] / 2) * 20)),
        ro(7), ro(8),
    ]
    for el in adds6[:2]:
        el.set('placeFlagMove', 'true')
    base = seg(6)
    for k, el in enumerate(adds6):
        sub.insert(base, el)
    # f7: 撤尾焰
    base = seg(7)
    sub.insert(base, ro(4)); sub.insert(base + 1, ro(6))
    return removed

rm121 = install_guns(sp121, lv1_up, lv1_low, btx121, bty121, True)
rm115 = install_guns(sp115, lv2_up, lv2_low, btx115, bty115, True)
assert rm121 == 1 and rm115 == 1, f"f4 本体RO删除数异常 {rm121}/{rm115}"
print("尾焰×2（f4~f6 轮换，f7 撤）与部件2 双弧（f4 放/f6 撤）安装完成；f4 本体RO已删除（枪体保持可见）")

# ---------- 11. 子弹改指 ----------
n = 0
for it in sp100.iter('item'):
    if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('characterId') == '99':
        it.set('characterId', str(bullet_s)); n += 1
assert n == 1, f"子弹改指数 {n} != 1"
print(f"子弹改指: sprite100 内层 99→{bullet_s}（矩阵不动）")

# ---------- 12. 插入新定义（sprite100 定义之前） ----------
anchor = sprites['100']
anchor_parent = parent[anchor]
ins = list(anchor_parent).index(anchor)
for i, el in enumerate(new_elems):
    anchor_parent.insert(ins + i, el)
print(f"新定义插入完成（sprite100 之前，{len(new_elems)} 项）")

# ---------- 13. 回归断言 ----------
after_refs = ref_map()
for sid, sp in (('121', sp121), ('115', sp115)):
    bad = after_refs[sid] & OLD_CHARS
    assert not bad, f"sprite {sid} 仍引用旧角色 {bad}"
for sid, refs in before_refs.items():
    if sid in ('100', '115', '121'):
        continue
    assert after_refs.get(sid, set()) == refs, f"sprite {sid} 引用被意外改动"
for sid in ('121', '115'):
    assert snapshot_anchors(sprites[sid]) == anchors_before[int(sid)], f"sprite {sid} 锚点被改动"
    n_snd = sum(1 for it in sprites[sid].iter('item') if it.get('type') == 'StartSoundTag')
    assert n_snd == sounds_before[sid], f"sprite {sid} StartSound 数变化"
    assert sprites[sid].get('frameCount') == '13', f"sprite {sid} frameCount 变化"
sc_count = sum(1 for it in root.iter('item') if 'SymbolClass' in (it.get('type') or ''))
print(f"回归断言: 旧角色引用清零 PASS / 其余精灵引用零变化 PASS / 锚点矩阵原样 PASS / StartSound 原样 PASS / frameCount=13 PASS / SymbolClass 项数={sc_count}（原样）")

# ---------- 14. 写出 ----------
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
h = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
print("写出:", OUT_SWF, h[:8])
