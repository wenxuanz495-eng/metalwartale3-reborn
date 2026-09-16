# -*- coding: utf-8 -*-
# 黄金恶魔牙子弹出膛纵向基准回归本系模式（20260916，用户反馈子弹纵向偏低）
# 本系 y 设计口径＝shootPoint.ty 与 basePoint.ty 完全相等（子弹贴图纵向居中于原点）；
# 上一轮误取"炮管轴"（base_ty+240~320tw）使子弹下压 12~16px。本轮 ty 回本系模式，x 不变。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
FIXES = {'2774': (577, 264), '2775': (657, 264), '2776': (657, 264), '2777': (882, 369)}

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, (stx, sty) in FIXES.items():
    sub = sprites[sid].find('subTags')
    hits = [t for t in sub if 'PlaceObject' in (t.get('type') or '') and t.get('name') == 'shootPoint']
    assert len(hits) == 1, (sid, len(hits))
    m = hits[0].find('matrix')
    old = (m.get('translateX'), m.get('translateY'))
    m.set('translateY', str(sty))
    assert m.get('translateX') == str(stx)
    print(sid, 'shootPoint', old, '->', (stx, sty))

ET.indent(tree)
tree.write('sub1130-shooty.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-shooty.xml', 'sub1130-shooty.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-shooty.swf', 'rb').read()).hexdigest().upper()[:8])
