# -*- coding: utf-8 -*-
# 星际雷神 V46 修订（2026-09-19，仅 lv2/MK2；蓄力特效五帧链装回——用户 directive）：
# 需求：新特效1~5 每张播 2 帧=共 10 帧，蓄力播完才发弹（发射帧=f27，焰+RO弹+音效同帧）。
# 方案：d10 蓄力链 f17 Place 2915(新1) → f19 RO+P 2917(新2) → f21 RO+P 2919(新3) → f23 RO+P 2921(新4)
#       → f25 RO+P 2923(新5，占 f25~f26) → f27 RO d10 清场。覆盖 f17~f26 恰 10 帧，紧贴发射帧。
# 依据：时间轴动画替换失效红线（RO在前放置在后，禁同深度替换——方法总结 20260918）；
#       矩阵克隆本体 2935 现役放置（-454,110 scale0.75）=V20 时代五特效历史锚点原值；
#       字符/位图已核：2915~2923=形状、2914~2922=新特效1~5.png 逐像素一致（V21 仅删放置未删字符）。
# lv1(121) 现役模板：f2/f8/f14/f20 Place、帧内 RO+P、f27 RO——本链同构。
# 验证：d10 空闲断言、幂等回退断言（移除插入项=元素流零差异）、回读逐帧逐标签 FOUND。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = ".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v46-src.xml"
OUT_XML  = "work"+BS+"sub1130-v46.xml"
OUT_SWF  = "work"+BS+"sub1130-v46.swf"
RB_XML   = "work"+BS+"sub1130-v46-readback.xml"
FFDEC    = ".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = ".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("AB9858A9"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()
sp = [it for it in root.iter('item')
      if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
subs = sp.find('subTags')

# 断言：d10 当前空闲、帧数足够
for it in subs:
    t = it.get('type') or ''
    if 'PlaceObject' in t and it.get('depth') == '10':
        raise SystemExit('d10 已被占用: ' + ET.tostring(it, encoding='unicode')[:120])
    if t == 'RemoveObject2Tag' and it.get('depth') == '10':
        raise SystemExit('d10 已有 RO')
sf_idx = [i for i, it in enumerate(subs) if (it.get('type') or '') == 'ShowFrameTag']
assert len(sf_idx) >= 27, f"帧数不足: {len(sf_idx)}"

# 克隆矩阵与标签模板
body_place = None
ro_proto = None
for it in subs:
    t = it.get('type') or ''
    if t == 'PlaceObject2Tag' and it.get('characterId') == '2935' and body_place is None:
        body_place = it
    if t == 'RemoveObject2Tag' and ro_proto is None:
        ro_proto = it
assert body_place is not None and ro_proto is not None

def make_place(char_id):
    el = copy.deepcopy(body_place)
    el.set('characterId', str(char_id))
    el.set('depth', '10')
    return el

def make_ro():
    el = copy.deepcopy(ro_proto)
    el.set('depth', '10')
    return el

# 插入点：帧 N 的内容 = 第 N 个 ShowFrameTag 之前的块（sf_idx[k] = 第 k+1 个 SF 的下标）
# 降序插入：高帧号先插，低索引不漂移；f27 块首 = SF#26 之后一格 = sf_idx[25]+1
chain = [(27, sf_idx[25] + 1, [make_ro()]),
         (25, sf_idx[24], [make_ro(), make_place(2923)]),
         (23, sf_idx[22], [make_ro(), make_place(2921)]),
         (21, sf_idx[20], [make_ro(), make_place(2919)]),
         (19, sf_idx[18], [make_ro(), make_place(2917)]),
         (17, sf_idx[16], [make_place(2915)])]
inserted = []
for frame, pos, els in chain:
    for off, el in enumerate(els):
        subs.insert(pos + off, el)
        inserted.append(el)
print("插入 PASS：d10 链 f17 P2915 / f19 RO+P2917 / f21 RO+P2919 / f23 RO+P2921 / f25 RO+P2923 / f27 块首 RO")

# 幂等回退断言：移除插入项后元素流与原文件零差异
for el in inserted:
    subs.remove(el)
a = [ET.tostring(it, encoding='unicode') for it in ET.parse(SRC_XML).getroot().iter('item')]
b = [ET.tostring(it, encoding='unicode') for it in root.iter('item')]
assert a == b, "回退后与原文件不一致"
for frame, pos, els in chain:  # 重新插入（降序位置不变）
    for off, el in enumerate(els):
        subs.insert(pos + off, el)
print("幂等回退断言 PASS：移除插入项=与底稿零差异（仅新增 9 标签，其余零改动）")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()

# 回读：逐帧逐标签核对 d10 事件序列
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
sp2 = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
events = []
fr = 1
for it in sp2.find('subTags'):
    t = it.get('type') or ''
    if t == 'ShowFrameTag':
        fr += 1; continue
    if t == 'RemoveObject2Tag' and it.get('depth') == '10':
        events.append((fr, 'RO', None, None))
    elif 'PlaceObject' in t and it.get('depth') == '10':
        m = it.find('matrix')
        events.append((fr, 'P', it.get('characterId'), (m.get('translateX'), m.get('translateY'), m.get('scaleX'), m.get('scaleY'))))
expect_events = [
    (17, 'P', '2915', ('-454', '110', '0.75', '0.75')),
    (19, 'RO', None, None), (19, 'P', '2917', ('-454', '110', '0.75', '0.75')),
    (21, 'RO', None, None), (21, 'P', '2919', ('-454', '110', '0.75', '0.75')),
    (23, 'RO', None, None), (23, 'P', '2921', ('-454', '110', '0.75', '0.75')),
    (25, 'RO', None, None), (25, 'P', '2923', ('-454', '110', '0.75', '0.75')),
    (27, 'RO', None, None),
]
assert events == expect_events, "回读不一致:\n" + "\n".join(map(str, events))
print("回读 FOUND：d10 事件序列逐帧逐标签全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
