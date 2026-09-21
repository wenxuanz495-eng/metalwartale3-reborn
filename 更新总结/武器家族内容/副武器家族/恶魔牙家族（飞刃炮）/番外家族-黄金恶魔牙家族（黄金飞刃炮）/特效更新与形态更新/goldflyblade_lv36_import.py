# -*- coding: utf-8 -*-
# 黄金恶魔牙家族 LV3~LV6 形态导入脚本·资产与时间轴（2026-09-16）
# 画师素材：相关素材\黄金恶魔爪拓展\ 3~6号形态 各两张（普通=待机体 / 发射微曝光=开火体）
# 结构：
#   8 张本体位图+形状（2756~2771）+ 挂点弹头位图/形状（2772/2773，裁自 396 金子弹弹头）+
#   4 条 11 帧时间轴精灵（2774~2777，模板=399 现行结构）+ SymbolClass 4 项
# 时间轴（每级同构，跟随本系 2.5 模板惯例）：
#   f1 待机=普通本体 d2 + 挂点弹头 d3（枪口顶弹）+ 锚点 104 d5/d7（沿用 399 值）
#   f2 开火=本体换微曝光 d2 + 移除挂点弹 d3 + 2647 枪口闪 d4 + StartSound 366
#   f3~f10 金链 2734~2755 d4（blend=5，X 按枪口差平移）+ 小白圈 2652~2677 d6（399 原样）
#   f11 清场
# 标签全部深拷贝自 399/391 现成标签（避免手搓缺属性）；铁律：底稿哈希断言、单棵 ElementTree、纯追加
import xml.etree.ElementTree as ET
import copy, glob, hashlib, subprocess, sys, zlib
import numpy as np
from PIL import Image
sys.stdout.reconfigure(encoding='utf-8')

TGT = r"..\swf\sub1130.swf"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
SRC = r"D:\superalloy\相关素材\黄金恶魔爪拓展"
FFDEC = r"..\tools\packaging\ffdec\ffdec-cli.exe"
IN_XML = "sub1130-cur.xml"
OUT_XML = "sub1130-lv36.xml"
OUT_SWF = "sub1130-lv36.swf"

FORMS = [
    (3, 'goldflyBlade_lv3', '3黄金地狱之触.png', '3黄金地狱之触(发射微曝光）.png'),
    (4, 'goldflyBlade_lv4', '4黄金深渊之刃.png', '4黄金深渊之刃(发射微曝光）png.png'),
    (5, 'goldflyBlade_lv5', '5黄金灭世之手.png', '5黄金灭世之手(发射微曝光）.png'),
    (6, 'goldflyBlade_lv6', '6黄金诸神之殁.png', '6黄金诸神之殁(发射微曝光）.png'),
]
CHAIN_IDS = [2734, 2737, 2740, 2743, 2746, 2749, 2752, 2755]
CHAIN_399 = [(1172,529),(1165,493),(1152,450),(1169,428),(1166,315),(1097,62),(1093,437),(972,402)]
BASE_MUZZLE = 92.5   # shape 398 最右不透明列
BASE_AXIS = 11.0     # shape 398 枪口行中心（10~12）

# ---------- 0. 底稿哈希断言 ----------
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper(), f"底稿 {actual} != manifest {manifest_line}"
print("底稿哈希断言 PASS:", actual[:8])

tree = ET.parse(IN_XML); root = tree.getroot()

# ---------- 1. ID 分配 ----------
DEF_ATTRS = ('characterID', 'shapeId', 'spriteId', 'soundId', 'fontId')
used = set()
for it in root.iter('item'):
    for k in DEF_ATTRS:
        v = it.get(k)
        if v and v.isdigit() and int(v) != 65535:
            used.add(int(v))
next_id = max(used) + 1
assert next_id == 2756, f"预期 2756 起，实际 {next_id}"
def take_id():
    global next_id
    while next_id in used:
        next_id += 1
    used.add(next_id)
    return next_id

def muzzle_metrics(png):
    a = np.array(Image.open(png).convert('RGBA'))
    al = a[..., 3]
    cols = np.where(al.max(axis=0) > 10)[0]
    right = int(cols.max())
    rows = np.where(al[:, right] > 10)[0]
    axis = float(rows.min() + rows.max()) / 2
    return {'w': a.shape[1], 'h': a.shape[0], 'muzzle': right, 'axis': axis}

# ---------- 2. 挂点弹素材（原版 lv1 组合体 365=363+364 枪口外露出段裁剪：15x11 橙色箭尖） ----------
a365img = np.array(Image.open('render/shapes365/365.png').convert('RGBA'))
head = Image.fromarray(a365img[4:15, 79:94])
head.save('bullet-mount.png')
print('挂点弹: 原版组合体露出段裁剪 ->', head.size)

