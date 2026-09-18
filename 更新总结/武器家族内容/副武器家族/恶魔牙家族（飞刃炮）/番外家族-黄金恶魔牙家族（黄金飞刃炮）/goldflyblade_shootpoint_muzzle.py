# -*- coding: utf-8 -*-
# 黄金恶魔牙子弹出膛点（shootPoint）炮口对位（20260916，用户反馈出膛点离枪口太远，参照恶魔牙系列设计）
# 本系口径量测（本体坐标系）：出膛点在炮口尖后方约 7px（lv6 13px）、位于炮管轴线。
# 金体炮口/轴（画师PNG）：lv3 (89,12) lv4 (93,16) lv5 (93,16) lv6 (97,16)。
# 仅动四级 shootPoint；basePoint（挂载）、蓄力、金链、本体、锚点不动。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
SHOOT = {'2774': (2333, 504), '2775': (2403, 584), '2776': (2413, 584), '2777': (2753, 689)}

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, (stx, sty) in SHOOT.items():
    sub = sprites[sid].find('subTags')
    hits = [t for t in sub if 'PlaceObject' in (t.get('type') or '') and t.get('name') == 'shootPoint']
    assert len(hits) == 1, (sid, len(hits))
    m = hits[0].find('matrix')
    old = (m.get('translateX'), m.get('translateY'))
    m.set('translateX', str(stx))
    m.set('translateY', str(sty))
    print(sid, 'shootPoint', old, '->', (stx, sty))

ET.indent(tree)
tree.write('sub1130-shoot.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-shoot.xml', 'sub1130-shoot.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-shoot.swf', 'rb').read()).hexdigest().upper()[:8])
