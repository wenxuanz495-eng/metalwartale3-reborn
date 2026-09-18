# -*- coding: utf-8 -*-
# 星际雷神 lv2（星际雷神MK2）V2 修订脚本（2026-09-17）
# 用户裁定 V1 半对，仅修 V2：
#   ① lv2 本体弃用 星际雷神.png（2902/2903，原武器参考图），改用 星际雷神部件1.png（空膛枪体 139x67）；
#   ② 常态待机=部件1+子弹×2 拼合（弹头露出枪缘 6px＝完整参考 145x67 的来历，模板匹配色差 0.04 实证）——
#      待机导弹层 f1 放置 / f4 撤走（出膛，筒口露出）/ f6 放回（装填），复用共用弹形状 2905；
#   ③ 双尾焰/部件2 双弧/新特效槽矩阵全部按新本体几何重定位（本体 tx-700/ty-200：新筒口对齐现役 shootPoint x≈102px）。
# lv1 不动（用户：V1 半对，待用户解释后另行维修）。
# 铁律：底稿哈希断言；全程单棵 ElementTree；逐项断言。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys, zlib
from PIL import Image
sys.stdout.reconfigure(encoding='utf-8')

CUR_SWF  = r"..\swf\sub1130.swf"
CUR_XML  = "work/sub1130-v1.xml"
OUT_XML  = "work/sub1130-v2.xml"
OUT_SWF  = "work/sub1130-v2.swf"
FFDEC    = r"..\tools\packaging\ffdec\ffdec-cli.exe"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
SRC_P1   = "input/星际雷神部件1.png"

# ---------- 0. 底稿新鲜转储 + 哈希断言（920B4611） ----------
import re
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() == "920B4611E6D9586A03EAF36B73F3180CA83F1FD37C5B315713357A1654971959", f"底稿 {actual[:8]} 非 V1 终态"
print("底稿哈希断言 PASS:", actual[:8])
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, CUR_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr

tree = ET.parse(CUR_XML); root = tree.getroot()
parent = {c: p for p in root.iter() for c in p}

# ---------- 1. 新 ID：部件1 位图+形状 ----------
DEF_ATTRS = ('characterID', 'shapeId', 'spriteId', 'soundId', 'fontId')
used = set()
for it in root.iter('item'):
    for k in DEF_ATTRS:
        v = it.get(k)
        if v and v.isdigit() and int(v) != 65535:
            used.add(int(v))
assert max(used) == 2933, f"最大 ID {max(used)} != 2933"
nid = max(used) + 1
P1_BMP, P1_SHAPE = nid, nid + 1
print(f"部件1 新定义: 位图={P1_BMP} 形状={P1_SHAPE}")

