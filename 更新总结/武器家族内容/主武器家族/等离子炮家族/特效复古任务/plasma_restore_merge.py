import copy
import re
import xml.etree.ElementTree as ET
from pathlib import Path

WORK = Path(r'D:\superalloy\tmp-soya-family-test\plasma-audit\work')
SRC = WORK / 'arms1100.GH.xml'          # 当前正式 arms1100.swf 的 FFDec XML 导出
DONOR = WORK / 'arms34.25.xml'          # 2.5 arms_34.swf 的 FFDec XML 导出
OUT = WORK / 'arms1100.merged.xml'

MAX_EXISTING_ID = 1738                  # 已确认当前最大 Character ID
NEW_BULLET = {1: 1739, 2: 1740, 3: 1741, 4: 1742, 5: 1743}   # 2.5 lv1~lv5 子弹 shape
NEW_FLASH = 1744                        # 2.5 lv5 枪口焰 shape 214
LV6_BULLET_SCALE = ('1.2', '1.1')       # LV6 = LV5 子弹拉长放大 (scaleX, scaleY)
DONOR_BULLET_SHAPE = {1: 209, 2: 206, 3: 203, 4: 200, 5: 197}
DONOR_FLASH_SHAPE = 214
SENTINELS = {0, 65535}

DEF_KEYS = ('characterID', 'shapeId', 'spriteId', 'soundId',
            'fontId', 'buttonId', 'morphShapeId', 'textId', 'bitmapId', 'jpegId')


def def_id(tag):
    for k in DEF_KEYS:
        if k in tag.attrib:
            return int(tag.get(k))
    return None


def find_def(tags, cid):
    for t in list(tags):
        if def_id(t) == cid:
            return t
    return None


def exports(tags):
    ex = {}
    for t in list(tags):
        if t.get('type') == 'SymbolClassTag':
            for idn, n in zip(t.find('tags').findall('item'),
                              t.find('names').findall('item')):
                ex[n.text] = int(idn.text)
    return ex


def bitmap_deps(shape_tag):
    ids = set()
    for n in shape_tag.iter():
        v = n.get('bitmapId')
        if v is not None:
            v = int(v)
            if v not in SENTINELS:
                ids.add(v)
    return ids


src_tree = ET.parse(SRC)
src_tags = src_tree.getroot().find('tags')
donor_tree = ET.parse(DONOR)
donor_tags = donor_tree.getroot().find('tags')
src_ex = exports(src_tags)
donor_ex = exports(donor_tags)

next_id = MAX_EXISTING_ID + 1
report = []

# ---------- 1. 导入 2.5 子弹 shape（含位图依赖重映射） ----------
def import_shape(donor_id, note):
    global next_id
    d = find_def(donor_tags, donor_id)
    assert d is not None, f'donor {donor_id} missing'
    assert d.get('type') == 'DefineShapeTag', f'donor {donor_id} is {d.get("type")}'
    c = copy.deepcopy(d)
    c.set('shapeId', str(next_id))
    for bm in sorted(bitmap_deps(d)):
        bt = find_def(donor_tags, bm)
        assert bt is not None, f'donor bitmap {bm} missing'
        bc = copy.deepcopy(bt)
        new_bm = next_id + 1
        bc.set('characterID', str(new_bm))
        for n in c.iter():
            if n.get('bitmapId') == str(bm):
                n.set('bitmapId', str(new_bm))
        src_tags.append(bc)
        report.append(f'bitmap {bm} ({bt.get("type")}) -> {new_bm}')
        next_id += 1
    src_tags.append(c)
    report.append(f'shape {donor_id} -> {c.get("shapeId")} ({note})')
    next_id += 1
    return int(c.get('shapeId'))


new_bullet_shape = {}
for lvl in range(1, 6):
    new_bullet_shape[lvl] = import_shape(DONOR_BULLET_SHAPE[lvl], f'plasma lv{lvl} bullet (2.5)')
new_flash_id = import_shape(DONOR_FLASH_SHAPE, 'plasma lv5 muzzle flash (2.5)')

# ---------- 2. 改写六个子弹 Sprite ----------
def place_of(sprite_tag):
    for ch in sprite_tag.find('subTags'):
        if ch.get('type', '').startswith('PlaceObject'):
            return ch
    return None


def set_natural_matrix(pl):
    m = pl.find('matrix')
    m.set('hasScale', 'false')
    m.set('nScaleBits', '0')
    m.attrib.pop('scaleX', None)
    m.attrib.pop('scaleY', None)


def set_scale_matrix(pl, sx, sy):
    m = pl.find('matrix')
    m.set('hasScale', 'true')
    m.set('nScaleBits', '18')
    m.set('scaleX', sx)
    m.set('scaleY', sy)


for lvl in range(1, 6):
    root = src_ex[f'plasma_lv{lvl}_bullet']
    sp = find_def(src_tags, root)
    pl = place_of(sp)
    assert pl.get('characterId') == '585', f'lv{lvl} bullet unexpected char {pl.get("characterId")}'
    pl.set('characterId', str(new_bullet_shape[lvl]))
    set_natural_matrix(pl)
    print(f'plasma_lv{lvl}_bullet (sprite {root}): 585 -> shape {new_bullet_shape[lvl]} natural size')

