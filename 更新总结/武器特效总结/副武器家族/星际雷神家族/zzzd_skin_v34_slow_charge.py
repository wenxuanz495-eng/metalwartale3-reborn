# -*- coding: utf-8 -*-
# 星际雷神 V34 修订（2026-09-18，两级；装填间隔 5s→3s＋蓄力放慢一倍）：
# ① 特效四帧停留 3tick→6tick：特效1@f2~f7、特效2@f8~13、特效3@f14~19、特效4@f20~26（蓄力总时长 0.4s→0.8s）；
# ② 发射帧 f27（RO d10 蓄力结束 + RO d5/d6 出膛 + 焰1 + StartSound，attackDelay 0.43→0.85 使真子弹 f27 同帧生成）；
#    焰2@f29、焰3@f31（RO+add）、f33 焰清除（火焰节奏不变）；
# ③ 空膛暴露 3 秒：f34~f117 hold，f118 导弹隐藏位放置（900tw）；f126~f174 逐像素 MOVE 滑入（1px/8tick，1.87s）；
# ④ frameCount=176，attackGap 7.6→5.8（配置另改）。
# 全程 V29 零替换写法；锚点/枪口生成点（shootPoint 1703/1683）保留。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v34-src.xml"
OUT_XML  = "work"+BS+"sub1130-v34.xml"
OUT_SWF  = "work"+BS+"sub1130-v34.swf"
RB_XML   = "work"+BS+"sub1130-v34-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
NF = 176

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("E57342ED"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()

def sprite(sid):
    return [it for it in root.iter('item')
            if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]

def frame_buckets(sp):
    b = [[]]
    for it in list(sp.find('subTags')):
        if (it.get('type') or '') == 'ShowFrameTag':
            b.append([])
        else:
            b[-1].append(it)
    assert b[-1] == [], "游离标签"
    b.pop()
    return b

def find_frame(buckets, fr, kind, depth=None):
    return [it for it in buckets[fr-1]
            if (it.get('type') or '') == kind and (depth is None or it.get('depth') == str(depth))]

def RO(depth):
    return ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false'})

def MOVE(depth, tx):
    return ET.Element('item', {'type': 'PlaceObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false',
        'placeFlagHasClipActions': 'false', 'placeFlagHasClipDepth': 'false', 'placeFlagHasColorTransform': 'false',
        'placeFlagHasMatrix': 'true', 'placeFlagHasName': 'false', 'placeFlagHasRatio': 'false',
        'placeFlagMove': 'true'})

def MAT(tx, ty, scale='0.75'):
    return ET.Element('matrix', {'type': 'MATRIX', 'hasRotate': 'false', 'hasScale': 'true',
        'nRotateBits': '0', 'nScaleBits': '17', 'nTranslateBits': '12', 'scaleX': scale, 'scaleY': scale,
        'translateX': str(tx), 'translateY': str(ty)})

def build_new(sp, lv):
    old = frame_buckets(sp)
    assert len(old) == 230, f"sprite{lv} 底稿帧数 {len(old)} 应为 230（V31 布局）"
    # V31 布局元素抽取
    stand_d5 = find_frame(old, 1, 'PlaceObject2Tag', 5)[0]
    stand_d6 = find_frame(old, 1, 'PlaceObject2Tag', 6)[0]
    eff1 = find_frame(old, 2, 'PlaceObject2Tag', 10)[0] if lv == 1 else None
    eff2 = find_frame(old, 5, 'PlaceObject2Tag', 10)[0] if lv == 1 else None
    eff3 = find_frame(old, 8, 'PlaceObject2Tag', 10)[0] if lv == 1 else None
    eff4 = find_frame(old, 11, 'PlaceObject2Tag', 10)[0] if lv == 1 else None
    ro_d10_13 = find_frame(old, 13, 'RemoveObject2Tag', 10)[0] if lv == 1 else None
    launch_ros = find_frame(old, 14, 'RemoveObject2Tag', 5) + find_frame(old, 14, 'RemoveObject2Tag', 6)
    flame1_d3 = find_frame(old, 14, 'PlaceObject2Tag', 3)[0]
    flame1_d4 = find_frame(old, 14, 'PlaceObject2Tag', 4)[0]
    snd = find_frame(old, 14, 'StartSoundTag')[0]
    flame2_ros = find_frame(old, 16, 'RemoveObject2Tag', 3) + find_frame(old, 16, 'RemoveObject2Tag', 4)
    flame2_d3 = find_frame(old, 16, 'PlaceObject2Tag', 3)[0]
    flame2_d4 = find_frame(old, 16, 'PlaceObject2Tag', 4)[0]
    flame3_ros = find_frame(old, 18, 'RemoveObject2Tag', 3) + find_frame(old, 18, 'RemoveObject2Tag', 4)
    flame3_d3 = find_frame(old, 18, 'PlaceObject2Tag', 3)[0]
    flame3_d4 = find_frame(old, 18, 'PlaceObject2Tag', 4)[0]
    flame_ros20 = find_frame(old, 20, 'RemoveObject2Tag', 3) + find_frame(old, 20, 'RemoveObject2Tag', 4)
    hid_d5 = find_frame(old, 164, 'PlaceObject2Tag', 5)[0]
    hid_d6 = find_frame(old, 164, 'PlaceObject2Tag', 6)[0]
    mv_frames_old = [172, 180, 188, 196, 204, 212]
    moves_old = []
    for mf in mv_frames_old:
        moves_old.append(find_frame(old, mf, 'PlaceObject2Tag', 5)[0])
        moves_old.append(find_frame(old, mf, 'PlaceObject2Tag', 6)[0])
    # 新 176 帧时间轴发射
    nb = [[] for _ in range(NF)]
    nb[0] = [copy.deepcopy(it) for it in old[0]]
    if lv == 1:
        nb[1] = [copy.deepcopy(eff1)]
        nb[7] = [copy.deepcopy(find_frame(old, 5, 'RemoveObject2Tag', 10)[0]), copy.deepcopy(eff2)]
        nb[13] = [copy.deepcopy(find_frame(old, 8, 'RemoveObject2Tag', 10)[0]), copy.deepcopy(eff3)]
        nb[19] = [copy.deepcopy(find_frame(old, 11, 'RemoveObject2Tag', 10)[0]), copy.deepcopy(eff4)]
    launch_tags = [copy.deepcopy(it) for it in launch_ros]
    if lv == 1:
        launch_tags.insert(0, copy.deepcopy(ro_d10_13))
    launch_tags += [copy.deepcopy(flame1_d3), copy.deepcopy(flame1_d4), copy.deepcopy(snd)]
    nb[26] = launch_tags
    nb[28] = [copy.deepcopy(it) for it in flame2_ros] + [copy.deepcopy(flame2_d3), copy.deepcopy(flame2_d4)]
    nb[30] = [copy.deepcopy(it) for it in flame3_ros] + [copy.deepcopy(flame3_d3), copy.deepcopy(flame3_d4)]
    nb[32] = [copy.deepcopy(it) for it in flame_ros20]
    nb[117] = [copy.deepcopy(hid_d5), copy.deepcopy(hid_d6)]
    mv_new = [(126, 920), (134, 940), (142, 960), (150, 980), (158, 1000), (166, 1037)]
    for k, (mf, vx) in enumerate(mv_new):
        src5, src6 = moves_old[k*2], moves_old[k*2+1]
        t5 = copy.deepcopy(src5); t6 = copy.deepcopy(src6)
        m5 = t5.find('matrix'); m6 = t6.find('matrix')
        if vx == 1037:                 # 最后一步=最终位
            m5.set('translateX', '1037'); m6.set('translateX', '1037')
        nb[mf-1] = [t5, t6]
    sp.set('frameCount', str(NF))
    rebuild = ET.Element('subTags')
    for fr in range(NF):
        for it in nb[fr]:
            rebuild.append(it)
        rebuild.append(ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'}))
    old_sub = sp.find('subTags')
    for it in list(old_sub):
        old_sub.remove(it)
    for it in list(rebuild):
        old_sub.append(it)

for sid, lv in (('121', 1), ('115', 2)):
    build_new(sprite(sid), lv)
    print(f"sprite{sid}: V34 时间轴构建完成（176 帧）")

# 写出前断言：深度状态机 + 特效链帧序 + 音效 + 锚点
for sid, lv in (('121', 1), ('115', 2)):
    sp0 = sprite(sid)
    assert sp0.get('frameCount') == str(NF)
    occupied = set(); fr = 1; snd_f = None; d10_seq = []; anchor_n = 0
    for it in sp0.find('subTags'):
        t = it.get('type') or ''
        if t == 'ShowFrameTag':
            fr += 1
            continue
        if t == 'PlaceObject2Tag':
            d = it.get('depth')
            if it.get('placeFlagMove') == 'true':
                assert d in occupied, f"sprite{sid} f{fr} MOVE 空深度"
            else:
                assert d not in occupied, f"sprite{sid} f{fr} 替换型放置残留 d{d}"
                occupied.add(d)
                if (it.get('name') or '') in ('basePoint', 'shootPoint'):
                    anchor_n += 1
                if sid == '121' and d == '10':
                    d10_seq.append((fr, it.get('characterId')))
        elif t == 'RemoveObject2Tag':
            d = it.get('depth')
            assert d in occupied, f"sprite{sid} f{fr} 移除空深度 d{d}"
            occupied.discard(d)
        elif t == 'StartSoundTag':
            snd_f = fr
    assert fr - 1 == NF, f"sprite{sid} 帧数 {fr-1}"
    assert snd_f == 27, f"sprite{sid} 开火音在 f{snd_f}"
    assert anchor_n == 2, f"sprite{sid} 锚点 {anchor_n}"
    if lv == 1:
        assert d10_seq == [(2, '2907'), (8, '2909'), (14, '2911'), (20, '2913')], d10_seq
    else:
        assert d10_seq == [], d10_seq
print("写出前断言 PASS：176 帧/零替换/特效链 6tick 帧序(f2/8/14/20)/音效 f27/锚点×2")

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
