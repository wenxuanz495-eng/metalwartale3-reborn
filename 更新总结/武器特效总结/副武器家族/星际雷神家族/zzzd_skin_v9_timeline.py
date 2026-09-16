# -*- coding: utf-8 -*-
# 星际雷神 V9 大修脚本（2026-09-17，两级通用；用户批准的四段式时间轴）
# 结构（frameCount 13→16，z 序自底向上）：
#   d1=上弧(2931,常驻) d2=下弧(2933,常驻) d3=上导弹(2905) d4=下导弹(2905) d5=本体 d6=basePoint d7=shootPoint
#   d8=特效链 d9/d10=尾焰 d11/d12=可见飞出导弹(2905)
#   f1~f3 带弹待机(弧被弹/体覆盖)｜f4 发射帧:撤待机弹+飞出导弹出现+尾焰1+特效1+音(无弧暴露)｜f5/f6 飞弹右移+尾焰/特效续
#   f7 飞弹撤=发射结束→弧自然露出｜f8 lv2特效5｜f9~f10 暴露态装填等待｜f11~f13 装填滑动(-3px→-1px→到位,弧被盖回)
#   f14~f16 带弹待机收尾循环
# 全部矩阵取自 V8 调优现状（状态跟踪含 MOVE 继承展开）；lv1 特效槽左移 3px（白球 25.8→红核 22.4 实测）；
# StartSound 保留在 f4；锚点矩阵原样（仅深度重排）。配置 bulletTranslation 另行修改（不在本脚本）。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

CUR_SWF  = r"..\swf\sub1130.swf"
CUR_XML  = "work/sub1130-v8.xml"
OUT_XML  = "work/sub1130-v9.xml"
OUT_SWF  = "work/sub1130-v9.swf"
FFDEC    = r"..\tools\packaging\ffdec\ffdec-cli.exe"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
FRAMES = 16

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("1D3FC4D3"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, CUR_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(CUR_XML); root = tree.getroot()

def state_walk(sp):
    fr = 1; state = {}; out = {}
    for it in sp.find('subTags'):
        t = it.get('type') or ''
        if t == 'PlaceObject2Tag':
            d = int(it.get('depth')); cid = it.get('characterId')
            if cid:
                m = it.find('matrix')
                if m is not None:
                    state[d] = (int(cid), int(m.get('translateX')), int(m.get('translateY')),
                                float(m.get('scaleX') or 1))
                elif d in state:
                    state[d] = (int(cid), state[d][1], state[d][2], state[d][3])
        elif t == 'RemoveObject2Tag':
            state.pop(int(it.get('depth')), None)
        elif t == 'ShowFrameTag':
            out[fr] = dict(state); fr += 1
    return out

sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}

def matrix_el(tx, ty, sc):
    a = {'type': 'MATRIX', 'hasRotate': 'false', 'nRotateBits': '0', 'nTranslateBits': '13',
         'translateX': str(tx), 'translateY': str(ty)}
    if abs(sc - 1) > 1e-3:
        a.update({'hasScale': 'true', 'scaleX': str(sc), 'scaleY': str(sc), 'nScaleBits': '16'})
    else:
        a.update({'hasScale': 'false', 'scaleX': '1', 'scaleY': '1', 'nScaleBits': '0'})
    return ET.Element('matrix', a)

def po2(cid, depth, tx, ty, sc=1.0, name=None):
    a = {'type': 'PlaceObject2Tag', 'characterId': str(cid), 'depth': str(depth),
         'forceWriteAsLong': 'false', 'placeFlagHasCharacter': 'true',
         'placeFlagHasClipActions': 'false', 'placeFlagHasClipDepth': 'false',
         'placeFlagHasColorTransform': 'false', 'placeFlagHasMatrix': 'true',
         'placeFlagHasName': 'true' if name else 'false',
         'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'}
    if name: a['name'] = name
    el = ET.Element('item', a)
    el.append(matrix_el(tx, ty, sc))
    return el
def ro(depth):
    return ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false'})
def sf():
    return ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'})
def snd():
    return ET.Element('item', {'type': 'StartSoundTag', 'forceWriteAsLong': 'false'})

