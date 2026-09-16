# -*- coding: utf-8 -*-
# 星际雷神 V3 修订脚本（2026-09-17）：待机导弹层压到枪体下层 + MK1 补待机导弹
# 用户实机反馈：①lv2 待机导弹不能在枪体上层（整条弹身盖在枪上）——必须在下层，枪体遮住弹身只露弹头；
#              ②lv1（星际雷神1）同规则补待机导弹（V1/V2 均无），同样在下层。
# 解法＝lv2/lv1 两级深度整体重排（z 序：导弹 < 本体 < 特效链 < 尾焰/双弧；锚点按名读取与深度无关）：
#   d1=上导弹(2905) d2=下导弹(2905) d3=本体 d4=basePoint d5=shootPoint d6=特效链 d7/d8=尾焰 d9/d10=双弧
# lv1 新增待机导弹：k1部件1 筒口(124,18)/(124,45.5)，弹头外露 6px→导弹 (83,11.5)/(83,39)（本体 tx-370/ty-90）。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

CUR_SWF  = r"..\swf\sub1130.swf"
CUR_XML  = "work/sub1130-v2.xml"
OUT_XML  = "work/sub1130-v3.xml"
OUT_SWF  = "work/sub1130-v3.swf"
FFDEC    = r"..\tools\packaging\ffdec\ffdec-cli.exe"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"

# ---------- 0. 底稿断言（99D00430）＋新鲜转储 ----------
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() == "99D004301B74CBA6EAFF6ADD69C63C8D37358FF7CB349CAF28D27FAE1DB43A53", f"底稿 {actual[:8]} 非 V2 终态"
print("底稿哈希断言 PASS:", actual[:8])
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, CUR_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr

tree = ET.parse(CUR_XML); root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}

# ---------- 1. 深度重排表（两级通用） ----------
REMAP = {1: 3, 2: 6, 3: 4, 4: 7, 5: 5, 6: 8, 7: 9, 8: 10, 9: 1, 10: 2}

def remap_depths(sp, sid):
    n = 0
    for it in sp.iter('item'):
        t = it.get('type') or ''
        if t in ('PlaceObject2Tag', 'RemoveObject2Tag'):
            d = it.get('depth')
            if d is not None and d.isdigit() and int(d) in REMAP:
                it.set('depth', str(REMAP[int(d)]))
                n += 1
    print(f"sprite {sid}: 深度重排 {n} 处")
    return n

n115 = remap_depths(sprites['115'], 115)
n121 = remap_depths(sprites['121'], 121)
# V2 后 115 的标签数：PO2/RO 含导弹层；121 无导弹层
assert n115 == n121 + 7, f"重排计数异常 115={n115} 121={n121}（115 应比 121 多导弹层 6 处＋第五特效槽 1 处）"

# ---------- 2. lv1 新增待机导弹（f1 放 / f4 撤 / f6 回，d1/d2 均在本体 d3 之下） ----------
BULLET_SHAPE = 2905
LV1_TX, LV1_TY = -370, -90
M_UP = (LV1_TX + 83 * 20, LV1_TY + int(11.5 * 20))    # (1290, 140)
M_LOW = (LV1_TX + 83 * 20, LV1_TY + int(39 * 20))     # (1290, 690)

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

sp121 = sprites['121']
sub = sp121.find('subTags')
def seg(no):
    fr = 1
    for i, it in enumerate(list(sub)):
        if (it.get('type') or '') == 'ShowFrameTag':
            if fr == no: return i
            fr += 1
    raise AssertionError(no)

base = seg(1)
sub.insert(base, po2(BULLET_SHAPE, 1, *M_UP)); sub.insert(base + 1, po2(BULLET_SHAPE, 2, *M_LOW))
base = seg(4)
sub.insert(base, ro(1)); sub.insert(base + 1, ro(2))
base = seg(6)
sub.insert(base, po2(BULLET_SHAPE, 1, *M_UP)); sub.insert(base + 1, po2(BULLET_SHAPE, 2, *M_LOW))
print(f"lv1 待机导弹层: f1 放 d1/d2（上{M_UP}/下{M_LOW}），f4 撤，f6 回")

# ---------- 3. 断言 ----------
for sid, missile_expect in (('115', True), ('121', True)):
    sp = sprites[sid]
    d1 = [it for it in sp.iter('item') if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '1']
    assert all(it.get('characterId') == str(BULLET_SHAPE) for it in d1), f"{sid} d1 顶层非导弹"
    body = [it for it in sp.iter('item') if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '3']
    assert len(body) == 2 and all(it.get('characterId') in ('2901', '2935') for it in body), f"{sid} d3 本体异常"
    anchors = [(it.get('name'), it.get('depth')) for it in sp.iter('item')
               if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('name') in ('basePoint', 'shootPoint')]
    assert sorted(anchors) == [('basePoint', '4'), ('shootPoint', '5')], f"{sid} 锚点深度异常 {anchors}"
    fc = sp.get('frameCount')
    assert fc == '13' or fc == '18', fc
print("断言: d1=导弹层 / d3=本体 / 锚点(basePoint@4, shootPoint@5) / 帧数原样 — PASS")
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
