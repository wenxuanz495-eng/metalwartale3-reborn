# -*- coding: utf-8 -*-
# 星际雷神 V31 修订（2026-09-18，两级；重型武器节奏改造）：
# ① 时间轴 16→230 帧：f2~f13 蓄力（特效链，膛内导弹保持可见）→ f14 发射（撤膛内弹+焰1+开火音）
#    → f16/f18 焰2/焰3 → f20 焰清除 → f21~f163 空膛暴露 hold（5 秒）→ f164 导弹隐藏位放置
#    → f172~f220 逐像素 MOVE 滑入（1px/8tick）→ f221~230 待机尾。
# ② shootPoint 枪口生成点外移 4px（lv1 1623→1703 / lv2 1603→1683），子弹更贴枪口。
# 全程 V29 零替换写法（RO+add/MOVE）；锚点名称保留；StartSound 深拷贝移至 f14。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v31-src.xml"
OUT_XML  = "work"+BS+"sub1130-v31.xml"
OUT_SWF  = "work"+BS+"sub1130-v31.swf"
RB_XML   = "work"+BS+"sub1130-v31-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
NF = 230

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("DEAC1EC2"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()

def sprite(sid):
    return [it for it in root.iter('item')
            if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]

def frame_buckets(sp):
    b = [[]]
    for it in list(sp.find('subTags')):
        if (it.get('type') or '') == 'ShowFrameTag':
            b.append([])
        else:
            b[-1].append(it)
    assert b[-1] == [], "游离标签"
    b.pop()
    return b

def find_frame(buckets, fr, kind, depth=None):
    out = []
    for it in buckets[fr-1]:
        t = it.get('type') or ''
        if t == kind and (depth is None or it.get('depth') == str(depth)):
            out.append(it)
    return out

def P(char, depth, tx, ty):
    return ET.Element('item', {'type': 'PlaceObject2Tag', 'characterId': str(char), 'depth': str(depth),
        'forceWriteAsLong': 'false', 'placeFlagHasCharacter': 'true', 'placeFlagHasClipActions': 'false',
        'placeFlagHasClipDepth': 'false', 'placeFlagHasColorTransform': 'false', 'placeFlagHasMatrix': 'true',
        'placeFlagHasName': 'false', 'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'})

def RO(depth):
    return ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false'})

def MOVE(depth, tx, ty):
    return ET.Element('item', {'type': 'PlaceObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false',
        'placeFlagHasClipActions': 'false', 'placeFlagHasClipDepth': 'false', 'placeFlagHasColorTransform': 'false',
        'placeFlagHasMatrix': 'true', 'placeFlagHasName': 'false', 'placeFlagHasRatio': 'false',
        'placeFlagMove': 'true'})

def MAT(tx, ty, scale='0.75'):
    return ET.Element('matrix', {'type': 'MATRIX', 'hasRotate': 'false', 'hasScale': 'true',
        'nRotateBits': '0', 'nScaleBits': '17', 'nTranslateBits': '12', 'scaleX': scale, 'scaleY': scale,
        'translateX': str(tx), 'translateY': str(ty)})

def build_new(sp, lv):
    old = frame_buckets(sp)
    assert len(old) == 16
    # 底稿元素
    f1 = old[0]
    anchors = {it.get('name'): it for it in f1 if (it.get('name') or '') in ('basePoint', 'shootPoint')}
    assert set(anchors) == {'basePoint', 'shootPoint'}
    stand_d5 = find_frame(old, 1, 'PlaceObject2Tag', 5)[0]
    stand_d6 = find_frame(old, 1, 'PlaceObject2Tag', 6)[0]
    flame1_d3 = find_frame(old, 2, 'PlaceObject2Tag', 3)[0]
    flame1_d4 = find_frame(old, 2, 'PlaceObject2Tag', 4)[0]
    flame2_d3 = find_frame(old, 4, 'PlaceObject2Tag', 3)[0]
    flame2_d4 = find_frame(old, 4, 'PlaceObject2Tag', 4)[0]
    flame3_d3 = find_frame(old, 6, 'PlaceObject2Tag', 3)[0]
    flame3_d4 = find_frame(old, 6, 'PlaceObject2Tag', 4)[0]
    eff = {fr: find_frame(old, fr, 'PlaceObject2Tag', 10)[0] for fr in (2, 5, 8, 11)} if lv == 1 else {}
    snd = find_frame(old, 2, 'StartSoundTag')
    assert len(snd) == 1, "StartSound 未找到"
    snd = snd[0]
    # 新时间轴
    nb = [[] for _ in range(NF)]
    nb[0] = copy.deepcopy(f1)
    # shootPoint 外移 4px（80tw）
    sp_shift = 80
    for it in nb[0]:
        if (it.get('name') or '') == 'shootPoint':
            m = it.find('matrix')
            m.set('translateX', str(int(m.get('translateX')) + sp_shift))
    if lv == 1:
        nb[1].append(copy.deepcopy(eff[2]))                       # f2 特效1（蓄力开始）
        nb[4] = [RO(10), copy.deepcopy(eff[5])]                   # f5 特效2
        nb[7] = [RO(10), copy.deepcopy(eff[8])]                   # f8 特效3
        nb[10] = [RO(10), copy.deepcopy(eff[11])]                 # f11 特效4
        nb[12] = [RO(10)]                                         # f13 蓄力结束
    # f14 发射
    launch = [RO(5), RO(6), copy.deepcopy(flame1_d3), copy.deepcopy(flame1_d4), copy.deepcopy(snd)]
    nb[13] = launch
    nb[15] = [RO(3), RO(4), copy.deepcopy(flame2_d3), copy.deepcopy(flame2_d4)]
    nb[17] = [RO(3), RO(4), copy.deepcopy(flame3_d3), copy.deepcopy(flame3_d4)]
    nb[19] = [RO(3), RO(4)]
    # f164 隐藏位放置 + 逐像素滑入（1px=20tw / 8tick）
    if lv == 1:
        hid5, hid6 = 900, 900
        steps = [920, 940, 960, 980, 1000, 1020, 1037]
        fin5, fin6 = 1037, 1037
    else:
        hid5, hid6 = 840, 840
        steps = [860, 880, 900, 920, 940]
        f5final, f6final = find_frame(old, 1, 'PlaceObject2Tag', 5)[0], find_frame(old, 1, 'PlaceObject2Tag', 6)[0]
        fin5 = f5final.find('matrix').get('translateX')
        fin6 = f6final.find('matrix').get('translateX')
    nb[163] = [copy.deepcopy(stand_d5), copy.deepcopy(stand_d6)]
    for it in nb[163]:
        m = it.find('matrix'); m.set('translateX', str(hid5 if it.get('depth') == '5' else hid6))
    mv_frames = [172, 180, 188, 196, 204, 212]
    for i, mf in enumerate(mv_frames):
        if i == len(steps):
            v5, v6 = fin5, fin6
        else:
            v5 = v6 = steps[i]
        nb[mf-1] = [MOVE(5, v5, 0), MOVE(6, v6, 0)]
    for it in nb[163] + sum(([it] for fr in mv_frames for it in nb[fr-1]), []):
        pass
    # MOVE 标签补矩阵
    for fr in mv_frames:
        for it in nb[fr-1]:
            d = it.get('depth')
            ty = {1: (385, 797), 2: (353, 787)}[lv][0 if d == '5' else 1]
            tx = {172: 920, 180: 940, 188: 960, 196: 980, 204: 1000, 212: None}[fr]
            if fr == 212:
                tx = (fin5, fin6)[0 if d == '5' else 1]
            it.append(MAT(tx, ty))
    rebuild = ET.Element('subTags')
    for fr in range(NF):
        for it in nb[fr]:
            rebuild.append(it)
        sf = ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'})
        rebuild.append(sf)
    sp.set('frameCount', str(NF))
    old_sub = sp.find('subTags')
    for it in list(old_sub):
        old_sub.remove(it)
    for it in list(rebuild):
        old_sub.append(it)

for sid, lv in (('121', 1), ('115', 2)):
    build_new(sprite(sid), lv)
    print(f"sprite{sid}: 230 帧重型节奏时间轴构建完成")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
