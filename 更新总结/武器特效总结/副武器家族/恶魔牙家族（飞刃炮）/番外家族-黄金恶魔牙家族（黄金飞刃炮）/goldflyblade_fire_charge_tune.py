# -*- coding: utf-8 -*-
# 黄金恶魔牙四级枪口火焰与蓄力特效分调（20260916，用户分列指令）
# 枪口火焰＝金链 2734~2755 八帧整组；蓄力特效＝宝石位小圆球 2647＋白圈 2652（共位成对移动）。
# 本体、锚点不动。1px=20tw，+x右 +y下。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
CHAIN = ['2734', '2737', '2740', '2743', '2746', '2749', '2752', '2755']
FIXES = [  # (spriteId, 金链Δ, 蓄力Δ[2647+2652])
    ('2777', (0, -100), (0, 60)),     # lv6 诸神: 火焰上5 蓄力下3
    ('2776', None, (0, 80)),          # lv5 灭世: 火焰不动 蓄力下4
    ('2775', (-60, -60), (20, 60)),   # lv4 深渊: 火焰左3上3 蓄力右1下3
    ('2774', (-100, 0), (-40, 60)),   # lv3 地狱: 火焰左5 蓄力左2下3
]

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, dc, dchg in FIXES:
    sub = sprites[sid].find('subTags')
    nc = nb = nw = 0
    for t in sub:
        if 'PlaceObject' not in (t.get('type') or ''):
            continue
        cid = t.get('characterId')
        m = t.find('matrix')
        if cid in CHAIN:
            if dc is not None:
                m.set('translateX', str(int(m.get('translateX')) + dc[0]))
                m.set('translateY', str(int(m.get('translateY')) + dc[1]))
                nc += 1
        elif cid == '2647':
            m.set('translateX', str(int(m.get('translateX')) + dchg[0]))
            m.set('translateY', str(int(m.get('translateY')) + dchg[1]))
            nb += 1
        elif cid == '2652':
            m.set('translateX', str(int(m.get('translateX')) + dchg[0]))
            m.set('translateY', str(int(m.get('translateY')) + dchg[1]))
            nw += 1
    assert nc == (8 if dc else 0) and nb == 1 and nw == 1, (sid, nc, nb, nw)
    b = [t for t in sub if t.get('characterId') == '2647'][0].find('matrix')
    print(sid, f'金链Δ={dc} 蓄力Δ={dchg}；2647 现 ({b.get("translateX")},{b.get("translateY")})')

ET.indent(tree)
tree.write('sub1130-flash5.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-flash5.xml', 'sub1130-flash5.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-flash5.swf', 'rb').read()).hexdigest().upper()[:8])
