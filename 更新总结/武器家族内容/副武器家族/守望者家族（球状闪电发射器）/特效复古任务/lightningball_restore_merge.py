# -*- coding: utf-8 -*-
# 守望者家族（lightningBall）LV1~LV3 本体时间轴 2.5 回迁合并脚本（2026-09-09）
# 用户决策：全部复原 2.5
#   - LV1~LV3 本体时间轴整段换成 2.5 模板（找回 depth2 "发光本体"层：枪体复制 1260 + 每帧颜色变换 f1~f11，f3/f9 ADD）
#   - LV4/LV5 三版本本就逐帧一致，不动
#   - 子弹五级三版 0 差异，不动
#   - 受击不导入资源（GH sub1130 已存与 2.5 逐帧一致的 energy_hit_effect cid1462，配置改绑即可，另脚本已完成）
# 特例映射：
#   - 挂点 110 -> 104（矩阵强制当前值）
#   - 开火音 StartSound 1225 -> 946（GH 已有等音，SHA-256 同，直接重绑不克隆）
# 禁区：不动 1325/948/950/1326/557/562/567/572 等 GH 旧本体资产（留作孤儿）；lv4(1307)/lv5(1304) 不动
# 铁律：全程持有同一棵 ElementTree，禁止重新读取原始 XML（鞭炮教训）
import xml.etree.ElementTree as ET
import copy, sys
sys.stdout.reconfigure(encoding='utf-8')

SRC = "sub37.xml"              # 2.5 原版（只读参照）
TGT = "sub1130_fresh.xml"      # 当前版（三处同步态 c89b9c80 的转储）
OUT = "sub1130-lb-restored.xml"

BODIES = [  # (标签, GH 精灵, 2.5 模板精灵)
    ("lv1", 1327, 1261),
    ("lv2", 1323, 1256),
    ("lv3", 1313, 1244),
]
ANCHOR_25 = "110"      # 2.5 挂点角色 -> GH 104
ANCHOR_GH = "104"
FIRE_SOUND_25 = "1225" # -> GH 946（等音重绑）
FIRE_SOUND_GH = "946"

# ---------- load ----------
src = ET.parse(SRC).getroot()
tgt = ET.parse(TGT).getroot()

def find_sprite(root, sid):
    for it in root.iter('item'):
        if it.get('spriteId') == str(sid): return it

def find_def_any(root, cid):
    for it in root.iter('item'):
        if it.get('shapeId') == str(cid): return ('shape', it)
        if it.get('characterID') == str(cid) and 'DefineBits' in (it.get('type') or ''): return ('bitmap', it)
        if it.get('spriteId') == str(cid): return ('sprite', it)
    return None

# ---------- 预置映射（挂点重绑 + 开火音等音重绑） ----------
id_map = {ANCHOR_25: ANCHOR_GH, FIRE_SOUND_25: FIRE_SOUND_GH}

# ---------- 目标 ID 上限 ----------
maxid = 0
DEF_ID_ATTRS = ('characterID', 'shapeId', 'spriteId', 'soundId', 'fontId')
orig_ids = set()
for it in tgt.iter('item'):
    for k in DEF_ID_ATTRS:
        v = it.get(k)
        if v and v.isdigit():
            if k == 'characterID' and int(v) == 65535: continue
            maxid = max(maxid, int(v)); orig_ids.add(int(v))
next_id = maxid + 1
print("目标最大角色 ID:", maxid, " 新 ID 从", next_id, "起")

# ---------- 闭包收集（后序；共享资产经 id_map 去重） ----------
import_defs = []
missing = []

