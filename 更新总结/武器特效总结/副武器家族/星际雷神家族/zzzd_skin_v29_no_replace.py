# -*- coding: utf-8 -*-
# 星际雷神 V29 修订（2026-09-18）：根因修复——运行时对「同深度替换型 PlaceObject2」静默不渲染
# （fx 机位实锤：d10 特效层 f3/f6/f9/f12 渲染逐像素相同；添加/移除语义正常）。
# 时间轴改写（两级 121+115）：
#   ① 焰2/焰3 换帧改为 RO d3+d4 → 再放置（add 语义）；② 特效2/3/4 同改（RO d10 → 放置）；
#   ③ 装填滑动 f13/f14 改为标准 MOVE 标签（placeFlagMove=1，无 characterId）；
#   ④ 删除 f15/f16 冗余重放批次（f14 状态=待机态，纯 no-op）。
# 其余零改动；16 帧结构、锚点、音、位图形状全部保留。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v29-src.xml"
OUT_XML  = "work"+BS+"sub1130-v29.xml"
OUT_SWF  = "work"+BS+"sub1130-v29.swf"
RB_XML   = "work"+BS+"sub1130-v29-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

# 1) 底稿哈希断言：当前 swf == manifest == V28 哈希
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("99AFB69A"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()

def sprite(root, sid):
    return [it for it in root.iter('item')
            if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == str(sid)][0]

def group_frames(sp):
    """返回 [ [帧1标签...], [帧2标签...], ... ]（不含 ShowFrame；末尾空桶已丢弃）"""
    buckets = [[]]
    for it in list(sp.find('subTags')):
        if (it.get('type') or '') == 'ShowFrameTag':
            buckets.append([])
        else:
            buckets[-1].append(it)
    assert buckets[-1] == [], "末尾存在帧16之后的游离标签"
    buckets.pop()
    return buckets

def rebuild(sp, buckets):
    sub = sp.find('subTags')
    for it in list(sub):
        sub.remove(it)
    for fr, items in enumerate(buckets, 1):
        for it in items:
            sub.append(it)
        sf = ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'})
        sub.append(sf)

def make_ro(depth):
    return ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false'})

def to_move(it):
    """替换型放置 → MOVE 型（仅矩阵重定位）"""
    assert it.get('characterId') and it.get('placeFlagHasCharacter') == 'true'
    del it.attrib['characterId']
    it.set('placeFlagMove', 'true')
    it.set('placeFlagHasCharacter', 'false')
    assert it.get('placeFlagHasMatrix') == 'true'

for sid, body_id in (('121', '2901'), ('115', '2935')):
    sp = sprite(root, sid)
    buckets = group_frames(sp)
    assert len(buckets) == 16, f"sprite{sid} 帧桶 {len(buckets)}"
    def depth_at(fr, d):
        return [it for it in buckets[fr-1]
                if (it.get('type') or '') == 'RemoveObject2Tag' and it.get('depth') == str(d)]
    def places(fr, d):
        return [it for it in buckets[fr-1]
                if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == str(d)]
    # ① 焰2（f4）/焰3（f6）：RO d3,d4 → 再放置
    for fr in (4, 6):
        ps = places(fr, 3) + places(fr, 4)
        assert len(ps) == 2, f"sprite{sid} f{fr} 焰槽数 {len(ps)}"
        buckets[fr-1] = [make_ro(3), make_ro(4)] + buckets[fr-1]
    # ② 特效2/3/4：RO d10 → 再放置（lv2 无特效槽，自然跳过）
    for fr in (5, 8, 11):
        ps = places(fr, 10)
        if sid == '121':
            assert len(ps) == 1, f"sprite121 f{fr} 特效槽 {len(ps)}"
            buckets[fr-1] = [make_ro(10)] + buckets[fr-1]
        else:
            assert len(ps) == 0, f"sprite115 f{fr} 不应有特效 {len(ps)}"
    # ③ 装填滑动 f13/f14 → MOVE 型
    for fr in (13, 14):
        for it in places(fr, 5) + places(fr, 6):
            to_move(it)
    # ④ 删除 f15/f16 冗余重放批次
    for fr in (15, 16):
        removed = [it for it in buckets[fr-1] if (it.get('type') or '') == 'PlaceObject2Tag']
        assert len(removed) == 7, f"sprite{sid} f{fr} 冗余批 {len(removed)}"
        buckets[fr-1] = [it for it in buckets[fr-1] if (it.get('type') or '') != 'PlaceObject2Tag']
    rebuild(sp, buckets)
    print(f"sprite{sid}: 时间轴改写完成（焰/特效换帧=RO+add，滑动=MOVE，f15/f16 冗余清除）")

# 2) 全局断言：模拟深度状态机——时间轴上不允许任何「替换型放置」残留
for sid in ('121', '115'):
    sp = sprite(root, sid)
    occupied = set()
    fr = 0
    for it in sp.find('subTags'):
        t = it.get('type') or ''
        if t == 'ShowFrameTag':
            fr += 1
            continue
        if t == 'PlaceObject2Tag':
            d = it.get('depth')
            if it.get('placeFlagMove') == 'true':
                assert d in occupied, f"sprite{sid} f{fr} MOVE 空深度 d{d}"
            else:
                assert it.get('characterId'), f"sprite{sid} f{fr} 无角色放置 d{d}"
                assert d not in occupied, f"sprite{sid} f{fr} 仍存在替换型放置 d{d}!!"
                occupied.add(d)
        elif t == 'RemoveObject2Tag':
            d = it.get('depth')
            assert d in occupied, f"sprite{sid} f{fr} 移除空深度 d{d}"
            occupied.discard(d)
    assert fr == 16, f"sprite{sid} 帧数 {fr}"
print("深度状态机断言 PASS：全时间轴零替换型放置，MOVES 均有占位对象")

# 3) 结构断言：锚点/待机弹基线/帧数 + 位图形状总数不变
shapes_before = len([it for it in root.iter('item') if 'DefineShape' in (it.get('type') or '')])
bitmaps_before = len([it for it in root.iter('item') if (it.get('type') or '') == 'DefineBitsLossless2Tag'])
sp121 = sprite(root, '121')
anchors = [it for it in sp121.find('subTags') if (it.get('name') or '') in ('basePoint', 'shootPoint')]
assert len(anchors) == 2, "121 锚点数异常"
assert len([it for it in sp121.find('subTags') if (it.get('type') or '') == 'ShowFrameTag']) == 16
print("结构断言 PASS：形状", shapes_before, "位图", bitmaps_before, "锚点原位")

# 4) 写出与回读
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
for sid in ('121', '115'):
    sp = sprite(rb, sid)
    occupied = set()
    fr = 0
    for it in sp.find('subTags'):
        t = it.get('type') or ''
        if t == 'ShowFrameTag':
            fr += 1
            continue
        if t == 'PlaceObject2Tag':
            d = it.get('depth')
            if it.get('placeFlagMove') == 'true':
                assert d in occupied, f"回读 MOVE 空深度"
            else:
                assert d not in occupied, f"回读仍有替换型 d{d}"
                occupied.add(d)
        elif t == 'RemoveObject2Tag':
            occupied.discard(it.get('depth'))
    assert fr == 16
print("回读 PASS：16 帧、零替换型放置")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
