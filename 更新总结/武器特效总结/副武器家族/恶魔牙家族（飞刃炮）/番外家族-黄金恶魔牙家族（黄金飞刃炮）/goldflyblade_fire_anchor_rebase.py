# -*- coding: utf-8 -*-
# 黄金恶魔牙枪口火焰回归本系挂点差（20260916，用户指示：参照普通恶魔牙 LV3~LV6 火焰↔挂点坐标差，先回归再微调）
# 质心比对：金链前6帧与本体系生长链质心逐位相同（差0）；帧9/10 质心差=(+118,−154)/(+192,−94)tw（与发射特效导入一致）。
# 基座已对齐（金体 basePoint 照搬后与本系相同），故金链八帧整组回归本系同级原始放置即可。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
REG = {  # 本系 lv3~lv6 火焰八帧原始放置（891/888/885/882）
    '2774': [(1082, -13), (1075, -49), (1062, -92), (1079, -114), (1076, -227), (1007, -480), (1003, -105), (882, -140)],
    '2775': [(1082, -13), (1075, -49), (1062, -92), (1079, -114), (1076, -227), (1007, -480), (1003, -105), (882, -140)],
    '2776': [(1052, -64), (1045, -100), (1032, -143), (1049, -165), (1046, -278), (977, -531), (973, -156), (852, -191)],
    '2777': [(1232, 27), (1225, -9), (1212, -52), (1229, -74), (1226, -187), (1157, -440), (1153, -65), (1032, -100)],
}
CORR = {5: (118, -154), 6: (192, -94)}  # 帧9/10 金链特有质心对位修正
CHAIN = ['2734', '2737', '2740', '2743', '2746', '2749', '2752', '2755']

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper()
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, pls in REG.items():
    sub = sprites[sid].find('subTags')
    byc = {t.get('characterId'): t for t in sub if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') in CHAIN}
    assert len(byc) == 8, (sid, len(byc))
    for i, cid in enumerate(CHAIN):
        dx, dy = CORR.get(i, (0, 0))
        m = byc[cid].find('matrix')
        m.set('translateX', str(pls[i][0] + dx))
        m.set('translateY', str(pls[i][1] + dy))
    print(sid, '八帧已回归本系放置')

ET.indent(tree)
tree.write('sub1130-fireanchor.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-fireanchor.xml', 'sub1130-fireanchor.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-fireanchor.swf', 'rb').read()).hexdigest().upper()[:8])
