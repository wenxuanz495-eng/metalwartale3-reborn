# -*- coding: utf-8 -*-
# 黄金恶魔牙子弹出膛点按贴图内部偏移重设（20260916）
# 根因：子弹图形 393 bounds ±112.5px＝原点在图形正中心，可见弹头质心在原点右侧 +78.6px、
#       拖尾向左延伸至 −104.5px——游戏在出膛点放置的是原点，弹头天生出现在出膛点右侧 78.6px。
# 设计：弹头质心出生在炮口 −2px、竖直对齐炮管轴（轴 y：lv3 12 / lv4 16 / lv5 16 / lv6 16）。
# shoot = base + (炮口−2−78.6, 轴+0.73)*20。仅动四级 shootPoint。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
SHOOT = {'2774': (577, 519), '2775': (657, 599), '2776': (657, 599), '2777': (882, 704)}

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
tree.write('sub1130-bulletfix.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-bulletfix.xml', 'sub1130-bulletfix.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-bulletfix.swf', 'rb').read()).hexdigest().upper()[:8])
