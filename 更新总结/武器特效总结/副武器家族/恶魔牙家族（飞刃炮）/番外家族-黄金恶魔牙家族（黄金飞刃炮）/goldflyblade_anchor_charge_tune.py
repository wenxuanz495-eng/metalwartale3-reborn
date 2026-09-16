# -*- coding: utf-8 -*-
# 黄金恶魔牙蓄力特效微调 + 锚点照搬本系（20260916）
# 1) 蓄力特效 2647+2652（宝石位成对）四级微调；
# 2) basePoint/shootPoint 照搬普通恶魔牙 lv3~lv6 现行值（891/888/885=(409,264)/(1796,264)，882=(554,369)/(1841,369)）。
# 注意：basePoint 为武器挂载参考（ArmsImage.adjustPosition: mc.x=-basePoint.x），照搬后枪体挂载回到本系基准。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
CHG = {'2774': (0, -20), '2775': (-6, -10), '2776': (20, -40), '2777': (0, -20)}
ANCH = {'2774': (409, 264, 1796, 264), '2775': (409, 264, 1796, 264),
        '2776': (409, 264, 1796, 264), '2777': (554, 369, 1841, 369)}

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid in ['2774', '2775', '2776', '2777']:
    dc = CHG[sid]
    btx, bty, stx, sty = ANCH[sid]
    sub = sprites[sid].find('subTags')
    nb = nw = ns = 0
    for t in sub:
        if 'PlaceObject' not in (t.get('type') or ''):
            continue
        name = t.get('name')
        cid = t.get('characterId')
        m = t.find('matrix')
        if name == 'basePoint':
            print(sid, 'basePoint', (m.get('translateX'), m.get('translateY')), '->', (btx, bty))
            m.set('translateX', str(btx))
            m.set('translateY', str(bty))
            nb += 1
        elif name == 'shootPoint':
            print(sid, 'shootPoint', (m.get('translateX'), m.get('translateY')), '->', (stx, sty))
            m.set('translateX', str(stx))
            m.set('translateY', str(sty))
            ns += 1
        elif cid == '2647':
            m.set('translateX', str(int(m.get('translateX')) + dc[0]))
            m.set('translateY', str(int(m.get('translateY')) + dc[1]))
            nb += 1
        elif cid == '2652':
            m.set('translateX', str(int(m.get('translateX')) + dc[0]))
            m.set('translateY', str(int(m.get('translateY')) + dc[1]))
            nw += 1
    assert nb == 2 and nw == 1 and ns == 1, (sid, nb, nw, ns)
    b = [t for t in sub if t.get('characterId') == '2647'][0].find('matrix')
    print(sid, f'蓄力后 2647 ({b.get("translateX")},{b.get("translateY")})')

ET.indent(tree)
tree.write('sub1130-anchor.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-anchor.xml', 'sub1130-anchor.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-anchor.swf', 'rb').read()).hexdigest().upper()[:8])
