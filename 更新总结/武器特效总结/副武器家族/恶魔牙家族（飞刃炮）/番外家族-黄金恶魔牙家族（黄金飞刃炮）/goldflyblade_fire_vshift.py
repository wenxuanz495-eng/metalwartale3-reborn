# -*- coding: utf-8 -*-
# 黄金恶魔牙枪口火焰纵向微调（20260917，用户像素级指示：lv3 上5px / lv5 整体下5px / lv6 上3px；lv4 不动）
# 红线：所有帧一起动——仅金链 2734~2755 八帧 translateY 统一平移；
# 2647/2652（宝石蓄力位）、basePoint/shootPoint、本体、锚点不动。1px=20tw，+y下。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
CHAIN = ['2734', '2737', '2740', '2743', '2746', '2749', '2752', '2755']
FIXES = [('2774', -100), ('2776', 100), ('2777', -60)]
KEEP = '2775'

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, dy in FIXES:
    sub = sprites[sid].find('subTags')
    nc = 0
    for t in sub:
        if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') in CHAIN:
            m = t.find('matrix')
            m.set('translateY', str(int(m.get('translateY')) + dy))
            nc += 1
    assert nc == 8, (sid, nc)
    b = [t for t in sub if t.get('characterId') == '2647'][0].find('matrix')
    w = [t for t in sub if t.get('characterId') == '2652'][0].find('matrix')
    bp = [t for t in sub if t.get('name') == 'basePoint'][0].find('matrix')
    print(sid, f'金链8帧 dy={dy:+d}；2647 ({b.get("translateX")},{b.get("translateY")})；2652 ({w.get("translateX")},{w.get("translateY")})；basePoint ({bp.get("translateX")},{bp.get("translateY")}) 原样')

km = [t for t in sprites[KEEP].find('subTags') if t.get('characterId') == '2734'][0].find('matrix')
assert km.get('translateY') == '-13'
print(KEEP, '(lv4) 零改动 PASS')

ET.indent(tree)
tree.write('sub1130-flashv.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-flashv.xml', 'sub1130-flashv.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-flashv.swf', 'rb').read()).hexdigest().upper()[:8])
