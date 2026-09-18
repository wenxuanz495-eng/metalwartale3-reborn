# -*- coding: utf-8 -*-
# 黄金恶魔牙枪口火焰帧位修正·第二批次（20260917）：2752（发射帧9）补质心对位 (+118,-154)
# 说明：回归本系放置时 2749/2752/2755 三帧被同源错位波及（详见 goldflyblade_frame_correction.py 批次一
#       与《黄金枪口火焰帧位修正-20260917.md》）；本批次补齐 2752 的漏移部分。
# 注意：本脚本底稿为 717E3F80（错态），运行前需重新导出 cur.xml。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r'..\swf\sub1130.swf'
MANIFEST = r'..\config\build\current-resource-manifest.sha256'
FFDEC = r'..\tools\packaging\ffdec\ffdec-cli.exe'
FIX = {'2774': (1121, -259), '2775': (1121, -259), '2776': (1091, -310), '2777': (1271, -219)}
OLD = {'2774': (1195, -199), '2775': (1195, -199), '2776': (1165, -250), '2777': (1345, -159)}

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == '717E3F80DF64D585F5BE6251F2454CB9DC721DC66ED3E3B64FB9C096870DB57A'
print('底稿哈希断言 PASS:', actual[:8])

tree = ET.parse('cur.xml')
root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, (ntx, nty) in FIX.items():
    sub = sprites[sid].find('subTags')
    hits = [t for t in sub if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') == '2752']
    assert len(hits) == 1, (sid, len(hits))
    m = hits[0].find('matrix')
    assert (m.get('translateX'), m.get('translateY')) == (str(OLD[sid][0]), str(OLD[sid][1])), (sid, old := (m.get('translateX'), m.get('translateY')))
    m.set('translateX', str(ntx))
    m.set('translateY', str(nty))
    print(sid, '2752', OLD[sid], '->', (ntx, nty))

ET.indent(tree)
tree.write('sub1130-framefix2.xml', encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, '-xml2swf', 'sub1130-framefix2.xml', 'sub1130-framefix2.swf'], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print('写出:', hashlib.sha256(open('sub1130-framefix2.swf', 'rb').read()).hexdigest().upper()[:8])
