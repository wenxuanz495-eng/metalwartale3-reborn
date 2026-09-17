# -*- coding: utf-8 -*-
# 星际雷神 V37 修订（2026-09-18，仅 lv1；部件2 再左移 3px——用户 directive）：
# 两片（2931/2933）统一直接左移 5px（tx −100tw）、下移 3px（ty +60tw）：
#   片1(2931@d1)：(1800,300)→(1700,360)；片2(2933@d2)：(1800,660)→(1700,720)。
# 其余零改动（全元素级 diff 断言：2 处叶子 + 1 容器）。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v37-src.xml"
OUT_XML  = "work"+BS+"sub1130-v37.xml"
OUT_SWF  = "work"+BS+"sub1130-v37.swf"
RB_XML   = "work"+BS+"sub1130-v37-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("DD7F63A4"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()

sp121 = [it for it in root.iter('item')
         if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '121'][0]
expect = {}
for it in sp121.find('subTags'):
    if (it.get('type') or '') != 'PlaceObject2Tag':
        continue
    d, cid = it.get('depth'), it.get('characterId')
    if cid == '2931' and d == '1':
        m = it.find('matrix')
        assert m.get('translateX') == '1700' and m.get('translateY') == '360'
        m.set('translateX', '1640')
        m.set('translateY', '360')
        expect['2931'] = ('1', '1640', '360')
    if cid == '2933' and d == '2':
        m = it.find('matrix')
        assert m.get('translateX') == '1700' and m.get('translateY') == '720'
        m.set('translateX', '1640')
        m.set('translateY', '720')
        expect['2933'] = ('2', '1640', '720')
assert len(expect) == 2, "部件2 放置未找齐"
print("矩阵修改 PASS：2931→(1640,360)、2933→(1640,720)（再左移 3px）")

# 全元素级 diff：2 处叶子 + 1 容器
ftree = ET.parse(SRC_XML)
a = [ET.tostring(it, encoding='unicode') for it in ftree.iter('item')]
b = [ET.tostring(it, encoding='unicode') for it in tree.iter('item')]
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 2 and len(cont) == 1, f"diff 叶子{len(leaf)} 容器{len(cont)}"
print("全元素级 diff 断言 PASS：叶子 2 处＋容器 sprite121 随之差异，其余零改动")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
sp = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '121'][0]
got = {}
fr = 1
for it in sp.find('subTags'):
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1
        continue
    if t == 'PlaceObject2Tag' and it.get('characterId') in ('2931', '2933'):
        m = it.find('matrix')
        got[it.get('characterId')] = (it.get('depth'), m.get('translateX'), m.get('translateY'))
assert got == expect, "回读不一致 " + str(got)
print("回读 FOUND：部件2 两片矩阵全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
