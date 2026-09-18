# -*- coding: utf-8 -*-
# 响尾蛇家族（导弹发射器 missile）2.5 回迁合并脚本（2026-09-09）
# 范围（用户决策）：①射速 ②枪口焰六帧序列 ③lv2~lv4 开火闪光层（最高优先）④受击特效 ⑤开火音效
# 禁区：成长线与经济字段（commonLevel/reduceRa/price/mustItems）一律不动
# 策略（沿电磁炮先例）：
#   - 整树克隆 2.5 定义，闭包后序导入（位图→形状→精灵），内部 ID 全量重映射
#   - 本体时间轴整段换成 2.5 原时间轴（角色/音效 ID 重映射，挂点矩阵强制当前值）
#   - 受击爆炸新精灵经死名改绑获得导出名（boom_hit_effect 为敌方 178+17 处共用，禁止原位重建）
#   - 开火音效 108 为 zhongzifeidan_lv1/lv2、killPig_lv1 共用，新增音效 ID 不动 108
# 铁律：全程持有同一棵 ElementTree，禁止重新读取原始 XML（鞭炮教训）
import xml.etree.ElementTree as ET
import copy, json, hashlib, sys

SRC = "sub37.xml"
TGT = "sub1130.xml"
OUT = "sub1130-restored.xml"

# 目标本体精灵（GH 现行）与 2.5 模板本体
BODIES = [
    # lv, gh_sprite, src25_sprite
    ("lv1", 1398, 1425),
    ("lv2", 1393, 1415),
    ("lv3", 1386, 1403),
    ("lv4", 1383, 1398),
]
EXPLOSION_SRC = 1678          # 2.5 boom_hit_effect（6 帧）
LAYERS_SRC = [1407, 1402, 1390]   # lv2/lv3/lv4 闪光层 sprite
DEAD_NAME = "positron_hit_effect"  # 死名改绑目标（零配置/零内部/零脚本引用）

# ---------- load ----------
src = ET.parse(SRC).getroot()
tgt = ET.parse(TGT).getroot()   # 唯一工作树

def find_sprite(root, sid):
    for it in root.iter('item'):
        if it.get('spriteId') == str(sid): return it
def find_def_any(root, cid):
    for it in root.iter('item'):
        if it.get('shapeId') == str(cid): return ('shape', it)
        if it.get('characterID') == str(cid) and 'DefineBits' in (it.get('type') or ''): return ('bitmap', it)
        if it.get('spriteId') == str(cid): return ('sprite', it)
    return None
def find_sound(root, sid):
    for it in root.iter('item'):
        if it.get('type') == 'DefineSoundTag' and it.get('soundId') == str(sid): return it

# ---------- 预置映射：2.5 角色 -> 当前版等价角色 ----------
id_map = {
    # 待机本体
    "1417": "1395", "1405": "1388", "1400": "1385", "1388": "1378",
    # 开火本体
    "1418": "1396", "1408": "1389", "116": "539", "1391": "1379",
    # 枪口焰复用件（GH 现存与 2.5 同内容）
    "1410": "1390", "1412": "1391", "1414": "1392",
    "1393": "1380", "1395": "1381", "1397": "1382",
    "118": "541", "120": "542", "122": "544", "124": "545", "126": "547", "130": "550",
    # 挂点
    "110": "104",
    # 位图（焰序六图 + lv1 本体图，sub1130 已有同哈希副本）
    "117": "540", "119": "109", "121": "543", "123": "111", "125": "546", "129": "113",
    "1416": "1394",
}
# 不可导入排除集（上述全部 + 位图由 id_map 拦截）
EXCLUDE = set(id_map.keys())

# ---------- 目标 ID 上限 ----------
maxid = 0
DEF_ID_ATTRS = ('characterID', 'shapeId', 'spriteId', 'soundId', 'fontId')
for it in tgt.iter('item'):
    for k in DEF_ID_ATTRS:
        v = it.get(k)
        if v and v.isdigit():
            if k == 'characterID' and int(v) == 65535:  # 遗留空填充 ID
                continue
            maxid = max(maxid, int(v))
next_id = maxid + 1
orig_ids = set()
for it in tgt.iter('item'):
    for k in DEF_ID_ATTRS:
        v = it.get(k)
        if v and v.isdigit() and not (k == 'characterID' and int(v) == 65535):
            orig_ids.add(int(v))
print("目标最大角色 ID:", maxid, " 新 ID 从", next_id, "起")

# ---------- 闭包收集（后序） ----------
import_defs = []
missing = []

def walk(cid):
    global next_id
    cid = str(cid)
    if cid in id_map or cid in EXCLUDE: return
    kind_el = find_def_any(src, cid)
    if kind_el is None:
        missing.append(cid); return
    kind, el = kind_el
    if kind == 'sprite':
        refs = []
        for po in el.findall('.//subTags/item'):
            if 'PlaceObject' in (po.get('type') or ''):
                c = po.get('characterId')
                if c and c != '65535': refs.append(c)
        for r in refs: walk(r)
    elif kind == 'shape':
        for f in el.findall('.//fillStyles/item'):
            b = f.get('bitmapId')
            if b and b != '65535': walk(b)
    new_id = next_id; next_id += 1
    id_map[cid] = str(new_id)
    import_defs.append((kind, cid, el, str(new_id)))

