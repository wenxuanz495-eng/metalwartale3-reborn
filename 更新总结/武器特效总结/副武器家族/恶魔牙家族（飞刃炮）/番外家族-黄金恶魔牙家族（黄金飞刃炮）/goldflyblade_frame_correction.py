# -*- coding: utf-8 -*-
# 黄金恶魔牙枪口火焰帧位修正（20260917，用户观察各帧坐标不一致，核查确认属实）
# 根因：上一轮回归本系放置时，帧9/10 的质心对位修正 (+118,-154)/(+192,-94) 被错加到索引 5/6（第8/9帧），
#       第10帧（索引7）漏加——最后三帧可见位置偏离本系路径。
# 修正（四级）：2749 撤销误加修正；2752 补 (+118,-154)；2755 补 (+192,-94)。其余帧/蓄力/本体/锚点不动。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
FIX = {  # (spriteId, [(cid, 旧矩阵, 新矩阵)])
    '2774': [('2749', (1125, -634), (1007, -480)), ('2755', (882, -140), (1074, -234))],
    '2775': [('2749', (1125, -634), (1007, -480)), ('2755', (882, -140), (1074, -234))],
    '2776': [('2749', (1095, -685), (977, -531)), ('2755', (852, -191), (1044, -285))],
    '2777': [('2749', (1275, -594), (1157, -440)), ('2755', (1032, -100), (1224, -194))],
}
KEEP = {'2774': ('2752', 1195, -199), '2775': ('2752', 1195, -199),
        '2776': ('2752', 1165, -250), '2777': ('2752', 1345, -159)}  # 这些帧本轮不动（已在本系口径）
CHAIN = ['2734', '2737', '2740', '2743', '2746', '2749', '2752', '2755']

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, fixes in FIX.items():
    sub = sprites[sid].find('subTags')
    for cid, old, new in fixes:
        hits = [t for t in sub if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') == cid]
        assert len(hits) == 1, (sid, cid, len(hits))
        m = hits[0].find('matrix')
        assert (m.get('translateX'), m.get('translateY')) == (str(old[0]), str(old[1])), (sid, cid)
        m.set('translateX', str(new[0]))
        m.set('translateY', str(new[1]))
        print(sid, cid, old, '->', new)
    kcid, ktx, kty = KEEP[sid]
    km = [t for t in sub if t.get('characterId') == kcid][0].find('matrix')
    assert (km.get('translateX'), km.get('translateY')) == (str(ktx), str(kty))
    print(sid, kcid, '保持', (ktx, kty), 'PASS')

ET.indent(tree)
tree.write('sub1130-framefix.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-framefix.xml', 'sub1130-framefix.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-framefix.swf', 'rb').read()).hexdigest().upper()[:8])
