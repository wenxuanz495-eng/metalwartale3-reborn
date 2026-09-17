# -*- coding: utf-8 -*-
# 星际雷神 V30 修订（2026-09-18，仅 lv1；火焰两处微调）：
# ① 焰1（开火1，暗根 9 列≈6.75px 透出特效球缝隙）：f2 的 d3/d4 两份放置 tx 1607→1667（+60tw=右移3px，
#    暗根藏入炮口，亮核从炮口唇边起始）；
# ② 下层筒火焰（d4）三帧整体下移 2px：ty 735→775 / 765→805 / 787→827（+40tw×3）。
# 其余零改动（全元素级 diff 断言）。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v30-src.xml"
OUT_XML  = "work"+BS+"sub1130-v30.xml"
OUT_SWF  = "work"+BS+"sub1130-v30.swf"
RB_XML   = "work"+BS+"sub1130-v30-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("71410C53"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()

def sprite(sid):
    return [it for it in root.iter('item')
            if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]

def subtags(sid):
    return sprite(sid).find('subTags')

def flame_slots():
    """返回 {(frame, depth): element} 的焰放置（121 的 d3/d4）"""
    got = {}
    fr = 1
    for it in subtags('121'):
        t = it.get('type') or ''
        if t == 'ShowFrameTag':
            fr += 1
            continue
        if t == 'PlaceObject2Tag' and it.get('depth') in ('3', '4') and it.get('characterId') in ('2925', '2927', '2929'):
            got[(fr, int(it.get('depth')))] = it
    return got

slots = flame_slots()
assert sorted(slots) == [(2, 3), (2, 4), (4, 3), (4, 4), (6, 3), (6, 4)], sorted(slots)
for (fr, d), it in slots.items():
    m = it.find('matrix')
    assert m.get('translateX') == '1607', f"f{fr} d{d} tx={m.get('translateX')}"

# 手术①：焰1（f2 的 d3/d4）tx +60tw
for d in (3, 4):
    m = slots[(2, d)].find('matrix')
    assert m.get('translateX') == '1607'
    m.set('translateX', '1667')
# 手术②：d4 三帧 ty +40tw
for fr, old in ((2, '735'), (4, '765'), (6, '787')):
    m = slots[(fr, 4)].find('matrix')
    assert m.get('translateY') == old, f"f{fr} ty={m.get('translateY')}"
    m.set('translateY', str(int(old) + 40))

# 断言：逐项核对六份矩阵
expect = {(2, 3): ('1667', '322'), (2, 4): ('1667', '775'),
          (4, 3): ('1607', '352'), (4, 4): ('1607', '805'),
          (6, 3): ('1607', '375'), (6, 4): ('1607', '827')}
for key, (tx, ty) in expect.items():
    m = slots[key].find('matrix')
    assert m.get('translateX') == tx and m.get('translateY') == ty, f"{key} 矩阵异常"
print("焰放置矩阵断言 PASS：焰1 双筒 +3px 内移；d4 三帧 +2px 下移")

# 全元素级 diff：只允许这 6 处叶子矩阵变化
ftree = ET.parse(SRC_XML)
a = [ET.tostring(it, encoding='unicode') for it in ftree.iter('item')]
b = [ET.tostring(it, encoding='unicode') for it in tree.iter('item')]
assert len(a) == len(b)
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 4, "叶子 diff 处数 " + str(len(leaf))
assert len(cont) == 1 and 'spriteId="121"' in a[cont[0]], "容器 diff 应恰为 sprite121"
for i in leaf:
    assert 'translateX="1607"' in a[i] or 'translateY="735"' in a[i] or 'translateY="765"' in a[i] or 'translateY="787"' in a[i]
print("全元素级 diff 断言 PASS：叶子仅 6 处矩阵变化＋容器 sprite121 随之差异")

# 写出与回读
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
sp = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '121'][0]
got = {}
fr = 1
for it in sp.find('subTags'):
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1
        continue
    if t == 'PlaceObject2Tag' and it.get('depth') in ('3', '4') and it.get('characterId') in ('2925', '2927', '2929'):
        m = it.find('matrix')
        got[(fr, int(it.get('depth')))] = (m.get('translateX'), m.get('translateY'))
assert got == expect, "回读矩阵不一致 " + str(got)
print("回读 FOUND：六份矩阵全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
