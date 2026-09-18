# -*- coding: utf-8 -*-
# 星际雷神 V49 修订（2026-09-19，仅 lv2/MK2；装填滑动越位回缩修复——用户 directive）：
# 现象：装填动画子弹超出待机位再回缩（滑动终点 f166 x=1037 = MK1 待机 x，MK2 待机 x=941/926，
#       尾轨 f134~f166 越过待机位 2.5~5px，循环回 f1 时跳回）。
# 方案（用户要求：从左往右滑动最后一帧 = 当前子弹贴图坐标一模一样；并消灭中段越位避免残余回缩）：
#   d5 上弹轨：f118 840 → f126 920 → f134 940 → f142/150/158/166 定格 941（待机 x）
#   d6 下弹轨：f118 840 → f126 920 → f134/142/150/158/166 定格 926（待机 x）
#   f166 = (941,350)/(926,785) 与 f1 待机坐标全等，循环无缝。y 值（350/785，V48）不变。
# 验证：逐帧现值断言→改后全元素 diff 9 叶子+容器→回读逐帧 FOUND。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = ".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v49-src.xml"
OUT_XML  = "work"+BS+"sub1130-v49.xml"
OUT_SWF  = "work"+BS+"sub1130-v49.swf"
RB_XML   = "work"+BS+"sub1130-v49-readback.xml"
FFDEC    = ".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = ".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("1338DF28"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()
sp = [it for it in root.iter('item')
      if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]

# 收集 d5/d6 全部放置（含 MOVE），按帧登记
fr = 1
track = {5: [], 6: []}   # (frame, matrix元素, tx, ty)
for it in sp.find('subTags'):
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1; continue
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    if d in ('5', '6'):
        m = it.find('matrix')
        track[int(d)].append((fr, m, m.get('translateX'), m.get('translateY')))

# 现值断言（V48 后）
exp_cur = {5: [(1,'941','350'),(118,'840','350'),(126,'920','350'),(134,'940','350'),
               (142,'960','350'),(150,'980','350'),(158,'1000','350'),(166,'1037','350')],
           6: [(1,'926','785'),(118,'840','785'),(126,'920','785'),(134,'940','785'),
               (142,'960','785'),(150,'980','785'),(158,'1000','785'),(166,'1037','785')]}
for d in (5, 6):
    got = [(f, tx, ty) for f, m, tx, ty in track[d]]
    assert got == exp_cur[d], f"d{d} 现值异常: {got}"
print("现值断言 PASS：d5/d6 各 8 条目与 V48 态完全一致")

# 尾轨收口（f134 起）
new_tx = {5: {142:'941', 150:'941', 158:'941', 166:'941'},
          6: {134:'926', 142:'926', 150:'926', 158:'926', 166:'926'}}
changed = 0
for d in (5, 6):
    for f, m, tx, ty in track[d]:
        if f in new_tx[d]:
            assert tx != new_tx[d][f]
            m.set('translateX', new_tx[d][f])
            changed += 1
assert changed == 9, f"改动数 {changed} 应为 9"
print("矩阵修改 PASS：d5 f142~f166 →941（4 条目）；d6 f134~f166 →926（5 条目）；f166=(941,350)/(926,785) 与 f1 全等")

# 全元素 diff
ftree = ET.parse(SRC_XML)
a = [ET.tostring(x, encoding='unicode') for x in ftree.iter('item')]
b = [ET.tostring(x, encoding='unicode') for x in tree.iter('item')]
assert len(a) == len(b)
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 9 and len(cont) == 1, f"diff 叶子{len(leaf)} 容器{len(cont)}"
assert all('115' in a[i][:120] for i in cont)
print("全元素级 diff 断言 PASS：叶子 9 处＋容器 sprite115，其余零改动")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()

# 回读
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
sp2 = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
fr = 1
got = {5: [], 6: []}
for it in sp2.find('subTags'):
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1; continue
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    if d in ('5', '6'):
        m = it.find('matrix')
        got[int(d)].append((fr, m.get('translateX'), m.get('translateY')))
exp_new = {5: [(1,'941'),(118,'840'),(126,'920'),(134,'940'),(142,'941'),(150,'941'),(158,'941'),(166,'941')],
           6: [(1,'926'),(118,'840'),(126,'920'),(134,'926'),(142,'926'),(150,'926'),(158,'926'),(166,'926')]}
for d in (5, 6):
    g = [(f, tx) for f, tx, ty in got[d]]
    tys = set(ty for f, tx, ty in got[d])
    want_ty = {'350'} if d == 5 else {'785'}
    assert g == exp_new[d] and tys == want_ty, f"d{d} 回读不一致: {got[d]}"
print("回读 FOUND：d5/d6 逐帧新轨全部命中，y 值 350/785 未动")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
