# -*- coding: utf-8 -*-
# 星际雷神 V20（2026-09-17）：A+C 展示节奏重组＋残段清除（两级）
# 帧布局（16 帧，严格 16 ShowFrame）：
#   f1 待机｜f2 发射(音+撤弹+焰1+新1)｜f3 保持｜f4 焰2/新2｜f5 保持｜f6 焰3/新3(峰值)｜f7 峰值保持
#   ｜f8 焰清除｜f9 新4｜f10 保持｜f11 新5(残段,仅lv2)｜f12 残段清除(RO d10)+装填滑动1｜f13 滑动2｜f14 滑动3到位
#   ｜f15~f16 待机
# 层序维持：d1/d2 弧→d3/d4 焰→d5/d6 弹→d7 本体→d8/d9 锚→d10 特效(顶)
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = r".."+BS+"swf"+BS+"sub1130.swf"
CUR_XML  = "work"+BS+"sub1130-v19.xml"
OUT_XML  = "work"+BS+"sub1130-v20.xml"
OUT_SWF  = "work"+BS+"sub1130-v20.swf"
FFDEC    = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
BODY = {'115': '2935', '121': '2901'}
FXSET = {'115': ('2915', '2917', '2919', '2921', '2923'), '121': ('2907', '2909', '2911', '2913', None)}

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("8B86661C"), actual[:8]
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
    fx1, fx2, fx3, fx4, fx5 = FXSET[sid]
    body = BODY[sid]
    sp = sprites[sid]; sub = sp.find('subTags')
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
        elif fx5 and cid == fx5: fxv[5] = v
        elif cid in ('2925', '2927', '2929'):
            (flU if d == 3 else flL)[cid] = v
    missing = [k for k, v in dict(arcU=arcU, arcL=arcL, missU=missU, missL=missL,
                                  bodyM=bodyM, bpM=bpM, spM=spM).items() if v is None]
    assert not missing, f"{sid} 采集缺失 {missing}"
    for i in ((1, 2, 3, 4, 5) if sid == '115' else (1, 2, 3, 4)):
        assert i in fxv, f"{sid} 特效{i} 缺"
    for c in ('2925', '2927', '2929'):
        assert c in flU and c in flL, f"{sid} 焰{c} 缺"

    def idle_tags():
        return [po2('2931', 1, arcU[1], arcU[2], arcU[3]),
                po2('2933', 2, arcL[1], arcL[2], arcL[3]),
                po2('2905', 5, missU[1], missU[2], missU[3]),
                po2('2905', 6, missL[1], missL[2], missL[3]),
                po2(body, 7, bodyM[1], bodyM[2], bodyM[3]),
                po2(104, 8, bpM[1], bpM[2], bpM[3], name='basePoint'),
                po2(104, 9, spM[1], spM[2], spM[3], name='shootPoint')]

    head = [e for e in list(sub) if (e.get('type') or '').startswith('SoundStreamHead')]
    assert len(head) == 1
    for e in list(sub):
        if e not in head: sub.remove(e)
    for e in head: sub.append(e)
    def emit(els):
        for el in els: sub.append(el)
        sub.append(ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'}))
    emit(idle_tags())                                                                                                  # f1
    emit([snd(), ro(5), ro(6),
          po2('2925', 3, flU['2925'][1], flU['2925'][2], flU['2925'][3]),
          po2('2925', 4, flL['2925'][1], flL['2925'][2], flL['2925'][3]),
          po2(fx1, 10, fxv[1][1], fxv[1][2], fxv[1][3])])                                                              # f2
    emit([])                                                                                                           # f3
    emit([po2('2927', 3, flU['2927'][1], flU['2927'][2], flU['2927'][3]),
          po2('2927', 4, flL['2927'][1], flL['2927'][2], flL['2927'][3]),
          po2(fx2, 10, fxv[2][1], fxv[2][2], fxv[2][3])])                                                              # f4
    emit([])                                                                                                           # f5
    emit([po2('2929', 3, flU['2929'][1], flU['2929'][2], flU['2929'][3]),
          po2('2929', 4, flL['2929'][1], flL['2929'][2], flL['2929'][3]),
          po2(fx3, 10, fxv[3][1], fxv[3][2], fxv[3][3])])                                                              # f6
    emit([])                                                                                                           # f7
    emit([ro(3), ro(4)])                                                                                               # f8
    emit([po2(fx4, 10, fxv[4][1], fxv[4][2], fxv[4][3])])                                                              # f9
    emit([])                                                                                                           # f10
    if sid == '115':
        emit([po2(fx5, 10, fxv[5][1], fxv[5][2], fxv[5][3])])                                                          # f11 新5 残段
    else:
        emit([])                                                                                                       # f11
    emit([ro(10),
          po2('2905', 5, missU[1] - 60, missU[2], missU[3]),
          po2('2905', 6, missL[1] - 60, missL[2], missL[3])])                                                          # f12
    emit([po2('2905', 5, missU[1] - 20, missU[2], missU[3]),
          po2('2905', 6, missL[1] - 20, missL[2], missL[3])])                                                          # f13
    emit([po2('2905', 5, missU[1], missU[2], missU[3]),
          po2('2905', 6, missL[1], missL[2], missL[3])])                                                               # f14
    emit(idle_tags()); emit(idle_tags())                                                                               # f15 f16
    sp.set('frameCount', '16')

    n_sf = sum(1 for it in sub if (it.get('type') or '') == 'ShowFrameTag')
    assert n_sf == 16, f"{sid} ShowFrame {n_sf} != 16"
    fm = {}; fr = 1; cur = []
    for it in list(sub):
        cur.append(it)
        if (it.get('type') or '') == 'ShowFrameTag': fm[fr] = list(cur); fr += 1; cur = []
    assert fr - 1 == 16
    def cids(f, d):
        return [it.get('characterId') for it in fm[f] if it.get('depth') == str(d) and it.get('characterId')]
    assert cids(2, 10) == [fx1] and cids(3, 10) == [] and cids(4, 10) == [fx2] and cids(5, 10) == []
    assert cids(6, 10) == [fx3] and cids(7, 10) == [] and cids(8, 10) == [] and cids(9, 10) == [fx4] and cids(10, 10) == []
    if sid == '115':
        assert cids(11, 10) == [fx5] and cids(12, 10) == [] and cids(13, 10) == [] and cids(14, 10) == []
    else:
        assert cids(11, 10) == [] and cids(12, 10) == []
    assert cids(2, 3) == ['2925'] and cids(3, 3) == []
    assert cids(4, 3) == ['2927'] and cids(5, 3) == []
    assert cids(6, 3) == ['2929'] and cids(7, 3) == []
    assert any((it.get('type') or '') == 'RemoveObject2Tag' and it.get('depth') == '3' for it in fm[8])
    assert any((it.get('type') or '') == 'RemoveObject2Tag' and it.get('depth') == '10' for it in fm[12])
    assert cids(2, 5) == [] and cids(12, 5) == ['2905'] and cids(13, 5) == ['2905'] and cids(14, 5) == ['2905']
    assert cids(1, 5) == ['2905'] and cids(15, 5) == ['2905'] and cids(16, 5) == ['2905']
    anch = sorted((it.get('name'), it.get('depth')) for it in sp.iter('item')
                  if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('name') in ('basePoint', 'shootPoint'))
    assert sorted(set(anch)) == [('basePoint', '8'), ('shootPoint', '9')], anch
    maxd = max(int(it.get('depth')) for f in range(1, 17) for it in fm[f] if (it.get('type') or '') == 'PlaceObject2Tag')
    assert maxd == 10, maxd
    print(f"sprite {sid}: 16 帧节奏重组断言 PASS（焰 f2~f7 三帧各2tick、新1~5 f2~f11、残段 f12 清、滑动 f12~f14、特效 d10 顶层）")
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
