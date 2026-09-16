# -*- coding: utf-8 -*-
# 黄金小圆球（2647）归位蓄力宝石（20260916，用户裁定：2647=蓄力特效核心，非枪口火焰）
# 2647 与 2652 白圈同为宝石位蓄力系元素（模板 399 共位 (90,542)），本轮将四级 2647
# 改为与 2652（已定心宝石）完全一致：lv3 (55,-41) / lv4 (86,34) / lv5 (86,34) / lv6 (159,36)。
# 金链（蓝圈位）、白圈、本体、锚点不动。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
# (spriteId, 2647 新矩阵 tx, ty) —— 与 2652 白圈同位
FIXES = [('2774', 55, -41), ('2775', 86, 34), ('2776', 86, 34), ('2777', 159, 36)]

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, ntx, nty in FIXES:
    sub = sprites[sid].find('subTags')
    hits = [t for t in sub if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') == '2647']
    assert len(hits) == 1, (sid, len(hits))
    m = hits[0].find('matrix')
    old = (m.get('translateX'), m.get('translateY'))
    m.set('translateX', str(ntx))
    m.set('translateY', str(nty))
    # 金链原样断言（上一轮蓝圈位不动）
    chain_x = sorted(t.find('matrix').get('translateX') for t in sub if t.get('characterId') in ('2734', '2755'))
    print(sid, '2647', old, '->', (ntx, nty), '| 金链首末 x:', chain_x[0], chain_x[-1])

ET.indent(tree)
tree.write('sub1130-ballfix.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-ballfix.xml', 'sub1130-ballfix.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-ballfix.swf', 'rb').read()).hexdigest().upper()[:8])
