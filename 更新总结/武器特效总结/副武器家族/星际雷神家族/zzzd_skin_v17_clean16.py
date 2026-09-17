# -*- coding: utf-8 -*-
# 星际雷神 V17（2026-09-17）：修复 V13 起时间轴双帧边界 bug（28 个 ShowFrame/frameCount=16——
# 每帧实际停留约 2 tick，装填滑动等后半段从未播放），干净重建 16 帧＝严格 16 个帧边界；
# 特效链 d10 为最高深度（顶层，断言确认）；全动画按设计速度完整播放。
# 帧结构：f1 待机(弧/弹/体/锚)｜f2 发射(音+撤弹+焰1+特效1,attackDelay=0 真子弹同帧)｜f3 焰2/特效2｜f4 焰3/特效3
#   ｜f5 特效4+焰清除｜f6 lv2特效5｜f7~f8 弧暴露(装填等待)｜f9~f11 装填滑动(-60/-20/0tw)｜f12~f16 待机
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
CUR_XML  = "work"+BS+"sub1130-v16.xml"
OUT_XML  = "work"+BS+"sub1130-v17.xml"
OUT_SWF  = "work"+BS+"sub1130-v17.swf"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
BODY = {'115': '2935', '121': '2901'}
FX = {'115': ('2915', '2917', '2919', '2921', '2923'),
      '121': ('2907', '2909', '2911', '2913', '0000')}  # lv1 第五位占位（lv1 仅 4 帧特效）

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("18A02272"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, CUR_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(CUR_XML); root = tree.getroot()
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
         'forceWriteAsLong': 'false', 'placeFlagHasCharacter': 'true', 'placeFlagHasClipActions': 'false',
         'placeFlagHasClipDepth': 'false', 'placeFlagHasColorTransform': 'false', 'placeFlagHasMatrix': 'true',
         'placeFlagHasName': 'true' if name else 'false',
         'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'}
    if name: a['name'] = name
    el = ET.Element('item', a)
    el.append(matrix_el(tx, ty, sc))
    return el

def ro(depth):
    return ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': str(depth), 'forceWriteAsLong': 'false'})

def snd():
    return ET.Element('item', {'type': 'StartSoundTag', 'forceWriteAsLong': 'false'})

