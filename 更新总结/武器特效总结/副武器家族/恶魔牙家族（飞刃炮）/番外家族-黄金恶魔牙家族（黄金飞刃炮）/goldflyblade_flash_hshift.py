# -*- coding: utf-8 -*-
# 黄金恶魔牙四级枪口火焰横向微调（20260916，用户指示：lv3 右5px / lv4 右5px / lv5 左3px / lv6 右10px）
# 仅金链 2734~2755 八帧统一平移（整组红线）；2647/2652（宝石蓄力位）、本体、锚点不动。1px=20tw。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
CHAIN = ['2734', '2737', '2740', '2743', '2746', '2749', '2752', '2755']
FIXES = [('2774', 100), ('2775', 100), ('2776', -60), ('2777', 200)]

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, dx in FIXES:
    sub = sprites[sid].find('subTags')
    nc = 0
    for t in sub:
        if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') in CHAIN:
            m = t.find('matrix')
            m.set('translateX', str(int(m.get('translateX')) + dx))
            nc += 1
    assert nc == 8, (sid, nc)
    ball = [t for t in sub if t.get('characterId') == '2647'][0].find('matrix')
    w = [t for t in sub if t.get('characterId') == '2652'][0].find('matrix')
    print(sid, f'金链8帧 dx={dx:+d}；2647 ({ball.get("translateX")},{ball.get("translateY")})；2652 ({w.get("translateX")},{w.get("translateY")}) 原样')

ET.indent(tree)
tree.write('sub1130-flash3.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-flash3.xml', 'sub1130-flash3.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-flash3.swf', 'rb').read()).hexdigest().upper()[:8])