root6 = src_ex['plasma_lv6_bullet']
sp6 = find_def(src_tags, root6)
pl6 = place_of(sp6)
assert pl6.get('characterId') == '585', 'lv6 bullet unexpected char'
pl6.set('characterId', str(new_bullet_shape[5]))
set_scale_matrix(pl6, *LV6_BULLET_SCALE)
print(f'plasma_lv6_bullet (sprite {root6}): 585 -> shape {new_bullet_shape[5]} scaleX={LV6_BULLET_SCALE[0]} scaleY={LV6_BULLET_SCALE[1]}')

# ---------- 3. LV5 本体时间轴回归 2.5（本体不动 + 焰斑叠加） ----------
lv5 = find_def(src_tags, src_ex['plasma_lv5'])
subs = lv5.find('subTags')
d25_lv5 = find_def(donor_tags, donor_ex['plasma_lv5'])
donor_flash_pl = None
for ch in d25_lv5.find('subTags'):
    if ch.get('type', '').startswith('PlaceObject') and ch.get('characterId') == str(DONOR_FLASH_SHAPE):
        donor_flash_pl = ch
assert donor_flash_pl is not None, 'donor lv5 flash placement not found'
donor_matrix = copy.deepcopy(donor_flash_pl.find('matrix'))
print('donor lv5 flash matrix attrs:', donor_matrix.attrib)

# 按帧归类现有子标签
stream_head = None
f1_places, f2_items, f3_items, f4_items = [], [], [], []
frame = 0
for ch in list(subs):
    ty = ch.get('type')
    if ty == 'SoundStreamHead2Tag':
        stream_head = ch
        continue
    if ty == 'ShowFrameTag':
        frame += 1
        continue
    if frame == 0:
        f1_places.append(ch)
    elif frame == 1:
        f2_items.append(ch)
    elif frame == 2:
        f3_items.append(ch)
    elif frame == 3:
        f4_items.append(ch)

assert len(f1_places) == 3, f'lv5 f1 places: {len(f1_places)}'
body_place = next(ch for ch in f1_places if ch.get('characterId') == '1074')
flash_place = next(ch for ch in f2_items if ch.get('type', '').startswith('PlaceObject')
                   and ch.get('characterId') == '1076')
start_sound = next(ch for ch in f2_items if ch.get('type') == 'StartSoundTag')
rm_d2 = next(ch for ch in f4_items if ch.get('type') == 'RemoveObject2Tag' and ch.get('depth') == '2')

# 改写焰斑放置：char 1076 -> 2.5 焰斑复制，矩阵用 2.5 原值
flash_place.set('characterId', str(new_flash_id))
old_m = flash_place.find('matrix')
pos = list(flash_place).index(old_m)
flash_place.remove(old_m)
flash_place.insert(pos, copy.deepcopy(donor_matrix))

# 按 2.5 结构重组：f1 本体+挂点；f2 焰斑+音效；f3 空；f4 仅移除焰斑
for ch in list(subs):
    if ch is not stream_head:
        subs.remove(ch)
for ch in [body_place, *f1_places[1:], ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'})]:
    subs.append(ch)
subs.append(flash_place)
subs.append(start_sound)
subs.append(ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'}))
subs.append(ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'}))
subs.append(rm_d2)
subs.append(ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'}))
print('lv5 body timeline rebuilt to 2.5 structure (body stays, flash overlay, f4 cleanup)')

# ---------- 4. LV6 本体 f4 补 RemoveObject2 ----------
lv6 = find_def(src_tags, src_ex['plasma_lv6'])
subs6 = lv6.find('subTags')
f4_body_move = None
seen_show = 0
for ch in subs6:
    ty = ch.get('type')
    if ty == 'ShowFrameTag':
        seen_show += 1
    if (seen_show == 3 and ty == 'PlaceObject2Tag'
            and ch.get('characterId') == '1068' and ch.get('placeFlagMove') == 'true'):
        f4_body_move = ch
assert f4_body_move is not None, 'lv6 f4 body move not found'
idx = list(subs6).index(f4_body_move)
rm = ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': '2', 'forceWriteAsLong': 'false'})
subs6.insert(idx + 1, rm)
print('lv6 f4: inserted RemoveObject2 depth=2 after body restore')

# ---------- 5. 断言与写盘 ----------
def count_sprite_places(sprite_tag):
    return sum(1 for ch in sprite_tag.find('subTags')
               if ch.get('type', '').startswith('PlaceObject'))

assert count_sprite_places(find_def(src_tags, src_ex['plasma_lv5'])) == 4, 'lv5 place count'
assert count_sprite_places(find_def(src_tags, src_ex['plasma_lv6'])) == 6, 'lv6 place count'
for lvl in range(1, 6):
    sp = find_def(src_tags, src_ex[f'plasma_lv{lvl}_bullet'])
    assert place_of(sp).get('characterId') == str(new_bullet_shape[lvl])

ids = [def_id(t) for t in list(src_tags)]
ids = [i for i in ids if i is not None]
assert len(ids) == len(set(ids)), 'duplicate character id after merge'
assert max(ids) == next_id - 1, f'max id {max(ids)} != expected {next_id - 1}'

ET.indent(src_tree, space='  ')
src_tree.write(OUT, encoding='UTF-8', xml_declaration=True)
print()
print('--- import report ---')
for line in report:
    print(' ', line)
print('written ->', OUT)
