# -*- coding: utf-8 -*-
# 黄金恶魔牙 LV3~LV5 枪口火焰对位（20260916，用户方向指示：lv3 右上/lv4 右/lv5 右下，lv6 不动）
# 红线：整条发射动画所有帧一起移动——f2 枪口闪 2647 + f3~f10 金链 2734~2755 每级 9 处统一 Δ；
#       蓄力小白圈 2652（已定心宝石）、本体、锚点、lv6 一概不动。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
FLASH_IDS = {'2647', '2734', '2737', '2740', '2743', '2746', '2749', '2752', '2755'}
FIXES = [  # (spriteId, dx, dy)  +x右 +y下，1格=20tw
    ('2774', 60, -40),
    ('2775', 40, 0),
    ('2776', 40, 60),
]

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, dx, dy in FIXES:
    sub = sprites[sid].find('subTags')
    moved = 0
    for t in sub:
        if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') in FLASH_IDS:
            m = t.find('matrix')
            m.set('translateX', str(int(m.get('translateX')) + dx))
            m.set('translateY', str(int(m.get('translateY')) + dy))
            moved += 1
    assert moved == 9, (sid, moved)
    w = [t for t in sub if t.get('characterId') == '2652']
    assert len(w) == 1
    m = w[0].find('matrix')
    print(sid, f'移动 {moved} 处 (Δ={dx:+d},{dy:+d})；2652 白圈保持在 ({m.get("translateX")},{m.get("translateY")})')

sub7 = sprites['2777'].find('subTags')
assert len([t for t in sub7 if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') in FLASH_IDS]) == 9
print('2777 零改动 PASS')

ET.indent(tree)
tree.write('sub1130-flashalign.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-flashalign.xml', 'sub1130-flashalign.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-flashalign.swf', 'rb').read()).hexdigest().upper()[:8])
