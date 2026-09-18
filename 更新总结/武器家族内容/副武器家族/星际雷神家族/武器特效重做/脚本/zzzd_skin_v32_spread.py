# -*- coding: utf-8 -*-
# 星际雷神 V32 修订（2026-09-18，两级；待机飞弹散开±1px）：
# 贴图飞弹上弹上移 1px（ty −20tw）、下弹下移 1px（ty +20tw）——
# 121：f1/f164 放置 + f172~f212 六组 MOVE，d5 385→365、d6 797→817（14 处）；
# 115：同构，d5 353→333、d6 787→807（14 处）。
# 联动配置：bulletTranslation lv1 11.5→12.5、lv2 11.05→12.05（间距=2×tran，双弹各随 ±1px，
#   真子弹路径与开火坐标同步——V14 先例：10.5→11.5 对位 ±1px）。
# 其余零改动（全元素级 diff 断言）。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v32-src.xml"
OUT_XML  = "work"+BS+"sub1130-v32.xml"
OUT_SWF  = "work"+BS+"sub1130-v32.swf"
RB_XML   = "work"+BS+"sub1130-v32-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("96C6CB44"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()

changed = 0
for sid, d5_old, d6_old in (('121', '385', '797'), ('115', '353', '787')):
    sp = [it for it in root.iter('item')
          if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]
    n5 = n6 = 0
    for it in sp.find('subTags'):
        if (it.get('type') or '') != 'PlaceObject2Tag':
            continue
        if it.get('characterId') is not None:
            continue                       # 只动 MOVE 型（无 characterId）的导弹重定位
        if it.get('depth') == '5' and it.get('placeFlagMove') == 'true':
            m = it.find('matrix')
            assert m.get('translateY') == d5_old, f"sprite{sid} d5 ty={m.get('translateY')}"
            m.set('translateY', str(int(d5_old) - 20))
            n5 += 1
        elif it.get('depth') == '6' and it.get('placeFlagMove') == 'true':
            m = it.find('matrix')
            assert m.get('translateY') == d6_old, f"sprite{sid} d6 ty={m.get('translateY')}"
            m.set('translateY', str(int(d6_old) + 20))
            n6 += 1
    # f1/f164 的放置型导弹（add 语义，带 characterId）
    for it in sp.find('subTags'):
        if (it.get('type') or '') != 'PlaceObject2Tag':
            continue
        if it.get('characterId') != '2905':
            continue
        m = it.find('matrix')
        if it.get('depth') == '5':
            assert m.get('translateY') == d5_old
            m.set('translateY', str(int(d5_old) - 20))
            n5 += 1
        elif it.get('depth') == '6':
            assert m.get('translateY') == d6_old
            m.set('translateY', str(int(d6_old) + 20))
            n6 += 1
    assert (n5, n6) == (8, 8), f"sprite{sid} 修改数 d5={n5} d6={n6}"
    changed += n5 + n6
    print(f"sprite{sid}: d5 上移1px ×{n5}，d6 下移1px ×{n6}")
assert changed == 32

# 全元素级 diff：28 处叶子 + 2 个容器
ftree = ET.parse(SRC_XML)
a = [ET.tostring(it, encoding='unicode') for it in ftree.iter('item')]
b = [ET.tostring(it, encoding='unicode') for it in tree.iter('item')]
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 32, "叶子 diff " + str(len(leaf))
assert len(cont) == 2, "容器 diff " + str(len(cont))
print("全元素级 diff 断言 PASS：叶子 32 处 ty 变化＋容器 121/115 随之差异")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
# 回读
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
for sid, d5_new, d6_new in (('121', '365', '817'), ('115', '333', '807')):
    sp = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]
    n = 0
    for it in sp.find('subTags'):
        if (it.get('type') or '') != 'PlaceObject2Tag' or it.get('characterId') is not None:
            if it.get('characterId') != '2905':
                continue
        if it.get('depth') == '5':
            assert it.find('matrix').get('translateY') == d5_new, f"回读 {sid} d5"
            n += 1
        elif it.get('depth') == '6':
            assert it.find('matrix').get('translateY') == d6_new, f"回读 {sid} d6"
            n += 1
    assert n == 16, f"回读 {sid} 处数 {n}"
print("回读 PASS：32 处 ty 全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