# ---------- 3. 标签模板（深拷贝源） ----------
sprites_all = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
tpl399 = [t for t in sprites_all['399'].find('subTags')]
def find_tag(container, type_, **cond):
    for t in container:
        if (t.get('type') or '') == type_ and all(t.get(k) == v for k, v in cond.items()):
            return t
    raise KeyError((type_, cond))
TPL_SNDHEAD = copy.deepcopy(find_tag(tpl399, 'SoundStreamHead2Tag'))
TPL_SHOW = copy.deepcopy(find_tag(tpl399, 'ShowFrameTag'))
TPL_BODY = copy.deepcopy(find_tag(tpl399, 'PlaceObject2Tag', depth='2'))          # 398@d2
TPL_ANCHOR = copy.deepcopy(find_tag(tpl399, 'PlaceObject2Tag', name='basePoint')) # 104@d5 带名
TPL_FLASH = copy.deepcopy(find_tag(tpl399, 'PlaceObject2Tag', characterId='2647'))
TPL_SOUND = copy.deepcopy(find_tag(tpl399, 'StartSoundTag'))
TPL_REMOVE = copy.deepcopy(find_tag(tpl399, 'RemoveObject2Tag'))
tpl391 = [t for t in sprites_all['391'].find('subTags')]
TPL_CHAIN = copy.deepcopy(find_tag(tpl391, 'PlaceObject3Tag', characterId='2734'))  # blend=5 链放置
TPL_MOVE = copy.deepcopy(find_tag(tpl391, 'PlaceObject2Tag', characterId='2657'))   # 小白圈 move 放置

def set_matrix(tag, tx, ty):
    m = tag.find('matrix')
    m.set('translateX', str(int(tx))); m.set('translateY', str(int(ty)))
    m.set('nTranslateBits', '14')
    return tag

