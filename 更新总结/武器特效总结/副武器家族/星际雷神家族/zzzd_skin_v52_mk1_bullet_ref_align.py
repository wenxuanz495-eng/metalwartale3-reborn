# -*- coding: utf-8 -*-
# 星际雷神 V52 修订（2026-09-19，仅 lv1/MK1；上下弹对齐参考画布——用户 directive）：
# 依据：雷神mk1\星际雷神参考1.png（200×70）逐像素实测——部件1(k1部件1)@画布(36,6) 命中率 100%；
#   子弹锚：上弹 (119,17)→相对部件1 (+83,+11)、下弹 (118,46)→相对部件1 (+82,+40)（露尖段=弹头，与 MK2 同构）；
#   参考2 无子弹=发射后参考（正常）。
# 换算（本体锚 -208,210 + 参考锚×15tw, scale.75）：
#   上弹理论 (1037,375)：x 已精确；y 365→375（+10tw=下移 0.5px，全链 8 条目含装填轨道）
#   下弹理论 (1022,810)：x 1037→1022（-15tw=左移 0.75px）、y 817→810（-7tw=上移 0.35px）
# 连带（V49 教训）：装填轨尾 f166 与待机坐标必须全等——下弹轨尾 x 1037→1022 同步收口，中段 900~1000 单调不越位。
# 其余零改动（出膛点/焰/蓄力链/真弹线未动；真弹线与贴图线既存偏差 ±1.2px，配平另议）。
# 验证：逐帧现值断言→全元素 diff 16 叶子+容器→回读逐帧 FOUND。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = ".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v52-src.xml"
OUT_XML  = "work"+BS+"sub1130-v52.xml"
OUT_SWF  = "work"+BS+"sub1130-v52.swf"
RB_XML   = "work"+BS+"sub1130-v52-readback.xml"
FFDEC    = ".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = ".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("D7848729"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()
sp = [it for it in root.iter('item')
      if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '121'][0]
subs = sp.find('subTags')

fr = 1
got = {5: [], 6: []}
for it in subs:
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1; continue
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    if d in ('5', '6'):
        m = it.find('matrix')
        got[int(d)].append((fr, m.get('translateX'), m.get('translateY')))
exp_cur = {5: [(1,'1037','365'),(118,'900','365'),(126,'920','365'),(134,'940','365'),(142,'960','365'),(150,'980','365'),(158,'1000','365'),(166,'1037','365')],
           6: [(1,'1037','817'),(118,'900','817'),(126,'920','817'),(134,'940','817'),(142,'960','817'),(150,'980','817'),(158,'1000','817'),(166,'1037','817')]}
for d in (5, 6):
    assert got[d] == exp_cur[d], f"d{d} 现值异常: {got[d]}"
print("现值断言 PASS：d5/d6 各 8 条目与既存态完全一致")

exp_new = {5: [(1,'1037','375'),(118,'900','375'),(126,'920','375'),(134,'940','375'),(142,'960','375'),(150,'980','375'),(158,'1000','375'),(166,'1037','375')],
           6: [(1,'1022','810'),(118,'900','810'),(126,'920','810'),(134,'940','810'),(142,'960','810'),(150,'980','810'),(158,'1000','810'),(166,'1022','810')]}
# 逐条目修改（got 与 exp_cur/exp_new 同构同序；无变化者计数为 0）
fr = 1
idx = {5: 0, 6: 0}
changed = 0
for it in subs:
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1; continue
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    if d in ('5', '6'):
        m = it.find('matrix')
        nf, ntx, nty = exp_new[int(d)][idx[int(d)]]
        if (fr, m.get('translateX'), m.get('translateY')) != (nf, ntx, nty):
            m.set('translateX', ntx); m.set('translateY', nty)
            changed += 1
        idx[int(d)] += 1
assert changed == 16, f"改动数 {changed} 应为 16"
print("矩阵修改 PASS：d5 全链 ty 365→375（8 条目）；d6 全链 y 817→810 且待机/轨尾 x→1022（16 处变化）")

ftree = ET.parse(SRC_XML)
a = [ET.tostring(x, encoding='unicode') for x in ftree.iter('item')]
b = [ET.tostring(x, encoding='unicode') for x in tree.iter('item')]
assert len(a) == len(b)
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 16 and len(cont) == 1, f"diff 叶子{len(leaf)} 容器{len(cont)}"
assert all('121' in a[i][:120] for i in cont)
print("全元素级 diff 断言 PASS：叶子 16 处＋容器 sprite121，其余零改动")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()

r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
sp2 = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '121'][0]
fr = 1
got2 = {5: [], 6: []}
for it in sp2.find('subTags'):
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1; continue
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    if d in ('5', '6'):
        m = it.find('matrix')
        got2[int(d)].append((fr, m.get('translateX'), m.get('translateY')))
for d in (5, 6):
    assert got2[d] == exp_new[d], f"d{d} 回读不一致: {got2[d]}"
print("回读 FOUND：d5/d6 逐帧新态全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