img = Image.open(SRC_P1).convert('RGBA')
w, h = img.size
assert (w, h) == (139, 67), f"部件1 尺寸 {(w,h)} 异常"
raw = bytearray()
for r_, g_, b_, a_ in img.getdata():
    raw += bytes((a_, r_ * a_ // 255, g_ * a_ // 255, b_ * a_ // 255))
b_el = ET.Element('item', {'type': 'DefineBitsLossless2Tag', 'forceWriteAsLong': 'true',
                           'characterID': str(P1_BMP), 'bitmapFormat': '5',
                           'bitmapWidth': str(w), 'bitmapHeight': str(h),
                           'zlibBitmapData': zlib.compress(bytes(raw), 9).hex()})
donor = None
for it in root.iter('item'):
    if it.get('shapeId') == '30' and it.get('type') == 'DefineShapeTag':
        donor = it; break
assert donor is not None
s_el = copy.deepcopy(donor)
s_el.set('shapeId', str(P1_SHAPE))
W, H = w * 20, h * 20
b = s_el.find('shapeBounds')
for k2, v2 in (('Xmin', 0), ('Ymin', 0), ('Xmax', W), ('Ymax', H), ('nbits', 13)):
    b.set(k2, str(v2))
fills = [f for f in s_el.iter('item') if f.get('type') == 'FILLSTYLE']
assert len(fills) == 2
fills[1].set('bitmapId', str(P1_BMP))
bm = fills[1].find('bitmapMatrix')
bm.set('translateX', '0'); bm.set('translateY', '0'); bm.set('nTranslateBits', '1')
recs = s_el.find('.//shapeRecords')
items = list(recs)
items[0].set('moveBits', '13'); items[0].set('moveDeltaX', str(W)); items[0].set('moveDeltaY', str(H))
e1, e2, e3, e4 = items[1:5]
for e, attr, val, vert in ((e1, 'deltaX', -W, 'false'), (e2, 'deltaY', -H, 'true'),
                           (e3, 'deltaX', W, 'false'), (e4, 'deltaY', H, 'true')):
    e.set(attr, str(val)); e.set('numBits', '13'); e.set('vertLineFlag', vert)

sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
anchor = sprites['100']
ap = parent[anchor]
ins = list(ap).index(anchor)
ap.insert(ins, b_el); ap.insert(ins + 1, s_el)
print("部件1 定义插入完成（sprite100 之前）")

# ---------- 2. sprite115 手术 ----------
sp115 = sprites['115']
BODY_TX, BODY_TY = -700, -200          # 新筒口(部件1 本地 x≈137)对齐现役 shootPoint x≈102px；垂直居中 47→67
MOUTH_UP, MOUTH_LOW = (137.0, 22.5), (136.0, 51.5)   # 部件1 本地坐标（导弹匹配+网格目测）
MISSILE_UP = (93, 16)                   # 模板匹配色差 0.04
MISSILE_LOW = (92, 45)
BULLET_SHAPE = 2905                     # 共用弹形状（与待机导弹同图，复用）

sub = sp115.find('subTags')
def frames_map():
    out = {}; fr = 1; cur = []
    for it in list(sub):
        cur.append(it)
        if (it.get('type') or '') == 'ShowFrameTag':
            out[fr] = cur; fr += 1; cur = []
    if cur: out[fr] = cur
    return out
def seg(no):
    fr = 1
    for i, it in enumerate(list(sub)):
        if (it.get('type') or '') == 'ShowFrameTag':
            if fr == no: return i
            fr += 1
    raise AssertionError(no)

# 2a. 本体改指 + 矩阵
n = 0
for it in sp115.iter('item'):
    if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('characterId') == '2903' and it.get('depth') == '1':
        it.set('characterId', str(P1_SHAPE))
        m = it.find('matrix')
        m.set('translateX', str(BODY_TX)); m.set('translateY', str(BODY_TY))
        n += 1
assert n == 2, f"本体改指 {n} != 2"
print("lv2 本体 → 部件1（f1/f6，tx-700/ty-200）")

# 2b. 待机导弹层 d9/d10：f1 放、f4 撤、f6 回
def po2(cid, depth, tx, ty):
    el = ET.Element('item', {'type': 'PlaceObject2Tag', 'characterId': str(cid), 'depth': str(depth),
                             'forceWriteAsLong': 'false', 'placeFlagHasCharacter': 'true',
                             'placeFlagHasClipActions': 'false', 'placeFlagHasClipDepth': 'false',
                             'placeFlagHasColorTransform': 'false', 'placeFlagHasMatrix': 'true',
                             'placeFlagHasName': 'false', 'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'})
    el.append(ET.Element('matrix', {'type': 'MATRIX', 'hasRotate': 'false', 'hasScale': 'false',
                                    'nRotateBits': '0', 'nScaleBits': '0', 'nTranslateBits': '13',
                                    'translateX': str(tx), 'translateY': str(ty)}))
    return el
def ro(depth):
    return ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false'})

mux = (BODY_TX + MISSILE_UP[0] * 20, BODY_TY + MISSILE_UP[1] * 20)
mlx = (BODY_TX + MISSILE_LOW[0] * 20, BODY_TY + MISSILE_LOW[1] * 20)
adds1 = [po2(BULLET_SHAPE, 9, *mux), po2(BULLET_SHAPE, 10, *mlx)]
base = seg(1)
for el in adds1: sub.insert(base, el)
base = seg(4)
sub.insert(base, ro(9)); sub.insert(base + 1, ro(10))
base = seg(6)
sub.insert(base, po2(BULLET_SHAPE, 9, *mux)); sub.insert(base + 1, po2(BULLET_SHAPE, 10, *mlx))
print(f"待机导弹层: f1 放 d9/d10（上{mux}/下{mlx}），f4 撤（出膛），f6 回（装填）")

# 2c. 尾焰/双弧矩阵按新筒口重定位
def flame_pos(fno, mouth_y, fh):
    mx = MOUTH_UP[0] if fno == 'u' else MOUTH_LOW[0]
    return (BODY_TX + int((mx - 3) * 20), BODY_TY + int((mouth_y - fh / 2) * 20))
EXH = {4: (2924, 34, 21, 'u', 22.5, 2924, 34, 21, 'l', 51.5)}  # 占位，实际按下表
flame_tbl = [  # (frame, depth, shape, w, h, mouth)
    (4, 4, 2925, 34, 21, MOUTH_UP[1]), (4, 6, 2925, 34, 21, MOUTH_LOW[1]),
    (5, 4, 2927, 35, 17, MOUTH_UP[1]), (5, 6, 2927, 35, 17, MOUTH_LOW[1]),
    (6, 4, 2929, 48, 14, MOUTH_UP[1]), (6, 6, 2929, 48, 14, MOUTH_LOW[1]),
]
found = 0
for no, items in frames_map().items():
    for it in items:
        if (it.get('type') or '') != 'PlaceObject2Tag': continue
        d = it.get('depth'); cid = it.get('characterId')
        if d in ('4', '6') and cid in ('2925', '2927', '2929'):
            for fno, dd, shp, fw, fh, my in flame_tbl:
                if int(no) == fno and d == str(dd) and cid == str(shp):
                    mx = MOUTH_UP[0] if dd == 4 else MOUTH_LOW[0]
                    m = it.find('matrix')
                    m.set('translateX', str(BODY_TX + int((mx - 3) * 20)))
                    m.set('translateY', str(BODY_TY + int((my - fh / 2) * 20)))
                    found += 1
assert found == 6, f"尾焰矩阵重定位 {found} != 6"
arc_tbl = {(4, '7'): (MOUTH_UP[0] - 4.5, MOUTH_UP[1] - 12),   # arc_t 9x24
           (4, '8'): (MOUTH_LOW[0] - 4.5, MOUTH_LOW[1] - 11.5)}  # arc_b 9x23
found = 0
for no, items in frames_map().items():
    for it in items:
        if (it.get('type') or '') != 'PlaceObject2Tag': continue
        key = (int(no), it.get('depth'))
        if key in arc_tbl and it.get('characterId') in ('2931', '2933'):
            ax, ay = arc_tbl[key]
            m = it.find('matrix')
            m.set('translateX', str(BODY_TX + int(ax * 20)))
            m.set('translateY', str(BODY_TY + int(ay * 20)))
            found += 1
assert found == 2, f"双弧矩阵重定位 {found} != 2"
print("尾焰 6 处 / 双弧 2 处矩阵已按新筒口重定位")

# 2d. 新特效槽（d2）随本体平移
n = 0
for no, items in frames_map().items():
    for it in items:
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '2' and it.get('characterId') in ('2915','2917','2919','2921','2923'):
            m = it.find('matrix')
            if m is not None:
                m.set('translateX', str(int(m.get('translateX')) + BODY_TX))
                m.set('translateY', str(int(m.get('translateY')) + BODY_TY))
                n += 1
print(f"新特效槽平移 {n} 处（随本体 tx-700/ty-200）")

# ---------- 3. 断言与写出 ----------
anchors = []
for it in sp115.iter('item'):
    if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('name') in ('basePoint', 'shootPoint'):
        m = it.find('matrix')
        anchors.append((it.get('name'), m.get('translateX'), m.get('translateY')))
assert len(anchors) == 2
assert not any(it.get('characterId') == '2903' for it in sp115.iter('item')), "仍引用 2903"
cnt_121 = sum(1 for it in sprites['121'].iter('item') if (it.get('type') or '') == 'PlaceObject2Tag')
print(f"断言: 锚点原样（{anchors}）/ 2903 引用清零 / sprite121 未触碰（PO2 数={cnt_121}）")
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