for sid in ('115', '121'):
    fx1, fx2, fx3, fx4, fx5 = FX[sid]
    body = BODY[sid]
    sp = sprites[sid]; sub = sp.find('subTags')
    # —— 采集 V16 现状矩阵 ——
    arcU = arcL = missU = missL = bodyM = bpM = spM = None
    fxv = {}; flU = {}; flL = {}
    for it in list(sub):
        if (it.get('type') or '') != 'PlaceObject2Tag': continue
        cid = it.get('characterId'); d = int(it.get('depth'))
        m = it.find('matrix')
        v = (int(cid), int(m.get('translateX')), int(m.get('translateY')), float(m.get('scaleX') or 1))
        if cid == '2931': arcU = v
        elif cid == '2933': arcL = v
        elif cid == '2905' and d == 5: missU = v
        elif cid == '2905' and d == 6: missL = v
        elif cid == body: bodyM = v
        elif it.get('name') == 'basePoint': bpM = v
        elif it.get('name') == 'shootPoint': spM = v
        elif cid == fx1: fxv[1] = v
        elif cid == fx2: fxv[2] = v
        elif cid == fx3: fxv[3] = v
        elif cid == fx4: fxv[4] = v
        elif sid == '115' and cid == fx5: fxv[5] = v
        elif cid in ('2925', '2927', '2929'):
            if d == 3: flU[cid] = v
            elif d == 4: flL[cid] = v
    missing = [k for k, v in dict(arcU=arcU, arcL=arcL, missU=missU, missL=missL,
                                  bodyM=bodyM, bpM=bpM, spM=spM).items() if v is None]
    assert not missing, f"{sid} 采集缺失: {missing}"
    for i in (1, 2, 3, 4, 5):
        if sid == '115' or i <= 4:
            assert i in fxv, f"{sid} 特效{i} 采集缺失"
    for c in ('2925', '2927', '2929'):
        assert c in flU and c in flL, f"{sid} 焰 {c} 采集缺失"
    print(f"sprite {sid}: 采集完成")

    # —— 工厂 ——
    def idle_tags():
        return [po2('2931', 1, arcU[1], arcU[2], arcU[3]),
                po2('2933', 2, arcL[1], arcL[2], arcL[3]),
                po2('2905', 5, missU[1], missU[2], missU[3]),
                po2('2905', 6, missL[1], missL[2], missL[3]),
                po2(body, 7, bodyM[1], bodyM[2], bodyM[3]),
                po2(104, 8, bpM[1], bpM[2], bpM[3], name='basePoint'),
                po2(104, 9, spM[1], spM[2], spM[3], name='shootPoint')]

    # —— 重建 subTags（严格 16 帧）——
    head = None
    for e in list(sub):
        if (e.get('type') or '').startswith('SoundStreamHead'):
            head = e; break
    assert head is not None, f"{sid} SoundStreamHead 未找到"
    for e in list(sub): sub.remove(e)
    sub.append(head)
    def emit(els):
        for el in els: sub.append(el)
        sub.append(ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'}))
    emit(idle_tags())                                                                                    # f1
    emit([snd(), ro(5), ro(6),
          po2('2925', 3, flU['2925'][1], flU['2925'][2], flU['2925'][3]),
          po2('2925', 4, flL['2925'][1], flL['2925'][2], flL['2925'][3]),
          po2(fx1, 10, fxv[1][1], fxv[1][2], fxv[1][3])])                                               # f2 发射
    emit([po2('2927', 3, flU['2927'][1], flU['2927'][2], flU['2927'][3]),
          po2('2927', 4, flL['2927'][1], flL['2927'][2], flL['2927'][3]),
          po2(fx2, 10, fxv[2][1], fxv[2][2], fxv[2][3])])                                               # f3
    emit([po2('2929', 3, flU['2929'][1], flU['2929'][2], flU['2929'][3]),
          po2('2929', 4, flL['2929'][1], flL['2929'][2], flL['2929'][3]),
          po2(fx3, 10, fxv[3][1], fxv[3][2], fxv[3][3])])                                               # f4
    emit([ro(3), ro(4), po2(fx4, 10, fxv[4][1], fxv[4][2], fxv[4][3])])                                 # f5 特效4+焰清除
    if sid == '115':
        emit([po2(fx5, 10, fxv[5][1], fxv[5][2], fxv[5][3])])                                           # f6 lv2 特效5
    else:
        emit([])                                                                                        # f5 后 lv1 无第五帧特效
    emit([])                                                                                            # f7 暴露
    emit([])                                                                                            # f8 暴露
    emit([po2('2905', 5, missU[1] - 60, missU[2], missU[3]),
          po2('2905', 6, missL[1] - 60, missL[2], missL[3])])                                           # f9 滑动1
    emit([po2('2905', 5, missU[1] - 20, missU[2], missU[3]),
          po2('2905', 6, missL[1] - 20, missL[2], missL[3])])                                           # f10 滑动2
    emit([po2('2905', 5, missU[1], missU[2], missU[3]),
          po2('2905', 6, missL[1], missL[2], missL[3])])                                                # f11 到位
    for _ in range(5): emit(idle_tags())                                                                # f12~f16 待机
    sp.set('frameCount', '16')

    # —— 断言 ——
    n_sf = sum(1 for it in sub if (it.get('type') or '') == 'ShowFrameTag')
    assert n_sf == 16, f"{sid} ShowFrame {n_sf} != 16"
    fm = {}; fr = 1; cur = []
    for it in list(sub):
        cur.append(it)
        if (it.get('type') or '') == 'ShowFrameTag': fm[fr] = list(cur); fr += 1; cur = []
    assert fr - 1 == 16
    fx_set = (fx1, fx2, fx3, fx4) if sid == '121' else (fx1, fx2, fx3, fx4, fx5)
    fx_frames = sorted(f for f in range(1, 17) for it in fm[f] if it.get('characterId') in fx_set)
    fx_depths = sorted(set(it.get('depth') for it in fm[2] + fm[3] + fm[4] + fm[5] + fm[6] if it.get('characterId') in fx_set))
    assert fx_depths == ['10'], f"{sid} 特效深度 {fx_depths} != ['10']（非顶层）"
    exp_frames = [2, 3, 4, 5] if sid == '121' else [2, 3, 4, 5, 6]
    assert fx_frames == exp_frames, f"{sid} 特效帧 {fx_frames} != {exp_frames}"
    f2t = fm[2]
    assert any((it.get('type') or '') == 'StartSoundTag' for it in f2t)
    assert any((it.get('type') or '') == 'RemoveObject2Tag' and it.get('depth') in ('5', '6') for it in f2t)
    assert any(it.get('characterId') == '2925' and it.get('depth') == '3' for it in f2t)
    assert not any(it.get('characterId') == '2905' and it.get('depth') in ('5', '6') for it in f2t)
    slide_ok = all(any(it.get('characterId') == '2905' and it.get('depth') in ('5', '6') for it in fm[f]) for f in (9, 10, 11))
    assert slide_ok, "装填滑动缺失"
    idle_ok = all(any(it.get('characterId') == '2905' and it.get('depth') in ('5', '6') for it in fm[f]) for f in (1, 12, 13, 14, 15, 16))
    assert idle_ok, "待机弹缺失"
    print(f"sprite {sid}: 16 帧严格重建（ShowFrame=16）＋特效 d10 顶层＋完整序列＋装填滑动 f9~f11 — 断言 PASS")
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
