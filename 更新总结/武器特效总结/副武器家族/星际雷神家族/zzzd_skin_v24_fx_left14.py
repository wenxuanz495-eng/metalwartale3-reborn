# -*- coding: utf-8 -*-
# 星际雷神 V24 修订（2026-09-18）：lv1（MK1）最顶层 d10 蓄力特效链整体左移 14px——
# 四槽（f2/f4/f6/f9 @d10，characterId 2907/2909/2911/2913）matrix translateX 10→-270（-280tw=-14px），
# translateY=219（V23 值）与 scaleX/scaleY=0.75 不变；lv2（sprite115）维持 V21 删除态；
# 其余全库零改动＝全元素级 diff 断言（仅 4 处 translateX 属性变化）＋产物 swf2xml 回读 FOUND。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v24-src.xml"
OUT_XML  = "work"+BS+"sub1130-v24.xml"
OUT_SWF  = "work"+BS+"sub1130-v24.swf"
RB_XML   = "work"+BS+"sub1130-v24-readback.xml"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
FX_IDS   = ('2907', '2909', '2911', '2913')          # f2/f4/f6/f9 对应特效1~4 形状 ID
OLD_TX, NEW_TX, TY, SCALE = '10', '-270', '219', '0.75'
FRAMES   = [2, 4, 6, 9]

def sprite(root, sid):
    return [it for it in root.iter('item')
            if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]

def subtags(sp):
    return sp.find('subTags')

def assert_state(root, tag, tx):
    # lv1 特效四槽：帧位、ID、矩阵、缩放
    got = {}
    fr = 1
    for it in subtags(sprite(root, '121')):
        t = it.get('type') or ''
        if t == 'ShowFrameTag':
            fr += 1
            continue
        if t == 'PlaceObject2Tag' and it.get('depth') == '10' and it.get('characterId') in FX_IDS:
            got.setdefault(fr, []).append(it)
    assert sorted(got) == FRAMES, tag + ": 特效帧 " + str(sorted(got))
    for f in FRAMES:
        items = got[f]
        assert len(items) == 1, tag + ": f" + str(f) + " 槽数 " + str(len(items))
        assert items[0].get('characterId') == FX_IDS[FRAMES.index(f)], tag + ": f" + str(f) + " ID"
        m = items[0].find('matrix')
        assert m.get('translateX') == tx, tag + ": f" + str(f) + " tx=" + str(m.get('translateX'))
        assert m.get('translateY') == TY, tag + ": f" + str(f) + " ty=" + str(m.get('translateY'))
        assert m.get('scaleX') == SCALE and m.get('scaleY') == SCALE, tag + ": f" + str(f) + " 缩放"
    # 121 内 d10 只有这 4 处；115（lv2）维持 V21 删除态；121 仍为严格 16 帧
    d10_121 = [it for it in subtags(sprite(root, '121'))
               if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '10']
    assert len(d10_121) == 4, tag + ": 121 d10 放置 " + str(len(d10_121))
    d10_115 = [it for it in subtags(sprite(root, '115'))
               if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '10']
    assert len(d10_115) == 0, tag + ": 115 应无 d10（V21 删除态）"
    frames = len([it for it in subtags(sprite(root, '121')) if (it.get('type') or '') == 'ShowFrameTag'])
    assert frames == 16, tag + ": 121 帧数 " + str(frames)

# 1) 底稿哈希断言：当前 swf == manifest == V23 哈希
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("7087E30B"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

# 2) swf2xml 底稿导出
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
assert_state(tree, "改前", OLD_TX)

# 3) 手术：仅四槽 translateX 左移 280tw
n = 0
for it in subtags(sprite(tree, '121')):
    if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('depth') == '10' and it.get('characterId') in FX_IDS:
        it.find('matrix').set('translateX', NEW_TX)
        n += 1
assert n == 4
assert_state(tree, "改后", NEW_TX)
print("lv1: 四槽特效 translateX 10→-270（左移 14px）完成")

# 4) 全元素级 diff：全库只允许这 4 处属性变化
# （容器元素 sprite121 的序列化含全部后代，必然随之差异——故按「容器/叶子」分层断言）
ftree = ET.parse(SRC_XML)  # 未改动的独立副本
a = [ET.tostring(it, encoding='unicode') for it in ftree.iter('item')]
b = [ET.tostring(it, encoding='unicode') for it in tree.iter('item')]
assert len(a) == len(b)
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 4, "叶子 diff 处数 " + str(len(leaf))
assert len(cont) == 1 and 'spriteId="121"' in a[cont[0]], "容器 diff 应恰为 sprite121 本身"
for i in leaf:
    assert 'translateX="10"' in a[i] and 'translateX="' + NEW_TX + '"' in b[i], "diff 内容异常 @" + str(i)
    assert 'depth="10"' in a[i], "叶子 diff 应为 d10 放置 @" + str(i)
print("全元素级 diff 断言 PASS：叶子仅 4 处 translateX 变化＋容器 sprite121 随之差异，其余零改动")

# 5) 写出与回读
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
assert new_hash != actual
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
assert_state(ET.parse(RB_XML), "回读", NEW_TX)
print("回读 FOUND：产物内四槽 translateX=-270/ty=219/0.75 全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
