# -*- coding: utf-8 -*-
# 星际雷神 V27 修订（2026-09-18）：lv1 蓄力特效节奏拉开（trace 实锤：链在播但每帧仅 2~3tick，
# 特效1 66ms 一闪而过、特效4 隐形帧反而停留最长）——
# 四槽改为 特效1@f2~f4、特效2@f5~f7、特效3@f8~f10、特效4@f11~f13、f14 RO d10 清除；
# 矩阵 tx=-210/ty=199/0.75 原样随迁；lv2 不动；其余零改动（全库 (帧,深度,角色) 多重集断言）。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v27-src.xml"
OUT_XML  = "work"+BS+"sub1130-v27.xml"
OUT_SWF  = "work"+BS+"sub1130-v27.swf"
RB_XML   = "work"+BS+"sub1130-v27-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
FX_IDS   = ('2907', '2909', '2911', '2913')
NEW_SLOT = {'2907': 2, '2909': 5, '2911': 8, '2913': 11}   # 特效N -> 起始帧
RO_FRAME = 14

def sprite(root, sid):
    return [it for it in root.iter('item')
            if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == str(sid)][0]

def subtags(sp):
    return sp.find('subTags')

def walk_tags(sp):
    """yield (frame, element) 按文档序"""
    fr = 1
    for it in subtags(sp):
        t = it.get('type') or ''
        if t == 'ShowFrameTag':
            fr += 1
            continue
        yield fr, it

def placement_map(root, sid):
    m = {}
    for fr, it in walk_tags(sprite(root, sid)):
        t = it.get('type') or ''
        if t == 'PlaceObject2Tag':
            key = (fr, it.get('depth'), it.get('characterId'), it.get('placeFlagMove'))
            m[key] = m.get(key, 0) + 1
        elif t == 'RemoveObject2Tag':
            key = (fr, it.get('depth'), 'RO', '')
            m[key] = m.get(key, 0) + 1
    return m

def fx_states(root):
    got = {}
    for fr, it in walk_tags(sprite(root, '121')):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '10' and it.get('characterId') in FX_IDS:
            m = it.find('matrix')
            got.setdefault(fr, []).append((it.get('characterId'), m.get('translateX'), m.get('translateY'), m.get('scaleX'), m.get('scaleY')))
    return got

# 1) 底稿哈希断言：当前 swf == manifest == V26 哈希
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("B9DE7024"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

# 2) swf2xml 底稿导出
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)

before121 = placement_map(tree, '121')
before115 = placement_map(tree, '115')
st = fx_states(tree)
assert sorted(st) == [2, 4, 6, 9], "V26 特效帧 " + str(sorted(st))
for f, lst in st.items():
    assert len(lst) == 1 and lst[0][1:] == ('-210', '199', '0.75', '0.75'), "V26 矩阵异常 f" + str(f) + str(lst)

# 3) 手术：摘下四槽 → 按新帧位回插 + f14 清除
sp121 = sprite(tree, '121')
sub = subtags(sp121)
moved = {}
kept = []
for it in list(sub):
    t = it.get('type') or ''
    if t == 'PlaceObject2Tag' and it.get('depth') == '10' and it.get('characterId') in FX_IDS:
        moved[it.get('characterId')] = it
        sub.remove(it)
    else:
        kept.append(it)
assert sorted(moved) == sorted(FX_IDS), "摘下的特效槽异常"

def frame_end_index(sp, frame):
    """第 frame 个 ShowFrameTag 的下标（该帧结束边界）"""
    fr = 0
    for i, it in enumerate(subtags(sp)):
        if (it.get('type') or '') == 'ShowFrameTag':
            fr += 1
            if fr == frame:
                return i
    raise AssertionError("找不到帧边界 " + str(frame))

for cid in ('2913', '2911', '2909', '2907'):   # 从大到小插，防索引漂移
    f = NEW_SLOT[cid]
    idx = frame_end_index(sp121, f - 1) + 1    # 帧起始 = 上一帧 ShowFrame 之后
    sub.insert(idx, moved[cid])

ro = ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': '10', 'forceWriteAsLong': 'false'})
idx = frame_end_index(sp121, RO_FRAME - 1) + 1
sub.insert(idx, ro)

# 4) 断言：新帧位/矩阵 + 其余放置多重集不变 + lv2 零改动
after_st = fx_states(tree)
assert sorted(after_st) == [2, 5, 8, 11], "V27 特效帧 " + str(sorted(after_st))
for f, lst in after_st.items():
    assert len(lst) == 1 and lst[0][0] == FX_IDS[[2, 5, 8, 11].index(f)], "V27 槽序异常 f" + str(f) + str(lst)
    assert lst[0][1:] == ('-210', '199', '0.75', '0.75'), "V27 矩阵应原样随迁 f" + str(f)
frames = len([it for it in subtags(sp121) if (it.get('type') or '') == 'ShowFrameTag'])
assert frames == 16, "121 帧数 " + str(frames)
ro10 = [(fr, it) for fr, it in walk_tags(sp121) if (it.get('type') or '') == 'RemoveObject2Tag' and it.get('depth') == '10']
assert len(ro10) == 1 and ro10[0][0] == RO_FRAME, "f14 清除标签异常"

# 逐项核对：四槽换帧，其余放置多重集全等，lv2 零改动
def without(d, items):
    d = d.copy()
    for k in items:
        assert d.get(k, 0) > 0, "缺少 " + str(k)
        d[k] -= 1
        if d[k] == 0:
            del d[k]
    return d
old_slots = {(2, '10', '2907', 'false'), (4, '10', '2909', 'false'), (6, '10', '2911', 'false'), (9, '10', '2913', 'false')}
new_slots = {(NEW_SLOT[c], '10', c, 'false') for c in FX_IDS}
after121 = placement_map(tree, '121')
check = without(after121, new_slots | {(RO_FRAME, '10', 'RO', '')})
check = without(check, before121.keys() - old_slots)
assert not check, "意外差异 " + str(check)
assert placement_map(tree, '115') == before115, "115 应零改动"
print("V27 手术断言 PASS：四槽 f2/f5/f8/f11 + f14 清除，其余放置多重集不变，lv2 零改动")

# 5) 写出与回读
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
assert new_hash != actual
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rtree = ET.parse(RB_XML)
rs = fx_states(rtree)
assert sorted(rs) == [2, 5, 8, 11], "回读特效帧 " + str(sorted(rs))
rro = [(fr, it) for fr, it in walk_tags(sprite(rtree, '121')) if (it.get('type') or '') == 'RemoveObject2Tag' and it.get('depth') == '10']
assert len(rro) == 1 and rro[0][0] == RO_FRAME, "回读清除标签异常"
print("回读 FOUND：四槽 f2/f5/f8/f11 + f14 清除 全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
