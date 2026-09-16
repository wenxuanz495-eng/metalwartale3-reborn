# -*- coding: utf-8 -*-
# 黄金恶魔牙枪口火焰左移纠错（20260916，用户声明上轮向右指令错误，应向左）
# 双份向左＝先回到原点、再到左向目标：lv3 −10px、lv4 −10px、lv6 −20px；lv5（上轮已左3px，正确）零改动。
# 仅金链 2734~2755 八帧统一平移；2647/2652（宝石蓄力位）、本体、锚点不动。1px=20tw。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
CHAIN = ['2734', '2737', '2740', '2743', '2746', '2749', '2752', '2755']
FIXES = [('2774', -200), ('2775', -200), ('2777', -400)]

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

lv5sub = sprites['2776'].find('subTags')
print('2776 (lv5) 本轮零改动 PASS')

ET.indent(tree)
tree.write('sub1130-flash4.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-flash4.xml', 'sub1130-flash4.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-flash4.swf', 'rb').read()).hexdigest().upper()[:8])
