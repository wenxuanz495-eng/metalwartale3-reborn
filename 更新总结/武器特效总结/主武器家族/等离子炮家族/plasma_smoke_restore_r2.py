import copy
import xml.etree.ElementTree as ET
from pathlib import Path

WORK = Path(r'D:\superalloy\tmp-soya-family-test\plasma-audit\work')
SRC = WORK / 'arms1100.merged.xml'        # 当前已部署版本的 XML（含第一轮回迁）
DONOR = WORK / 'arms34.25.xml'            # 2.5 arms_34.swf
OUT = WORK / 'arms1100.round2.xml'

NEXT_ID = 1751                            # 当前最大 1750
NEW_SMOKE_BITMAP = 1751                   # 2.5 bitmap 189
NEW_SMOKE_SHAPE = 1752                    # 2.5 shape 190（拖尾焰形）
NEW_SMOKE_CORE = 1753                     # 2.5 sprite 191（拖尾内核）
DONOR_BMP, DONOR_SHAPE, DONOR_CORE = 189, 190, 191
GH_SMOKE = {1: 1066, 2: 1065, 3: 1064, 4: 1063}   # GH 现有拖尾根（将被重写内容）
DONOR_SMOKE = {1: 195, 2: 194, 3: 193, 4: 192}    # 2.5 拖尾根
ORPHAN_IDS = [1076, 1061, 1062]           # 旧LV5开火整图、lv6_smoke、lv5_smoke
ORPHAN_EXPORTS = {'plasma_lv5_smoke', 'plasma_lv6_smoke'}
SENTINELS = {0, 65535}

DEF_KEYS = ('characterID', 'shapeId', 'spriteId', 'soundId',
            'fontId', 'buttonId', 'morphShapeId', 'textId', 'bitmapId', 'jpegId')


def def_id(t):
    for k in DEF_KEYS:
        if k in t.attrib:
            return int(t.get(k))
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
            for idn, n in zip(t.find('tags').findall('item'), t.find('names').findall('item')):
                ex[n.text] = int(idn.text)
    return ex


src_tree = ET.parse(SRC)
src_tags = src_tree.getroot().find('tags')
donor_tags = ET.parse(DONOR).getroot().find('tags')
src_ex = exports(src_tags)
donor_ex = exports(donor_tags)

# ---------- 1. 导入 2.5 拖尾内核链 bitmap189 -> shape190 -> sprite191 ----------
# sprite 先占 1753，shape 1752，bitmap 1751
bmp = find_def(donor_tags, DONOR_BMP)
shp = find_def(donor_tags, DONOR_SHAPE)
cor = find_def(donor_tags, DONOR_CORE)
assert bmp.get('type') == 'DefineBitsLossless2Tag'
assert shp.get('type') == 'DefineShapeTag'
assert cor.get('type') == 'DefineSpriteTag'

bmp_new = copy.deepcopy(bmp)
bmp_new.set('characterID', str(NEW_SMOKE_BITMAP))
shp_new = copy.deepcopy(shp)
shp_new.set('shapeId', str(NEW_SMOKE_SHAPE))
for n in shp_new.iter():
    if n.get('bitmapId') == str(DONOR_BMP):
        n.set('bitmapId', str(NEW_SMOKE_BITMAP))
cor_new = copy.deepcopy(cor)
cor_new.set('spriteId', str(NEW_SMOKE_CORE))
for n in cor_new.iter():
    if n.get('characterId') == str(DONOR_SHAPE):
        n.set('characterId', str(NEW_SMOKE_SHAPE))

src_tags.append(bmp_new)
src_tags.append(shp_new)
src_tags.append(cor_new)
print(f'imported: bitmap {DONOR_BMP}->{NEW_SMOKE_BITMAP}, shape {DONOR_SHAPE}->{NEW_SMOKE_SHAPE}, sprite {DONOR_CORE}->{NEW_SMOKE_CORE}')

