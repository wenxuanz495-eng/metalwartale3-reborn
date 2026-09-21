# -*- coding: utf-8 -*-
# 守望者家族 LV4/LV5 三帧碎屑导入脚本（2026-09-15）
# 用户定案：特效1/2/3 = 三个动画帧，对位 f3/f4/f5（发光窗口正好 3 帧，与 LV1~3 一致），
#           一帧不多一帧不少，不做第二脉冲；颜色原样入库不做任何色彩处理。
# 结构：照 donor 形状 30（位图 1:1 矩形包裹，fillStyleType=67 非平滑位图填充）克隆；
#       每级 3 位图+3 形状+3 单帧精灵；火焰 depth2→4（LV1~3 排布）；f6 RemoveObject2 清场。
# 铁律：底稿新鲜转储并断言 manifest 哈希；全程单棵 ElementTree。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys, zlib, struct
from PIL import Image
sys.stdout.reconfigure(encoding='utf-8')

TGT_SWF = "fresh_cur.swf"          # 当前底稿（2F422962，恢复态）
OUT_XML = "sub1130-debris3.xml"
OUT_SWF = "sub1130-debris3.swf"
FFDEC = r"..\tools\packaging\ffdec\ffdec-cli.exe"
SRC_DIR = r"D:\superalloy\相关素材\守望者"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"

# (级别, 本体精灵, 交付图前缀, 碎屑放置 translateX/Y twips)
LEVELS = [
    ('LV4', '1307', '4阶特效', (0, 239)),
    ('LV5', '1304', '5阶特效', (-14, 274)),
]
FLAME_IDS = {'948', '950', '952', '557', '562', '953', '954'}
FRAME_MAP = {3: 0, 4: 1, 5: 2}     # 帧号 -> 特效N-1

# ---------- 0. 底稿哈希断言 ----------
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper(), f"底稿 {actual} != manifest {manifest_line}"
print("底稿哈希断言 PASS:", actual[:8])

tree = ET.parse('fresh_cur.xml'); root = tree.getroot()
parent = {c: p for p in root.iter() for c in p}

# ---------- 1. ID 分配（含 soundId/fontId 查重） ----------
DEF_ATTRS = ('characterID', 'shapeId', 'spriteId', 'soundId', 'fontId')
used = set()
for it in root.iter('item'):
    for k in DEF_ATTRS:
        v = it.get(k)
        if v and v.isdigit() and int(v) != 65535:
            used.add(int(v))
next_id = max(used) + 1
print("当前最大角色 ID:", max(used), " 新 ID 从", next_id, "起")

def take_id():
    global next_id
    while next_id in used:
        next_id += 1
    used.add(next_id)
    return next_id

