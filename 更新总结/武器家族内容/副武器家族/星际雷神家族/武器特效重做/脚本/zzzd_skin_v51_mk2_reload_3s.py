# -*- coding: utf-8 -*-
# 星际雷神 V51 修订（2026-09-19，仅 lv2/MK2；独立装填 3 秒——用户 directive）：
# 需求：MK2 装填时间独立于 MK1，改为发射之后 3 秒（原沿用 MK1 节奏≈4.6s）。
# 机制：attackGap=press-to-press（ArmsAttack.attackPan overing 态），attackDelay 后开火；
#       MC 时间轴每次攻击 start 重启。舞台/逻辑帧率均 30fps（INIT.FPS=30，game.swf frameRate=30）。
# 现态：发射 f27(0.867s)、滑装 f118~f166、装填完成 f166=发射后 4.63s≈"5秒"、attackGap=5.8。
# 改动：
#   1) 时间轴（sprite115）：滑装块整体前移 49 帧——f118/126/134/142/150/158/166 → f69/77/85/93/101/109/117，
#      装填完成 = f117 = f27+90 = 发射后 3.0s 整；滑装 x/ty 值（V49 收口态）一字不变，纯位置平移；
#   2) 配置（另行走 binary-patches）：lv2 attackGap 5.8→3.81（=0.81 延迟 + 3.0 装填）。
# 配套核验：f27 RO弹/焰/音、V46 蓄力链 f17~f27 均不受影响（帧号 < f69 不动）。
# 验证：V49 现值逐帧断言、内容不变断言（移出的 14 元素序列化零变化 + 其余元素流零变化）、回读逐帧 FOUND。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = ".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v51-src.xml"
OUT_XML  = "work"+BS+"sub1130-v51.xml"
OUT_SWF  = "work"+BS+"sub1130-v51.swf"
RB_XML   = "work"+BS+"sub1130-v51-readback.xml"
FFDEC    = ".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = ".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("63CA6799"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()
sp = [it for it in root.iter('item')
      if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
subs = sp.find('subTags')

# 收集 V49 现态滑装块
fr = 1
found = {5: [], 6: []}   # (frame, element)
for it in list(subs):
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1; continue
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    if d in ('5', '6'):
        m = it.find('matrix')
        found[int(d)].append((fr, it, m.get('translateX'), m.get('translateY')))
exp = {5: [(1,'941','350'),(118,'840','350'),(126,'920','350'),(134,'940','350'),(142,'941','350'),(150,'941','350'),(158,'941','350'),(166,'941','350')],
       6: [(1,'926','785'),(118,'840','785'),(126,'920','785'),(134,'926','785'),(142,'926','785'),(150,'926','785'),(158,'926','785'),(166,'926','785')]}
for d in (5, 6):
    got = [(f, tx, ty) for f, it, tx, ty in found[d]]
    assert got == exp[d], f"d{d} 现值异常: {got}"
assert found[5][0][1].get('characterId') == '2905' and found[6][0][1].get('characterId') == '2905'
print("现值断言 PASS：d5/d6 各 8 条目（f1 待机 + f118~f166 滑装块）与 V48/V49 态完全一致")

# 移出滑装块（f118~f166，f1 待机保留原位）→ 重插（帧号 -49）
moved = []
for d in (5, 6):
    for f, it, tx, ty in found[d]:
        if f == 1:
            continue
        subs.remove(it)
        moved.append((d, f, it))
assert len(moved) == 14
sf_idx = [i for i, it in enumerate(subs) if (it.get('type') or '') == 'ShowFrameTag']
assert len(sf_idx) >= 117, f"帧数不足 {len(sf_idx)}"
SHIFT = 49
placed = 0
for d, f, it in sorted(moved, key=lambda x: -x[1]):   # 降序帧插入，位置不漂移
    nf = f - SHIFT
    pos = sf_idx[nf - 1]
    subs.insert(pos, it)
    placed += 1
assert placed == 14
print("平移 PASS：滑装块 f118~f166 → f69~f117（-49 帧），装填完成 = f117 = 发射(f27)+90 帧 = 3.0s")

# 内容不变断言：移出再插回原位 = 与底稿零差异（纯平移、零内容变化）
# 内容不变断言：先从新帧位取出，再按【原帧位】插回 = 与底稿逐字节零差异（纯平移、零内容变化）。
# sf_idx 删除后只算一次；循环内不重算（否则同帧第二项目标位漂移）。降序帧+降序深度，
# 同帧同索引后插者居前 → 帧块内恢复原始 [d5, d6] 次序。
for d, f, it in moved:
    subs.remove(it)
sf_idx = [i for i, x in enumerate(subs) if (x.get('type') or '') == 'ShowFrameTag']
for d, f, it in sorted(moved, key=lambda x: (-x[1], -x[0])):
    subs.insert(sf_idx[f - 1], it)
a = [ET.tostring(x, encoding='unicode') for x in ET.parse(SRC_XML).getroot().iter('item')]
b = [ET.tostring(x, encoding='unicode') for x in root.iter('item')]
assert a == b, "按原位插回后与底稿不一致"
print("内容不变断言 PASS：按原位插回后与底稿逐元素零差异（纯平移）")
# 再按新帧位取出重插（最终态；同样只算一次索引）
for d, f, it in moved:
    subs.remove(it)
sf_idx = [i for i, x in enumerate(subs) if (x.get('type') or '') == 'ShowFrameTag']
for d, f, it in sorted(moved, key=lambda x: (-x[1], -x[0])):
    subs.insert(sf_idx[f - SHIFT - 1], it)
print("内容不变断言 PASS：14 项序列化内容与相对次序零变化（纯平移）")

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
f27_ro = []
charge = []
for it in sp2.find('subTags'):
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1; continue
    if t == 'RemoveObject2Tag' and it.get('depth') in ('5', '6') and fr == 27:
        f27_ro.append((fr, it.get('depth')))
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    if d in ('5', '6'):
        m = it.find('matrix')
        got[int(d)].append((fr, m.get('translateX'), m.get('translateY')))
    elif d == '10':
        charge.append((fr, it.get('characterId')))
exp_new = {5: [(1,'941','350'),(69,'840','350'),(77,'920','350'),(85,'940','350'),(93,'941','350'),(101,'941','350'),(109,'941','350'),(117,'941','350')],
           6: [(1,'926','785'),(69,'840','785'),(77,'920','785'),(85,'926','785'),(93,'926','785'),(101,'926','785'),(109,'926','785'),(117,'926','785')]}
for d in (5, 6):
    assert got[d] == exp_new[d], f"d{d} 回读不一致: {got[d]}"
assert sorted(f27_ro) == [(27, '5'), (27, '6')], f27_ro
assert [c for c in charge if c[0] in (17,19,21,23,25)] == [(17,'2915'),(19,'2917'),(21,'2919'),(23,'2921'),(25,'2923')], charge
print("回读 FOUND：新滑装轨 f69~f117 全命中；f27 RO 弹与蓄力链 f17~f25 未受影响")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
