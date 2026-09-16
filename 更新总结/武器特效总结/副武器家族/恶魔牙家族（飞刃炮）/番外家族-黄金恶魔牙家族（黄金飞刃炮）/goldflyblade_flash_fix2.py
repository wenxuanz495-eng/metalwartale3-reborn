# -*- coding: utf-8 -*-
# 黄金恶魔牙四级枪口火焰二次对位 + 第一帧小圆球(2647)归位（20260916，用户八图蓝圈指示）
# 红线：整条发射动画所有帧一起移动。
# 金链 2734~2755（8帧）与 2647 各自 Δ 见 FIXES；2652 白圈（宝石定心位）、本体、锚点不动。
# 换算依据：截图蓝圈心/光球心/宝石心/炮口尖四点目测＋宝石→炮口距离定比例。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
CHAIN = ['2734', '2737', '2740', '2743', '2746', '2749', '2752', '2755']
FIXES = [  # (spriteId, 金链Δ, 2647Δ)
    ('2774', (320, -80), (1282, -62)),
    ('2775', (320, 0), (1388, 42)),
    ('2776', (280, 0), (1310, 10)),
    ('2777', (375, -20), (1174, -8)),
]

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, dc, df in FIXES:
    sub = sprites[sid].find('subTags')
    nc = nf = 0
    for t in sub:
        if 'PlaceObject' not in (t.get('type') or ''):
            continue
        cid = t.get('characterId')
        m = t.find('matrix')
        if cid in CHAIN:
            m.set('translateX', str(int(m.get('translateX')) + dc[0]))
            m.set('translateY', str(int(m.get('translateY')) + dc[1]))
            nc += 1
        elif cid == '2647':
            m.set('translateX', str(int(m.get('translateX')) + df[0]))
            m.set('translateY', str(int(m.get('translateY')) + df[1]))
            nf += 1
    assert nc == 8 and nf == 1, (sid, nc, nf)
    w = [t for t in sub if t.get('characterId') == '2652']
    assert len(w) == 1
    mw = w[0].find('matrix')
    print(sid, f'金链8帧 Δ={dc} 2647 Δ={df}；2652 白圈保持 ({mw.get("translateX")},{mw.get("translateY")})')

ET.indent(tree)
tree.write('sub1130-fix2.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-fix2.xml', 'sub1130-fix2.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-fix2.swf', 'rb').read()).hexdigest().upper()[:8])