for s in LAYERS_SRC: walk(s)
walk(EXPLOSION_SRC)
for s in [1419, 1420, 1421, 1422, 1423, 1424, 1409, 1411, 1413, 1392, 1394, 1396]:
    walk(s)
print("导入闭包:", len(import_defs), " 缺失:", missing)

# ---------- 音效克隆（开火 111 -> new，受击 1673 -> new） ----------
def clone_sound(src_sid):
    global next_id
    el = find_sound(src, src_sid)
    assert el is not None, f"2.5 sound {src_sid} 未找到"
    new_id = next_id; next_id += 1
    c = copy.deepcopy(el)
    c.set('soundId', str(new_id))
    import_defs.append(('sound', str(src_sid), c, str(new_id)))
    return str(new_id)

FIRE_SOUND_NEW = clone_sound(111)
EXP_SOUND_NEW = clone_sound(1673)
print("开火音效 111 ->", FIRE_SOUND_NEW, " 受击音效 1673 ->", EXP_SOUND_NEW)
id_map["111"] = FIRE_SOUND_NEW
id_map["1673"] = EXP_SOUND_NEW

# ---------- 克隆重映射 ----------
def remap_attrs(el, extra_map):
    for k, v in list(el.attrib.items()):
        if k in ('characterId', 'characterID', 'shapeId', 'spriteId', 'bitmapId', 'soundId'):
            if v == '65535': continue
            if v in extra_map: el.set(k, extra_map[v])
    for c in el: remap_attrs(c, extra_map)

# 每级时间轴合成映射（预置 + 新导入）
combined = dict(id_map)

# ---------- 当前版挂点矩阵（强制覆盖，保证射点不漂移） ----------
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

# ---------- 定位插入点（lv1 本体之前=全部定义之前） ----------
parent_map = {c: p for p in tgt.iter() for c in p}
first_body_el = find_sprite(tgt, BODIES[0][1])
parent = parent_map[first_body_el]
ins = list(parent).index(first_body_el)

# ---------- 插入导入闭包（后序=定义先于引用） ----------
new_sprite_ids = {}
for kind, src_id, el, new_id in import_defs:
    c = copy.deepcopy(el)
    remap_attrs(c, id_map)
    if kind == 'sprite':
        c.set('spriteId', new_id)
        new_sprite_ids[src_id] = new_id
    elif kind == 'shape':
        c.set('shapeId', new_id)
    elif kind == 'sound':
        c.set('soundId', new_id)
    else:
        c.set('characterID', new_id)
    parent.insert(ins, c); ins += 1

EXPLOSION_NEW = new_sprite_ids[str(EXPLOSION_SRC)]
LAYER_NEW = {1407: new_sprite_ids['1407'], 1402: new_sprite_ids['1402'], 1390: new_sprite_ids['1390']}
print("受击爆炸新精灵:", EXPLOSION_NEW, " 闪光层新精灵:", LAYER_NEW)

# ---------- 替换四级本体时间轴 ----------
for lv, tb, sb in BODIES:
    sp = find_sprite(tgt, tb)
    src_sp = find_sprite(src, sb)
    new_sub = copy.deepcopy(src_sp.find('subTags'))
    remap_attrs(new_sub, combined)
    # 强制挂点矩阵=当前值
    for po in new_sub.findall('.//item'):
        if 'PlaceObject' in (po.get('type') or '') and po.get('name'):
            m = po.find('matrix')
            new_m = cur_markers[lv].get(po.get('name'))
            if new_m is not None and m is not None:
                po.remove(m); po.append(copy.deepcopy(new_m))
    old_sub = sp.find('subTags')
    sp.remove(old_sub)
    sp.insert(0, new_sub)
    frame_count = len([e for e in new_sub if e.get('type') == 'ShowFrameTag'])
    print(f"{lv}: sprite{tb} 时间轴已替换（2.5 模板 {sb}），帧数={frame_count}")

# lv2/lv3/lv4 闪光层精灵为各等级专用：修正时间轴中的层放置已由 combined 映射完成
# （1407/1402/1390 已分别映射到 1697/1699/1701）

# ---------- SymbolClass 死名改绑：positron_hit_effect 824 -> EXPLOSION_NEW ----------
sc = None
for it in tgt.iter('item'):
    if it.get('type') == 'SymbolClassTag': sc = it; break
