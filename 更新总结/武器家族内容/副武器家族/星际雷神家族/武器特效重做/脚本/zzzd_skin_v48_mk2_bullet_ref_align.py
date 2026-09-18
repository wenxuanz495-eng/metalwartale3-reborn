# -*- coding: utf-8 -*-
# 星际雷神 V48 修订（2026-09-19，仅 lv2/MK2；上下弹对齐参考画布——用户 directive）：
# 依据：完整参考.png（145×67，部件1 原点）子弹锚点逐像素实测——上弹 (93,16)、下弹 (92,45)
#   （露尖段＝弹右端 10~11px 弹头，余为本体遮挡；发射后版无子弹=差异区互证）。
# 换算（本体锚 -454,110 + 参考锚×15tw, scale.75）：
#   上弹理论 (941,350)：x 已精确；y 333→350（+17tw=下移 0.85px）
#   下弹理论 (926,785)：x 已精确；y 787→785（-2tw=上移 0.1px，V47 后仅剩的残差）
# 改动：sprite115 d5 全链 8 条目 ty 333→350；d6 全链 8 条目 ty 787→785（含 f118~f166 装填轨道）。
# 其余零改动。验证：计数断言/全元素 diff 16 叶子+容器/回读 FOUND。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = ".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v48-src.xml"
OUT_XML  = "work"+BS+"sub1130-v48.xml"
OUT_SWF  = "work"+BS+"sub1130-v48.swf"
RB_XML   = "work"+BS+"sub1130-v48-readback.xml"
FFDEC    = ".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = ".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("FA877718"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()
sp = [it for it in root.iter('item')
      if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
subs = sp.find('subTags')

d5_idx, d6_idx = [], []
for i, it in enumerate(subs):
    t = it.get('type') or ''
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    m = it.find('matrix')
    if d == '5':
        assert m.get('translateY') == '333', f"d5 异常 ty={m.get('translateY')}"
        d5_idx.append(m)
    elif d == '6':
        assert m.get('translateY') == '787', f"d6 异常 ty={m.get('translateY')}"
        d6_idx.append(m)
assert len(d5_idx) == 8 and len(d6_idx) == 8, f"计数异常 d5={len(d5_idx)} d6={len(d6_idx)}"
for m in d5_idx: m.set('translateY', '350')
for m in d6_idx: m.set('translateY', '785')
print("矩阵修改 PASS：d5 上弹 8 条目 ty 333→350；d6 下弹 8 条目 ty 787→785")

ftree = ET.parse(SRC_XML)
a = [ET.tostring(x, encoding='unicode') for x in ftree.iter('item')]
b = [ET.tostring(x, encoding='unicode') for x in tree.iter('item')]
assert len(a) == len(b)
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 16 and len(cont) == 1, f"diff 叶子{len(leaf)} 容器{len(cont)}"
assert all('115' in a[i][:120] for i in cont)
print("全元素级 diff 断言 PASS：叶子 16 处＋容器 sprite115，其余零改动")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()

r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
sp2 = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
got = {'5': [], '6': []}
for it in sp2.find('subTags'):
    if 'PlaceObject' not in (it.get('type') or ''):
        continue
    d = it.get('depth')
    if d in got:
        m = it.find('matrix')
        got[d].append((m.get('translateX'), m.get('translateY')))
assert len(got['5']) == 8 and set(ty for _, ty in got['5']) == {'350'}, got['5']
assert len(got['6']) == 8 and set(ty for _, ty in got['6']) == {'785'}, got['6']
print("回读 FOUND：d5 全链 350 / d6 全链 785 全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
