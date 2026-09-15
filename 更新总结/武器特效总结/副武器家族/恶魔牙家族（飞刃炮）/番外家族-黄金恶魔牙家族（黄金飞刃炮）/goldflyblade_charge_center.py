# -*- coding: utf-8 -*-
# 黄金恶魔牙 LV3~LV6 蓄力小白圈定心到紫色圈宝石（20260916）
# 判别依据《蓄力小圈与枪口火焰判别及白圈定心微调闭环-20260914》：2652~2677 小白圈脉冲=蓄力指示→贴圆饰中心
# 只改每级 f3 的 2652 放置矩阵（f4~f8 为 placeFlagMove 跟随同深度，自动跟随）；
# 金链 2734~2755(d4) 与枪口闪 2647 一律不动。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r"..\swf\sub1130.swf"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
FFDEC = r"..\tools\packaging\ffdec\ffdec-cli.exe"
IN_XML = "cur.xml"
OUT_XML = "sub1130-chargecenter.xml"
OUT_SWF = "sub1130-chargecenter.swf"

# (spriteId, 旧tx, 旧ty, 新tx, 新ty)
FIXES = [
    ('2774', -280, 90, 55, -41),
    ('2775', -270, 90, 86, 34),
    ('2776', -340, -11, 86, 34),
    ('2777', 4, 130, 159, 36),
]

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper(), f"底稿 {actual} != manifest {manifest_line}"
print("底稿哈希断言 PASS:", actual[:8])

tree = ET.parse(IN_XML); root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid, otx, oty, ntx, nty in FIXES:
    sub = sprites[sid].find('subTags')
    hits = [t for t in sub if 'PlaceObject' in (t.get('type') or '') and t.get('characterId') == '2652']
    assert len(hits) == 1, (sid, len(hits))
    t = hits[0]
    m = t.find('matrix')
    assert (m.get('translateX'), m.get('translateY')) == (str(otx), str(oty)), (sid, m.get('translateX'), m.get('translateY'))
    m.set('translateX', str(ntx)); m.set('translateY', str(nty))
    print(f"{sid}: 2652 ({otx},{oty}) -> ({ntx},{nty})")

# 枪口闪 2647 与金链 2734 首帧原样断言
for sid, _, _, _, _ in FIXES:
    sub = sprites[sid].find('subTags')
    flash = [t for t in sub if t.get('characterId') == '2647']
    chain = [t for t in sub if t.get('characterId') == '2734']
    assert len(flash) == 1 and len(chain) == 1, sid
print("2647 枪口闪 / 2734 金链 未动 PASS")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
