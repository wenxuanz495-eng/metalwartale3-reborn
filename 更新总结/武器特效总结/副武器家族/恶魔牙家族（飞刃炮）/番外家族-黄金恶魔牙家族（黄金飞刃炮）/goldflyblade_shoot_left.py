# -*- coding: utf-8 -*-
# 黄金恶魔牙子弹出膛点左移（20260916，用户裁定：拖尾与子弹一体，拖尾覆盖枪身没问题，
# 出膛点仍偏右，需左移让拖尾自发射起覆盖炮身，观感参照本系恶魔牙）
# 仅动四级 shootPoint，统一左移 15px（−300tw）；basePoint/蓄力/金链/本体/锚点不动。1px=20tw。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
DX = -300
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
    assert old == (str(stx), str(sty)), (sid, old)
    m.set('translateX', str(stx + DX))
    print(sid, 'shootPoint', old, '->', (stx + DX, sty))

ET.indent(tree)
tree.write('sub1130-shootleft.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-shootleft.xml', 'sub1130-shootleft.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-shootleft.swf', 'rb').read()).hexdigest().upper()[:8])