for sid, body_shape, fx in (('115', '2935', (2915, 2917, 2919, 2921, 2923)),
                            ('121', '2901', (2907, 2909, 2911, 2913))):
    sp = sprites[sid]
    st = state_walk(sp)
    # —— 采集 V8 调优现状矩阵 ——
    arcU = st[4][9];  arcL = st[4][10]          # (cid,tx,ty,sc) @f4 尾焰帧的弧（现 d9/d10）
    misU = st[1][1];  misL = st[2][2]           # 待机导弹（现 d1/d2，含 V7/V8 分化微调）
    body = st[1][3]                             # 本体 @f1 现 d3
    bp   = st[1][4]                             # basePoint（现 d4）
    spt  = st[1][5]                             # shootPoint（现 d5）
    fx4 = st[4][6]                              # 特效1（现 d6，显式）
    f4v = st[4]; f5v = st[5]; f6v = st[6]
    flU4, flL4 = f4v[7], f4v[8]                 # 尾焰1（现 d7/d8）
    flU5, flL5 = f5v[7], f5v[8]                 # 尾焰2
    flU6, flL6 = f6v[7], f6v[8]                 # 尾焰3
    fx_last = st[8][6] if 8 in st and 6 in st[8] else fx4   # lv2 f8=新5
    print(f"sprite {sid}: 采集完成 弧U={arcU[1:]} 弹U={misU[1:]} 本体={body[1:]}")

    # —— lv1 特效槽左移 3px（-60tw）——
    SHIFT_FX = -60 if sid == '121' else 0

    # —— 重建 subTags ——
    sub = sp.find('subTags')
    heads = [e for e in list(sub) if (e.get('type') or '').startswith('SoundStreamHead')]
    for old in list(sub):
        if old not in heads:
            sub.remove(old)
    sp.set('frameCount', str(FRAMES))
    cur_frames = []
    def add(frame, els):
        cur_frames.append((frame, els))

    miu, miul = misU[1], misU[2]
    add(1, [po2(2931, 1, arcU[1], arcU[2], arcU[3]),
            po2(2933, 2, arcL[1], arcL[2], arcL[3]),
            po2(2905, 3, miu, miul, misU[3]),
            po2(2905, 4, misL[1], misL[2], misL[3]),
            po2(int(body_shape), 5, body[1], body[2], body[3]),
            po2(bp[0], 6, bp[1], bp[2], bp[3], name='basePoint'),
            po2(spt[0], 7, spt[1], spt[2], spt[3], name='shootPoint')])
    add(2, []); add(3, [])
    add(4, [snd(),
            ro(3), ro(4),
            po2(2905, 11, arcU[1], arcU[2], 0.75),
            po2(2905, 12, arcL[1], arcL[2], 0.75),
            po2(flU4[0], 9, flU4[1], flU4[2], flU4[3]),
            po2(flL4[0], 10, flL4[1], flL4[2], flL4[3]),
            po2(fx[0], 8, fx4[1] + SHIFT_FX, fx4[2], fx4[3])])
    add(5, [po2(2905, 11, arcU[1] + 500, arcU[2], 0.75),
            po2(2905, 12, arcL[1] + 500, arcL[2], 0.75),
            po2(flU5[0], 9, flU5[1], flU5[2], flU5[3]),
            po2(flL5[0], 10, flL5[1], flL5[2], flL5[3]),
            po2(fx[1], 8, fx4[1] + SHIFT_FX, fx4[2], fx4[3])])
    add(6, [po2(2905, 11, arcU[1] + 1100, arcU[2], 0.75),
            po2(2905, 12, arcL[1] + 1100, arcL[2], 0.75),
            po2(flU6[0], 9, flU6[1], flU6[2], flU6[3]),
            po2(flL6[0], 10, flL6[1], flL6[2], flL6[3]),
            po2(fx[2], 8, fx4[1] + SHIFT_FX, fx4[2], fx4[3])])
    add(7, [ro(11), ro(12),
            po2(fx[3], 8, fx4[1] + SHIFT_FX, fx4[2], fx4[3])])
    if sid == '115':
        add(8, [po2(fx[4], 8, fx_last[1], fx_last[2], fx_last[3])])
    else:
        add(8, [])
    add(9, []); add(10, [])
    add(11, [po2(2905, 3, miu - 60, miul, misU[3]),
             po2(2905, 4, misL[1] - 60, misL[2], misL[3])])
    add(12, [po2(2905, 3, miu - 20, miul, misU[3]),
             po2(2905, 4, misL[1] - 20, misL[2], misL[3])])
    add(13, [po2(2905, 3, miu, miul, misU[3]),
             po2(2905, 4, misL[1], misL[2], misL[3])])
    add(14, []); add(15, []); add(16, [])

    for fr2, els in cur_frames:
        for el in els:
            sub.append(el)
        sub.append(sf())
    print(f"sprite {sid}: 16 帧四段式重建完成（弧常驻 d1/d2、飞出导弹 d11/d12、装填滑动 f11~f13）")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