tags_el = sc.find('tags'); names_el = sc.find('names')
tag_items = list(tags_el); name_items = list(names_el)
assert len(tag_items) == len(name_items)
idxs = [i for i, (t, n) in enumerate(zip(tag_items, name_items)) if n.text and n.text.strip() == DEAD_NAME]
assert len(idxs) == 1, f"死名 {DEAD_NAME} 绑定数异常: {idxs}"
i = idxs[0]
old_cid = tag_items[i].text
tags_el.remove(tag_items[i]); names_el.remove(name_items[i])
t_new = ET.SubElement(tags_el, 'item'); t_new.text = str(EXPLOSION_NEW)
n_new = ET.SubElement(names_el, 'item'); n_new.text = DEAD_NAME
print(f"SymbolClass: {DEAD_NAME} {old_cid} -> {EXPLOSION_NEW}")

# ---------- 孤儿清理（lv1 旧焰效件 1397/112/114，确认零引用后移除） ----------
def char_refs(cid):
    return sum(1 for po in tgt.iter('item')
               if 'PlaceObject' in (po.get('type') or '') and po.get('characterId') == str(cid))
removed_orphans = []
for cid in [1397, 112, 114]:
    if char_refs(cid) == 0:
        el = None
        for it in tgt.iter('item'):
            if it.get('spriteId') == str(cid): el = it; break
        if el is not None:
            pmap = {c: p for p in tgt.iter() for c in p}
            pmap[el].remove(el)
            removed_orphans.append(cid)
print("移除孤儿:", removed_orphans)

# ---------- 校验 ----------
# 1) 导出表仅 positron_hit_effect 一处变化
def export_map(root):
    m = {}
    for it in root.iter('item'):
        if 'SymbolClass' in (it.get('type') or ''):
            ts = [e.text for e in it.findall('.//tags/item')]
            ns = [e.text for e in it.findall('.//names/item')]
            for t, n in zip(ts, ns):
                if n: m[n.strip()] = t
    return m
e_old = export_map(ET.parse(TGT).getroot())
e_new = export_map(tgt)
diff = {k: (e_old.get(k), e_new.get(k)) for k in set(e_old) | set(e_new) if e_old.get(k) != e_new.get(k)}
assert diff == {DEAD_NAME: ("824", str(EXPLOSION_NEW))}, f"导出表异常变化: {diff}"
# 2) 无重复 spriteId
sids = [it.get('spriteId') for it in tgt.iter('item') if it.get('spriteId')]
assert len(sids) == len(set(sids)), "存在重复 spriteId！"
# 3) 新 ID 无冲突
for i2 in range(maxid + 1, next_id):
    assert i2 not in orig_ids, f"新 ID {i2} 与既有定义冲突！"
# 4) 各级时间轴结构
for lv, tb, sb in BODIES:
    sp = find_sprite(tgt, tb)
    frames = []
    cur = 0
    for e in sp.findall('.//subTags/item'):
        t = e.get('type')
        if t == 'ShowFrameTag':
            cur += 1
        elif t == 'StartSoundTag':
            assert e.get('soundId') == FIRE_SOUND_NEW, f"{lv} StartSound 音效错误"
    assert cur == 13, f"{lv} 帧数 {cur} != 13"
    flashes = sum(1 for e in sp.findall('.//subTags/item')
                  if 'PlaceObject' in (e.get('type') or '') and e.get('depth') == '4'
                  and e.get('characterId') not in (None, '65535'))
    layer_moves = sum(1 for e in sp.findall('.//subTags/item')
                      if 'PlaceObject' in (e.get('type') or '') and e.get('depth') == '2'
                      and e.get('characterId') is None)
    ss = sum(1 for e in sp.findall('.//subTags/item') if e.get('type') == 'StartSoundTag')
    print(f"{lv}: 帧数=13 开火帧音效={ss} d4焰效放置={flashes} 层alpha记录={layer_moves}")
# 5) 爆炸精灵
ex = find_sprite(tgt, EXPLOSION_NEW)
n_frames = len([e for e in ex.findall('.//subTags/item') if e.get('type') == 'ShowFrameTag'])
n_place = sum(1 for e in ex.findall('.//subTags/item') if 'PlaceObject' in (e.get('type') or '') and e.get('characterId'))
ss = [e.get('soundId') for e in ex.findall('.//subTags/item') if e.get('type') == 'StartSoundTag']
assert n_frames == 7 and n_place == 6 and ss == [EXP_SOUND_NEW], f"爆炸精灵异常: {n_frames}/{n_place}/{ss}"
print(f"爆炸精灵 {EXPLOSION_NEW}: 7帧/6放置/音效{ss[0]}")

# ---------- 写出 ----------
ET.ElementTree(tgt).write(OUT, encoding="utf-8", xml_declaration=True)
json.dump({
    "dead_name_rebind": {DEAD_NAME: [old_cid, str(EXPLOSION_NEW)]},
    "fire_sound": {"111": FIRE_SOUND_NEW}, "explosion_sound": {"1673": EXP_SOUND_NEW},
    "layers": {str(k): v for k, v in LAYER_NEW.items()},
    "orphan_removed": removed_orphans,
    "new_id_range": [maxid + 1, next_id - 1],
}, open("restore-manifest.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("saved", OUT, " 新 ID 区间:", maxid + 1, "-", next_id - 1, " 导入定义:", len(import_defs))