# ---------- 2. PNG -> DefineBitsLossless2 (format 5, BGRA) ----------
def lossless2_hex(path):
    img = Image.open(path).convert('RGBA')
    w, h = img.size
    raw = bytearray()
    for r, g, b, a in img.getdata():
        # Lossless2 format5 = 预乘 ARGB（字节序与预乘均经位图29/2714 实证）
        raw += bytes((a, r * a // 255, g * a // 255, b * a // 255))
    comp = zlib.compress(bytes(raw), 9)
    return w, h, comp.hex()

def make_bitmap_elem(cid, path):
    w, h, hexdata = lossless2_hex(path)
    el = ET.Element('item', {'type': 'DefineBitsLossless2Tag', 'forceWriteAsLong': 'true',
                             'characterID': str(cid), 'bitmapFormat': '5',
                             'bitmapWidth': str(w), 'bitmapHeight': str(h),
                             'zlibBitmapData': hexdata})
    return el, w, h

# ---------- 3. 克隆供体形状 30 -> 我的 1:1 矩形形状 ----------
donor = None
for it in root.iter('item'):
    if it.get('shapeId') == '30' and it.get('type') == 'DefineShapeTag':
        donor = it
        break
assert donor is not None

def make_shape_elem(sid, bid, w, h):
    el = copy.deepcopy(donor)
    el.set('shapeId', str(sid))
    W, H = w * 20, h * 20
    b = el.find('shapeBounds')
    for k, v in (('Xmin', 0), ('Ymin', 0), ('Xmax', W), ('Ymax', H), ('nbits', 13)):
        b.set(k, str(v))
    fills = [f for f in el.iter('item') if f.get('type') == 'FILLSTYLE']
    assert len(fills) == 2
    real = fills[1]                      # #1 是 bitmapId=65535 占位，#2 是真位图
    real.set('bitmapId', str(bid))
    bm = real.find('bitmapMatrix')
    bm.set('translateX', '0'); bm.set('translateY', '0')
    bm.set('nTranslateBits', '1')
    recs = el.find('.//shapeRecords')
    items = list(recs)
    sc = items[0]
    sc.set('moveBits', '13'); sc.set('moveDeltaX', str(W)); sc.set('moveDeltaY', str(H))
    e1, e2, e3, e4 = items[1:5]
    for e, attr, val, vert in ((e1, 'deltaX', -W, 'false'), (e2, 'deltaY', -H, 'true'),
                               (e3, 'deltaX', W, 'false'), (e4, 'deltaY', H, 'true')):
        e.set(attr, str(val))
        e.set('numBits', '13'); e.set('vertLineFlag', vert)
    return el

# ---------- 4. 单帧精灵（照 LV1 辉光精灵 1996 构造，去无关项） ----------
sprite1996 = None
for it in root.iter('item'):
    if it.get('spriteId') == '1996':
        sprite1996 = it
        break
SPRITE_ATTRS = {k: v for k, v in sprite1996.attrib.items() if k not in ('spriteId', 'frameCount')}

def make_sprite_elem(sid, shape_id):
    el = ET.Element('item', dict(SPRITE_ATTRS, spriteId=str(sid), frameCount='1'))
    sub = ET.SubElement(el, 'subTags')
    po = ET.SubElement(sub, 'item', {'type': 'PlaceObject2Tag', 'characterId': str(shape_id), 'depth': '1',
                                     'placeFlagHasCharacter': 'true', 'placeFlagHasClipActions': 'false',
                                     'placeFlagHasClipDepth': 'false', 'placeFlagHasColorTransform': 'false',
                                     'placeFlagHasMatrix': 'true', 'placeFlagHasName': 'false',
                                     'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'})
    ET.SubElement(po, 'matrix', {'type': 'MATRIX', 'hasRotate': 'false', 'hasScale': 'false',
                                 'nRotateBits': '0', 'nScaleBits': '0', 'nTranslateBits': '0',
                                 'translateX': '0', 'translateY': '0'})
    ET.SubElement(sub, 'item', {'type': 'ShowFrameTag'})
    return el

# ---------- 5. 生成 6 套（位图/形状/精灵） ----------
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
new_elems = []
plan = {}
for lv, sid, prefix, (tx, ty) in LEVELS:
    trio = []
    for i in (1, 2, 3):
        bmp_id, shp_id, spr_id = take_id(), take_id(), take_id()
        b_el, w, h = make_bitmap_elem(bmp_id, fr"{SRC_DIR}\{prefix}{i}.png")
        s_el = make_shape_elem(shp_id, bmp_id, w, h)
        p_el = make_sprite_elem(spr_id, shp_id)
        new_elems += [b_el, s_el, p_el]
        trio.append((spr_id, w, h))
        print(f"{lv} 特效{i}: bitmap={bmp_id}({w}x{h}) shape={shp_id} sprite={spr_id}")
    plan[lv] = (sid, trio, (tx, ty))

# 插入定义：位于 LV4/LV5 本体精灵定义之前（定义先于引用）
body_items = {sid: sprites[sid] for _, sid, _, _ in LEVELS}
anchor = min(body_items.values(), key=lambda e: list(root.iter()).index(e))
anchor_parent = parent[anchor]
ins = list(anchor_parent).index(anchor)
for i, el in enumerate(new_elems):
    anchor_parent.insert(ins + i, el)
print(f"已插入 {len(new_elems)} 项定义（锚点 sprite{anchor.get('spriteId')} 之前）")

# ---------- 6. 时间轴编辑 ----------
REMOVE_XML = '<item type="RemoveObject2Tag" depth="2" />'

def edit_body(sp, trio, pos):
    tx, ty = pos
    sub = sp.find('subTags')
    # 6.1 火焰 d2 -> d4（放置与既有的 f12 清除标签一并跟随）
    moved = fixed_remove = 0
    for tag in sub:
        t = tag.get('type') or ''
        if 'PlaceObject' in t and tag.get('depth') == '2' and tag.get('characterId') in FLAME_IDS:
            tag.set('depth', '4')
            moved += 1
        if 'RemoveObject' in t and tag.get('depth') == '2':
            tag.set('depth', '4')          # 原为清除 d2 火焰，随火焰迁至 d4
            fixed_remove += 1
    assert moved == 7, moved
    assert fixed_remove == 1, fixed_remove
    # 6.2 构造碎屑放置
    def put(cid, move):
        return ET.fromstring(
            f'<item type="PlaceObject2Tag" characterId="{cid}" depth="2" placeFlagHasCharacter="true" '
            f'placeFlagHasClipActions="false" placeFlagHasClipDepth="false" placeFlagHasColorTransform="false" '
            f'placeFlagHasMatrix="true" placeFlagHasName="false" placeFlagHasRatio="false" placeFlagMove="{move}">'
            f'<matrix type="MATRIX" hasRotate="false" hasScale="false" nRotateBits="0" nScaleBits="0" '
            f'nTranslateBits="10" translateX="{tx}" translateY="{ty}"/></item>')
    remove = ET.fromstring(REMOVE_XML)
    pending = {3: [put(trio[0][0], 'false')], 4: [put(trio[1][0], 'true')],
               5: [put(trio[2][0], 'true')], 6: [remove]}
    # 6.3 按帧拼接（插在各帧内容末尾、ShowFrameTag 之前）
    out = []
    frame = 1
    for tag in list(sub):
        if (tag.get('type') or '') == 'ShowFrameTag':
            out += pending.pop(frame, [])
            out.append(tag)
            frame += 1
        else:
            out.append(tag)
    assert not pending, pending.keys()
    sub[:] = out
    return moved

for lv, sid, prefix, pos in LEVELS:
    m = edit_body(sprites[sid], plan[lv][1], plan[lv][2])
    print(f"{lv} 本体 {sid}: 火焰 d2→d4 ×{m}，碎屑 f3/f4/f5 + f6 清场")

# ---------- 7. 写出 ----------
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
