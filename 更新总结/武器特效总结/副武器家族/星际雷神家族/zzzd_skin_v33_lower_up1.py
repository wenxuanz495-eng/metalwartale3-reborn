# -*- coding: utf-8 -*-
# 星际雷神 V33 修订（2026-09-18，两级；下层三件套同步上移 1px）：
# ① 贴图飞弹下弹（d6）上移 1px：ty −20tw（lv1 817→797 / lv2 807→787；8 处/级=f1/f164 放置+6 组 MOVE）
# ② 下层火焰（d4）同步上移 1px：ty −20tw（lv1 775/805/827→755/785/807；lv2 725/755/778→705/735/758）
# ③ 真子弹联动：bulletTranslation −1（lv1 12.5→11.5 / lv2 12.05→11.05，配置另改）
# 其余零改动（全元素级 diff 断言：每级 11 处叶子 + 1 容器）。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v33-src.xml"
OUT_XML  = "work"+BS+"sub1130-v33.xml"
OUT_SWF  = "work"+BS+"sub1130-v33.swf"
RB_XML   = "work"+BS+"sub1130-v33-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("E57342ED"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()

# ①② d6 导弹（8 处/级）+ d4 火焰（3 处/级）ty −20tw
for sid, d6_old, flame_olds in (('121', '817', ('775', '805', '827')),
                                 ('115', '807', ('725', '755', '778'))):
    sp = [it for it in root.iter('item')
          if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]
    n6 = n4 = 0
    for it in sp.find('subTags'):
        if (it.get('type') or '') != 'PlaceObject2Tag':
            continue
        m = it.find('matrix')
        if m is None:
            continue
        if it.get('depth') == '6' and m.get('translateY') == d6_old:
            m.set('translateY', str(int(d6_old) - 20))
            n6 += 1
        if it.get('depth') == '4' and m.get('translateY') in flame_olds and it.get('characterId') in ('2927', '2929', '2925'):
            m.set('translateY', str(int(m.get('translateY')) - 20))
            n4 += 1
    assert (n6, n4) == (8, 3), f"sprite{sid} 修改数 d6={n6} d4={n4}"
    print(f"sprite{sid}: d6 上移1px ×{n6}，d4 火焰上移1px ×{n4}")

# 全元素级 diff：每级 11 处叶子 + 容器
ftree = ET.parse(SRC_XML)
a = [ET.tostring(it, encoding='unicode') for it in ftree.iter('item')]
b = [ET.tostring(it, encoding='unicode') for it in tree.iter('item')]
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 22, "叶子 diff " + str(len(leaf))
assert len(cont) == 2, "容器 diff " + str(len(cont))
print("全元素级 diff 断言 PASS：叶子 22 处 ty 变化＋容器 121/115 随之差异")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("回读 PASS")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