# ---------- 2. 重写 GH lv1~lv4 拖尾 Sprite 内容为 2.5 时间轴 ----------
for lvl in range(1, 5):
    gh_sp = find_def(src_tags, GH_SMOKE[lvl])
    donor_sp = find_def(donor_tags, DONOR_SMOKE[lvl])
    new_subs = copy.deepcopy(donor_sp.find('subTags'))
    for n in new_subs.iter():
        if n.get('characterId') == str(DONOR_CORE):
            n.set('characterId', str(NEW_SMOKE_CORE))
    old_subs = gh_sp.find('subTags')
    gh_sp.remove(old_subs)
    gh_sp.append(new_subs)
    print(f'plasma_lv{lvl}_smoke (sprite {GH_SMOKE[lvl]}): content replaced with 2.5 timeline (core {NEW_SMOKE_CORE}, start scale per 2.5)')

# ---------- 3. 移除孤儿资源 ----------
# 3a. 校验无引用
refs = {i: [] for i in ORPHAN_IDS}
for t in list(src_tags):
    if t.get('type') == 'DefineSpriteTag' and def_id(t) not in ORPHAN_IDS:
        for n in t.iter():
            for k in ('characterId', 'soundId', 'fontId', 'buttonId'):
                v = n.get(k)
                if v is not None and int(v) in ORPHAN_IDS:
                    refs[int(v)].append(def_id(t))
for i, r in refs.items():
    assert not r, f'orphan {i} still referenced by {r}'
print('orphan ids unreferenced:', ORPHAN_IDS)

# 3b. 删除定义与导出
for cid in ORPHAN_IDS:
    t = find_def(src_tags, cid)
    assert t is not None, f'orphan def {cid} missing'
    src_tags.remove(t)
    print(f'removed def {cid} ({t.get("type")})')

sym = next(t for t in list(src_tags) if t.get('type') == 'SymbolClassTag')
tn = sym.find('tags').findall('item')
nn = sym.find('names').findall('item')
keep = [(a, b) for a, b in zip(tn, nn) if b.text not in ORPHAN_EXPORTS]
removed = [b.text for a, b in zip(tn, nn) if b.text in ORPHAN_EXPORTS]
assert len(keep) == len(tn) - 2, 'unexpected export removal count'
for a in tn:
    sym.find('tags').remove(a)
for b in nn:
    sym.find('names').remove(b)
for a, b in keep:
    sym.find('tags').append(a)
    sym.find('names').append(b)
print('removed exports:', removed)

# ---------- 4. 断言与写盘 ----------
ids = [def_id(t) for t in list(src_tags)]
ids = [i for i in ids if i is not None]
assert len(ids) == len(set(ids)), 'duplicate id'
assert max(ids) == NEW_SMOKE_CORE, f'max id {max(ids)}'
ex2 = exports(src_tags)
for lvl in range(1, 5):
    assert ex2[f'plasma_lv{lvl}_smoke'] == GH_SMOKE[lvl], f'lv{lvl} smoke export id drift'
for name in ORPHAN_EXPORTS:
    assert name not in ex2, f'{name} export should be gone'
assert 'plasma_lv1_bullet' in ex2 and ex2['plasma_lv1_bullet'] == 1060
assert 'plasma_lv6' in ex2 and ex2['plasma_lv6'] == 1072
# 585 仍被 conBullet_smoke(586) 引用，保留
con = next(t for t in list(src_tags)
           if t.get('type') == 'DefineSpriteTag' and t.get('spriteId') == '586')
still = any(ch.get('characterId') == '585'
            for ch in con.find('subTags')
            if ch.get('type', '').startswith('PlaceObject'))
assert still, '585 expected to be referenced by conBullet_smoke'

ET.indent(src_tree, space='  ')
src_tree.write(OUT, encoding='UTF-8', xml_declaration=True)
print('written ->', OUT)