# ---------- 4. 位图/形状 工厂 ----------
def lossless2_hex(path):
    img = Image.open(path).convert('RGBA')
    w, h = img.size
    raw = bytearray()
    for r, g, b, a in img.getdata():
        raw += bytes((a, r * a // 255, g * a // 255, b * a // 255))
    return w, h, zlib.compress(bytes(raw), 9).hex()

donor = None
for it in root.iter('item'):
    if it.get('shapeId') == '30' and it.get('type') == 'DefineShapeTag':
        donor = it
assert donor is not None

def make_bitmap(cid, path):
    w, h, hx = lossless2_hex(path)
    return ET.Element('item', {'type': 'DefineBitsLossless2Tag', 'forceWriteAsLong': 'true',
                               'characterID': str(cid), 'bitmapFormat': '5',
                               'bitmapWidth': str(w), 'bitmapHeight': str(h), 'zlibBitmapData': hx}), w, h

def make_shape(sid, bid, w, h):
    el = copy.deepcopy(donor)
    el.set('shapeId', str(sid))
    W, H = w * 20, h * 20
    b = el.find('shapeBounds')
    for k, v in (('Xmin', 0), ('Ymin', 0), ('Xmax', W), ('Ymax', H), ('nbits', 14)):
        b.set(k, str(v))
    fills = [f for f in el.iter('item') if f.get('type') == 'FILLSTYLE']
    real = fills[1]
    real.set('bitmapId', str(bid))
    bm = real.find('bitmapMatrix')
    bm.set('translateX', '0'); bm.set('translateY', '0'); bm.set('nTranslateBits', '1')
    recs = el.find('.//shapeRecords')
    items = list(recs)
    sc = items[0]
    sc.set('moveBits', '14'); sc.set('moveDeltaX', str(W)); sc.set('moveDeltaY', str(H))
    e1, e2, e3, e4 = items[1:5]
    for e, attr, val, vert in ((e1, 'deltaX', -W, 'false'), (e2, 'deltaY', -H, 'true'),
                               (e3, 'deltaX', W, 'false'), (e4, 'deltaY', H, 'true')):
        e.set(attr, str(val)); e.set('numBits', '14'); e.set('vertLineFlag', vert)
    return el

# ---------- 5. 生成 位图/形状 ----------
new_elems = []
body_ids = {}
for lv, name, png_reg, png_lux in FORMS:
    for kind, png in (('reg', png_reg), ('lux', png_lux)):
        bid, sid = take_id(), take_id()
        bel, w, h = make_bitmap(bid, rf"{SRC}\{png}")
        sel = make_shape(sid, bid, w, h)
        new_elems += [bel, sel]
        body_ids[(lv, kind)] = (sid, muzzle_metrics(rf"{SRC}\{png}"))
        print(f"LV{lv} {kind}: bitmap={bid} shape={sid} ({w}x{h})")

bid, sid = take_id(), take_id()
bel, hw, hh = make_bitmap(bid, 'bullet-mount.png')
sel = make_shape(sid, bid, hw, hh)
new_elems += [bel, sel]
head_shape = sid
print('挂点弹头: bitmap=%d shape=%d (%dx%d)' % (bid, sid, hw, hh))

# ---------- 6. 四条时间轴（以本系同级结构为基准，按枪口/枪轴差重锚） ----------
SPRITE_IDS = {lv: take_id() for lv, _, _, _ in FORMS}
print('时间轴精灵:', SPRITE_IDS)

def shape_metrics(shape_id):
    """形状渲染 PNG 的枪口/枪轴（画布归一化坐标）"""
    a = np.array(Image.open(f'render/shapes/{shape_id}.png').convert('RGBA'))
    al = a[..., 3]
    cols = np.where(al.max(axis=0) > 10)[0]
    right = int(cols.max())
    rows = np.where(al[:, right] > 10)[0]
    return {'w': a.shape[1], 'h': a.shape[0], 'muzzle': float(right), 'axis': float(rows.min() + rows.max()) / 2}

def read_level_structure(sid):
    """读取本系某级时间轴: 返回 {frame: [tag快照]}, 供镜像"""
    sp = sprites_all[str(sid)]
    frames = []
    cur = []
    for tag in sp.find('subTags'):
        t = tag.get('type') or ''
        if t == 'ShowFrameTag':
            frames.append(cur); cur = []
            continue
        cur.append(tag)
    if cur: frames.append(cur)
    return frames

REG_LEVEL_SPRITE = {3: '891', 4: '888', 5: '885', 6: '882'}
for lv, name, _, _ in FORMS:
    sid = SPRITE_IDS[lv]
    reg_id, reg_m = body_ids[(lv, 'reg')]
    lux_id, _ = body_ids[(lv, 'lux')]
    # 本系同级：本体形状、枪口/枪轴
    reg_frames = read_level_structure(REG_LEVEL_SPRITE[lv])
    reg_body_id = None
    for tag in reg_frames[0]:
        cid = tag.get('characterId')
        if cid and cid not in ('104',):
            defs = [x for x in root.iter('item') if (x.get('type') or '').startswith('DefineShape') and x.get('shapeId') == cid]
            if defs:
                reg_body_id = cid; break
    rmet = shape_metrics(reg_body_id)
    dx = int(round((reg_m['muzzle'] - rmet['muzzle']) * 20))
    dy = int(round((reg_m['axis'] - rmet['axis']) * 20))
    print(f"LV{lv}: 本系本体 {reg_body_id} (枪口{rmet['muzzle']}, 轴{rmet['axis']}) -> 金体 (枪口{reg_m['muzzle']}, 轴{reg_m['axis']}); Δ=({dx},{dy})tw")
    # 先镜像 f2~f11 的效果结构，收集占用深度
    CHAIN_MAP = {'2650': 2734, '2655': 2737, '2660': 2740, '2665': 2743,
                 '2670': 2746, '2675': 2749, '2680': 2752, '2683': 2755}
    mirror = []   # (kind, payload)
    used_depths = set()
    for fi in range(1, 10):
        for tag in reg_frames[fi]:
            t0 = tag.get('type') or ''
            cid = tag.get('characterId')
            d = tag.get('depth')
            if 'RemoveObject' in t0:
                mirror.append(('remove', d)); used_depths.add(d)
            elif 'PlaceObject' in t0 and cid in CHAIN_MAP:
                m = tag.find('matrix')
                mirror.append(('chain', cid, int(m.get('translateX')) + dx, int(m.get('translateY')) + dy,
                               tag.get('depth'), tag.get('blendMode')))
                used_depths.add(d)
            elif 'PlaceObject' in t0 and tag.get('placeFlagMove') == 'true':
                mirror.append(('move', cid, d)); used_depths.add(d)
            elif 'PlaceObject' in t0:
                m = tag.find('matrix')
                mirror.append(('place', cid, d,
                               (int(m.get('translateX')) + dx, int(m.get('translateY')) + dy) if m is not None else None,
                               tag.get('blendMode')))
                used_depths.add(d)
            elif 'StartSound' in t0:
                mirror.append(('sound',))
    # f11
    for tag in reg_frames[10]:
        if 'RemoveObject' in (tag.get('type') or ''):
            mirror.append(('remove', tag.get('depth'))); used_depths.add(tag.get('depth'))
    assert '1' not in used_depths and '2' not in used_depths, used_depths
    d_max = max(int(d) for d in used_depths)
    D_BULLET, D_BODY = 1, 2   # 弹在下(1)、枪在上(2)——原版组合层级
    D_BASE, D_SHOOT = d_max + 1, d_max + 2
    sub = ET.SubElement(ET.Element('item'), 'subTags')
    sub.append(copy.deepcopy(TPL_SNDHEAD))
    # f1: 待机本体 + 锚点(本系同级值+Δ) + 挂点弹
    t = copy.deepcopy(TPL_BODY); t.set('characterId', str(reg_id)); t.set('depth', str(D_BODY)); set_matrix(t, 0, 0); sub.append(t)
    reg_anchors = {}
    for tag in reg_frames[0]:
        n = tag.get('name')
        if n in ('basePoint', 'shootPoint'):
            m = tag.find('matrix')
            reg_anchors[n] = (int(m.get('translateX')) + dx, int(m.get('translateY')) + dy)
    for d, nm in ((D_BASE, 'basePoint'), (D_SHOOT, 'shootPoint')):
        tx, ty = reg_anchors[nm]
        t = copy.deepcopy(TPL_ANCHOR); t.set('depth', str(d)); t.set('name', nm); set_matrix(t, tx, ty); sub.append(t)
    t = copy.deepcopy(TPL_BODY); t.set('characterId', str(head_shape)); t.set('depth', str(D_BULLET))
    set_matrix(t, int(round((reg_m['muzzle'] - 6) * 20)), int(round((reg_m['axis'] - 2.0) * 20))); sub.append(t)
    sub.append(copy.deepcopy(TPL_SHOW))
    # f2: 微曝光换装（枪层同深度替换；挂点弹 d1 全程在场，不清除）+ 镜像枪口闪 + 音
    t = copy.deepcopy(TPL_BODY); t.set('characterId', str(lux_id)); t.set('depth', str(D_BODY)); set_matrix(t, 0, 0); sub.append(t)
    # 逐帧重建（f2 起，镜像本系同级：枪口闪/金链/小白圈/音，矩阵+Δ）
    for fi in range(1, 10):
        for tag_src in reg_frames[fi]:
            t0 = tag_src.get('type') or ''
            cid = tag_src.get('characterId')
            d = tag_src.get('depth')
            if 'RemoveObject' in t0:
                t = copy.deepcopy(TPL_REMOVE); t.set('depth', d); sub.append(t)
            elif 'PlaceObject' in t0 and cid in CHAIN_MAP:
                m = tag_src.find('matrix')
                t = copy.deepcopy(TPL_CHAIN); t.set('characterId', str(CHAIN_MAP[cid]))
                set_matrix(t, int(m.get('translateX')) + dx, int(m.get('translateY')) + dy)
                if tag_src.get('blendMode'): t.set('blendMode', tag_src.get('blendMode'))
                t.set('depth', d); sub.append(t)
            elif 'PlaceObject' in t0 and tag_src.get('placeFlagMove') == 'true':
                t = copy.deepcopy(TPL_MOVE); t.set('characterId', cid); t.set('depth', d); sub.append(t)
            elif 'PlaceObject' in t0:
                t = copy.deepcopy(TPL_FLASH); t.set('characterId', cid); t.set('depth', d)
                m = tag_src.find('matrix')
                if m is not None:
                    set_matrix(t, int(m.get('translateX')) + dx, int(m.get('translateY')) + dy)
                else:
                    t.remove(t.find('matrix')); t.set('placeFlagHasMatrix', 'false')
                sub.append(t)
            elif 'StartSound' in t0:
                sub.append(copy.deepcopy(TPL_SOUND))
        sub.append(copy.deepcopy(TPL_SHOW))
    # f11
    for tag in reg_frames[10]:
        if 'RemoveObject' in (tag.get('type') or ''):
            t = copy.deepcopy(TPL_REMOVE); t.set('depth', tag.get('depth')); sub.append(t)
    sub.append(copy.deepcopy(TPL_SHOW))
    el = ET.Element('item', {k: v for k, v in sprites_all['399'].attrib.items() if k not in ('spriteId', 'frameCount')})
    el.set('spriteId', str(sid)); el.set('frameCount', '11')
    el.append(sub)
    nshow = len([t for t in sub if (t.get('type') or '') == 'ShowFrameTag'])
    assert nshow == 11, nshow
    new_elems.append(el)
    print('LV%d 时间轴 %d 完成' % (lv, sid))

# 插入定义（391 之前）
parent_map = {c: p for p in root.iter() for c in p}
anchor = sprites_all['391']
ap = parent_map[anchor]
ins = list(ap).index(anchor)
for k, el in enumerate(new_elems):
    ap.insert(ins + k, el)
print('已插入定义', len(new_elems), '项')

# ---------- 7. SymbolClass ----------
sc = next(it for it in root.iter('item') if (it.get('type') or '') == 'SymbolClassTag')
tags_el = sc.find('tags'); names_el = sc.find('names')
n_before = len(tags_el)
assert len(names_el) == n_before
for lv, name, _, _ in FORMS:
    ET.SubElement(tags_el, 'item').text = str(SPRITE_IDS[lv])
    ET.SubElement(names_el, 'item').text = name
print('SymbolClass:', n_before, '->', len(tags_el))

# ---------- 8. 写出 ----------
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
