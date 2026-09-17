# -*- coding: utf-8 -*-
# 星际雷神 V19（2026-09-17）：lv2 特效链回退为 新特效1~5（撤销 V18 换套；2936~2943 保留孤儿）
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
CUR_XML  = "work"+BS+"sub1130-v18.xml"
OUT_XML  = "work"+BS+"sub1130-v19.xml"
OUT_SWF  = "work"+BS+"sub1130-v19.swf"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("D45EED65"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, CUR_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(CUR_XML); root = tree.getroot()
sp = [it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
sub = sp.find('subTags')
REMAP = {'2937': '2915', '2939': '2917', '2941': '2919', '2943': '2921'}
fm = {}; fr = 1; cur = []
for it in list(sub):
    cur.append(it)
    if (it.get('type') or '') == 'ShowFrameTag': fm[fr] = list(cur); fr += 1; cur = []
n = 0
slide_ref = None
for fno in (2, 3, 4, 5):
    for it in fm[fno]:
        cid = it.get('characterId')
        if cid in REMAP and it.get('depth') == '10':
            it.set('characterId', REMAP[cid]); n += 1
assert n == 4, f"回退改指 {n} != 4"
# f6 补回 新特效5（复制 f5 的 2921 放置改 cid=2923）
for it in fm[5]:
    if it.get('characterId') == '2921' and it.get('depth') == '10':
        e6 = copy.deepcopy(it); e6.set('characterId', '2923')
        idx = list(sub).index(fm[6][-1])
        sub.insert(idx, e6)
        break
print("lv2: 特效回退 新特效1~5（f2~f6 五帧）；2936~2943 保留孤儿")
assert not any(it.get('characterId') in ('2937', '2939', '2941', '2943') for it in sp.iter('item')), "旧引用残留"
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