def walk(cid):
    global next_id
    cid = str(cid)
    if cid in id_map: return
    kind_el = find_def_any(src, cid)
    if kind_el is None:
        missing.append(cid); return
    kind, el = kind_el
    if kind == 'sprite':
        refs = []
        for po in el.findall('.//subTags/item'):
            if 'PlaceObject' in (po.get('type') or ''):
                c = po.get('characterId')
                if c and c != '65535' and c != '0': refs.append(c)
        for r in refs: walk(r)
    elif kind == 'shape':
        for f in el.findall('.//fillStyles/item'):
            b = f.get('bitmapId')
            if b and b != '65535' and b != '0': walk(b)
    new_id = next_id; next_id += 1
    id_map[cid] = str(new_id)
    import_defs.append((kind, cid, el, str(new_id)))

for _, tb, sb in BODIES:
    walk(sb)
# 根模板精灵不导入（replace_timeline 直接取 src 模板内容放进 GH 精灵，导入件会成为孤儿）
import_defs = [t for t in import_defs if not (t[0] == 'sprite' and str(t[1]) in ('1261', '1256', '1244'))]
print("导入闭包:", len(import_defs), " 缺失:", missing)
assert not missing, "2.5 闭包存在缺失定义！"
for kind, src_id, el, new_id in import_defs:
    print("  %s %-5s -> %s" % (kind, src_id, new_id))

# ---------- 克隆重映射 ----------
def remap_attrs(el, m):
    for k, v in list(el.attrib.items()):
        if k in ('characterId', 'characterID', 'shapeId', 'spriteId', 'bitmapId', 'soundId'):
            if v == '65535': continue
            if v in m: el.set(k, m[v])
    for c in el: remap_attrs(c, m)

# ---------- 当前版挂点矩阵（强制覆盖） ----------
cur_markers = {}
for lv, tb, sb in BODIES:
    sp = find_sprite(tgt, tb)
    mats = {}
    for po in sp.findall('.//subTags/item'):
        if 'PlaceObject' in (po.get('type') or '') and po.get('name'):
            m = po.find('matrix')
            if m is not None: mats[po.get('name')] = copy.deepcopy(m)
    cur_markers[lv] = mats
print("当前版挂点:", {lv: sorted(m.keys()) for lv, m in cur_markers.items()})

# ---------- 定位插入点（第一个本体精灵之前，保持定义先于引用） ----------
parent_map = {c: p for p in tgt.iter() for c in p}
first_body_el = find_sprite(tgt, BODIES[0][1])
parent = parent_map[first_body_el]
ins = list(parent).index(first_body_el)

# ---------- 插入导入闭包（后序） ----------
for kind, src_id, el, new_id in import_defs:
    c = copy.deepcopy(el)
    remap_attrs(c, id_map)
    if kind == 'sprite': c.set('spriteId', new_id)
    elif kind == 'shape': c.set('shapeId', new_id)
    else: c.set('characterID', new_id)
    parent.insert(ins, c); ins += 1
print("已插入导入闭包", len(import_defs), "项")

# ---------- 替换 LV1~LV3 本体时间轴 ----------
for lv, tb, sb in BODIES:
    sp = find_sprite(tgt, tb)
    src_sp = find_sprite(src, sb)
    new_sub = copy.deepcopy(src_sp.find('subTags'))
    remap_attrs(new_sub, id_map)
    # 挂点矩阵强制当前值
    forced = 0
    for po in new_sub.findall('.//item'):
        if 'PlaceObject' in (po.get('type') or '') and po.get('name'):
            m = po.find('matrix')
            new_m = cur_markers[lv].get(po.get('name'))
            if new_m is not None and m is not None:
                po.remove(m); po.append(copy.deepcopy(new_m)); forced += 1
    old_sub = sp.find('subTags')
    sp.remove(old_sub)
    sp.insert(0, new_sub)
    fc = len([e for e in new_sub if e.get('type') == 'ShowFrameTag'])
    sp.set('frameCount', str(fc))
    print("%s: sprite%d 时间轴已替换（2.5 模板 %d） 帧数=%d 挂点矩阵强制=%d" % (lv, tb, sb, fc, forced))

ET.indent(tgt)
new_tree = ET.ElementTree(tgt)
new_tree.write(OUT, encoding='utf-8', xml_declaration=True)
print("写出:", OUT)
