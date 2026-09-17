# -*- coding: utf-8 -*-
# 星际雷神 V22（2026-09-17）：恢复 MK1(lv1) 特效链——V21 删除的 4 处特效放置原样回归
# （f2/f4/f6/f9 @d10 顶层，矩阵=V20 原值 tx=10/ty=277/scale=0.75，从 V20 存档 XML 深拷贝回插）
# lv2 维持 V21 删除态；lv1 特效素材=孤儿 2906~2913（特效1~4），本就未删。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
CUR_XML  = "work"+BS+"sub1130-v21.xml"
REF_XML  = "work"+BS+"sub1130-v20.xml"
OUT_XML  = "work"+BS+"sub1130-v22.xml"
OUT_SWF  = "work"+BS+"sub1130-v22.swf"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("6B190912"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, CUR_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(CUR_XML); root = tree.getroot()
sp = [it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '121'][0]
sub = sp.find('subTags')
fr = 1; pos = {}
for i, it in enumerate(list(sub)):
    if (it.get('type') or '') == 'ShowFrameTag':
        pos[fr] = i; fr += 1
assert len(pos) == 16
ref = ET.parse(REF_XML); rroot = ref.getroot()
sp20 = [it for it in rroot.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '121'][0]
v20 = {}; fr = 1
for it in sp20.find('subTags'):
    t = it.get('type') or ''
    if t == 'ShowFrameTag': fr += 1; continue
    if t == 'PlaceObject2Tag' and it.get('depth') == '10':
        v20.setdefault(fr, []).append(copy.deepcopy(it))
restore = {f: v20[f] for f in (2, 4, 6, 9)}
for f in sorted(restore, reverse=True):
    idx = pos[f]
    for k, el in enumerate(restore[f]):
        sub.insert(idx + k, el)
n = sum(len(v) for v in restore.values())
print(f"lv1: 特效放置恢复 {n} 处（f2/f4/f6/f9，矩阵=V20 原值）")
fm = {}; fr = 1; cur = []
for it in list(sub):
    cur.append(it)
    if (it.get('type') or '') == 'ShowFrameTag': fm[fr] = list(cur); fr += 1; cur = []
assert fr - 1 == 16
got = sorted(f for f in range(1, 17) if any(it.get('depth') == '10' and it.get('characterId') in ('2907', '2909', '2911', '2913') for it in fm[f]))
assert got == [2, 4, 6, 9], f"特效帧 {got}"
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
