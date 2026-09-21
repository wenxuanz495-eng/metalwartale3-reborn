# -*- coding: utf-8 -*-
# 高周波切割炮家族（cutter）2.5 回迁合并脚本（2026-09-09）
# 用户决策：①子弹回 2.5 五级独立 ②受击（六态+音频）回 2.5 ③待机/开火（充能序列）回 2.5 ④枪口火焰回 2.5
#          LV6 深渊MK2 用 LV5 的特效/子弹/开火音（本体保留 MK2 自身配色）
# 射速/分散/弹速不动（attackGap GH 已同 2.5；reduceRa/attackType 维持现状）
# 策略（沿响尾蛇/调皮先例）：
#   - lv1~lv5 本体时间轴整段换成 2.5 模板（闭包导入+挂点矩阵强制当前值+开火音克隆）
#   - MK2(1201) 时间轴同样换 2.5 lv5 模板，但待机体预映射保留 MK2 自身美术（1096->1185）
#   - 子弹 lv1~lv5：原位替换精灵内容为 2.5 五级独立弹（导出名/ID 不变，仅 cutter 家族自用已核查）
#   - MK2 子弹 lv6_bullet：原位替换为 2.5 lv5 弹内容（用户决策 MK2 用 lv5 子弹）
#   - 受击：cutter_hit_effect 被	xmlClass8(415)/xmlClass7(34)/xmlClass9(5)/xmlClass3(2) 共用，禁止原位替换——
#           导入 2.5 六态受击闭包建新精灵 + 死名改绑 cut_effect(69)（配置+脚本+存档零引用已核查），随后配置改绑（另脚本）
#   - 音效克隆：开火 1049（F28AC2F6，GH 无等音）-> 新 ID；受击 1608（AB4493A4，GH 无等音）-> 新 ID
# 禁区：不动 cutter_hit_effect(1509)/cutter_gold 体系/既有定义内容（旧资源留作孤儿）
# 铁律：全程持有同一棵 ElementTree，禁止重新读取原始 XML（鞭炮教训）
import xml.etree.ElementTree as ET
import copy, json

SRC = "../elastic-family-audit/work/sub37.xml"   # 2.5 原版（只读参照）
TGT = "work/sub1130.xml"                          # 当前版（elastic 回迁后导出，未再修改）
OUT = "work/sub1130-cutter-restored.xml"

# 四/五级本体：gh 精灵 <- 2.5 模板
BODIES = [
    ("lv1", 1260, 1187),
    ("lv2", 1241, 1158),
    ("lv3", 1224, 1129),
    ("lv4", 1207, 1100),
    ("lv5", 1204, 1097),
]
MK2_GH = 1201          # 深渊MK2 本体（GH 独有）
MK2_TEMPLATE = 1097    # 用 2.5 lv5 模板（深渊/幽灵）
BULLETS = [            # gh 精灵 <- 2.5 模板（原位内容替换）
    (1183, 1094), (1182, 1091), (1180, 1088), (1178, 1085), (1177, 1082),
]
LV6_BULLET_GH = 1174   # MK2 子弹：原位替换为 2.5 lv5 弹内容
HIT_SRC = 1617         # 2.5 六态受击（闭包导入建新精灵）
FIRE_SOUND_25 = 1049   # 2.5 开火音
HIT_SOUND_25 = 1608    # 2.5 受击音
DEAD_NAME = "cut_effect"  # 死名改绑目标

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
def find_sound(root, sid):
    for it in root.iter('item'):
        if it.get('type') == 'DefineSoundTag' and it.get('soundId') == str(sid): return it

# ---------- 预置映射 ----------
id_map = {
    "110": "104",     # 挂点（矩阵强制当前值）
}
EXCLUDE = set(id_map.keys())

# ---------- 目标 ID 上限 ----------
maxid = 0
DEF_ID_ATTRS = ('characterID', 'shapeId', 'spriteId', 'soundId', 'fontId')
for it in tgt.iter('item'):
    for k in DEF_ID_ATTRS:
        v = it.get(k)
        if v and v.isdigit():
            if k == 'characterID' and int(v) == 65535: continue
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

for lv, tb, sb in BODIES:
    walk(sb)
walk(MK2_TEMPLATE)
for gh_b, src_b in BULLETS:
    walk(src_b)
walk(1082)            # lv6_bullet 用 2.5 lv5 弹
walk(HIT_SRC)
print("导入闭包:", len(import_defs), " 缺失:", missing)
assert not missing, "2.5 闭包存在缺失定义！"

# ---------- 音效克隆 ----------
def clone_sound(src_sid):
    global next_id
    el = find_sound(src, src_sid)
    assert el is not None, "2.5 sound %d 未找到" % src_sid
    new_id = next_id; next_id += 1
    c = copy.deepcopy(el)
    c.set('soundId', str(new_id))
    import_defs.append(('sound', str(src_sid), c, str(new_id)))
    return str(new_id)

FIRE_SOUND_NEW = clone_sound(FIRE_SOUND_25)
HIT_SOUND_NEW = clone_sound(HIT_SOUND_25)
print("开火音效", FIRE_SOUND_25, "->", FIRE_SOUND_NEW, " 受击音效", HIT_SOUND_25, "->", HIT_SOUND_NEW)
id_map[str(FIRE_SOUND_25)] = FIRE_SOUND_NEW
id_map[str(HIT_SOUND_25)] = HIT_SOUND_NEW

# ---------- 克隆重映射 ----------
def remap_attrs(el, extra_map):
    for k, v in list(el.attrib.items()):
        if k in ('characterId', 'characterID', 'shapeId', 'spriteId', 'bitmapId', 'soundId'):
            if v == '65535': continue
            if v in extra_map: el.set(k, extra_map[v])
    for c in el: remap_attrs(c, extra_map)

combined = dict(id_map)
# MK2 专用映射：待机体 1096 -> 1185（仅 MK2 时间轴装配使用，lv5 仍用 2.5 自身待机体）
combined_mk2 = dict(combined); combined_mk2["1096"] = "1185"

# ---------- 当前版挂点矩阵（强制覆盖） ----------
cur_markers = {}
for lv, tb, sb in BODIES + [("MK2", MK2_GH, MK2_TEMPLATE)]:
    sp = find_sprite(tgt, tb)
    mats = {}
    for po in sp.findall('.//subTags/item'):
        if 'PlaceObject' in (po.get('type') or '') and po.get('name'):
            m = po.find('matrix')
            if m is not None: mats[po.get('name')] = copy.deepcopy(m)
    cur_markers[lv] = mats
print("当前版挂点:", {lv: sorted(m.keys()) for lv, m in cur_markers.items()})

# ---------- 定位插入点 ----------
parent_map = {c: p for p in tgt.iter() for c in p}
first_body_el = find_sprite(tgt, BODIES[0][1])
parent = parent_map[first_body_el]
ins = list(parent).index(first_body_el)

# ---------- 插入导入闭包（后序） ----------
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

HIT_NEW = new_sprite_ids[str(HIT_SRC)]
print("受击新精灵:", HIT_NEW)

# ---------- 替换 lv1~lv5 本体时间轴 ----------
def replace_timeline(gh_sid, src_sid, lv, force_markers=True, use_map=None):
    sp = find_sprite(tgt, gh_sid)
    src_sp = find_sprite(src, src_sid)
    new_sub = copy.deepcopy(src_sp.find('subTags'))
    remap_attrs(new_sub, use_map or combined)
    if force_markers:
        for po in new_sub.findall('.//item'):
            if 'PlaceObject' in (po.get('type') or '') and po.get('name'):
                m = po.find('matrix')
                new_m = cur_markers[lv].get(po.get('name'))
                if new_m is not None and m is not None:
                    po.remove(m); po.append(copy.deepcopy(new_m))
    old_sub = sp.find('subTags')
    sp.remove(old_sub)
    sp.insert(0, new_sub)
    fc = len([e for e in new_sub if e.get('type') == 'ShowFrameTag'])
    print("%s: sprite%d 时间轴已替换（2.5 模板 %d），帧数=%d" % (lv, gh_sid, src_sid, fc))

for lv, tb, sb in BODIES:
    replace_timeline(tb, sb, lv)
# MK2：2.5 lv5 模板，待机体已经由 combined_mk2 的 1096->1185 保留 MK2 美术
replace_timeline(MK2_GH, MK2_TEMPLATE, "MK2", use_map=combined_mk2)

# ---------- 子弹原位内容替换（结构同构：1 帧包 1 shape） ----------
for gh_b, src_b in BULLETS:
    replace_timeline(gh_b, src_b, "bullet%d" % gh_b, force_markers=False)
replace_timeline(LV6_BULLET_GH, 1082, "bullet%d(MK2=lv5弹)" % LV6_BULLET_GH, force_markers=False)

# ---------- SymbolClass 死名改绑：cut_effect(69) -> HIT_NEW ----------
sc = None
for it in tgt.iter('item'):
    if it.get('type') == 'SymbolClassTag': sc = it; break
tags_el = sc.find('tags'); names_el = sc.find('names')
tag_items = list(tags_el); name_items = list(names_el)
assert len(tag_items) == len(name_items)
idxs = [i for i, (t, n) in enumerate(zip(tag_items, name_items)) if n.text and n.text.strip() == DEAD_NAME]
assert len(idxs) == 1, "死名 %s 绑定数异常: %s" % (DEAD_NAME, idxs)
i = idxs[0]
old_cid = tag_items[i].text
tags_el.remove(tag_items[i]); names_el.remove(name_items[i])
t_new = ET.SubElement(tags_el, 'item'); t_new.text = str(HIT_NEW)
n_new = ET.SubElement(names_el, 'item'); n_new.text = DEAD_NAME
print("SymbolClass: %s %s -> %s" % (DEAD_NAME, old_cid, HIT_NEW))

# ---------- 校验 ----------
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
assert diff == {DEAD_NAME: ("69", str(HIT_NEW))}, "导出表异常变化: %s" % diff
print("导出表校验：仅 cut_effect 改绑 OK")
sids = [it.get('spriteId') for it in tgt.iter('item') if it.get('spriteId')]
assert len(sids) == len(set(sids)), "存在重复 spriteId！"
for i2 in range(maxid + 1, next_id):
    assert i2 not in orig_ids, "新 ID %d 冲突！" % i2

def timeline_signature(sp_el):
    sig = []
    for e in sp_el.findall('.//subTags/item'):
        t = e.get('type')
        if t == 'ShowFrameTag': sig.append(('F',))
        elif t == 'StartSoundTag': sig.append(('S',))
        elif 'PlaceObject' in (t or ''): sig.append(('P', e.get('depth'), e.get('characterId') is not None, e.get('placeFlagMove')))
        elif 'RemoveObject' in (t or ''): sig.append(('R', e.get('depth')))
    return sig

for lv, tb, sb in BODIES:
    sp = find_sprite(tgt, tb)
    a, b2 = timeline_signature(sp), timeline_signature(find_sprite(src, sb))
    assert a == b2, "%s 时间轴签名差异" % lv
    ss = [e.get('soundId') for e in sp.findall('.//subTags/item') if e.get('type') == 'StartSoundTag']
    assert ss == [FIRE_SOUND_NEW], "%s 开火音=%s" % (lv, ss)
    print("%s: 15 帧签名一致 开火音=%s OK" % (lv, FIRE_SOUND_NEW))
# MK2 签名与 2.5 lv5 模板一致
a = timeline_signature(find_sprite(tgt, MK2_GH))
b2 = timeline_signature(find_sprite(src, MK2_TEMPLATE))
assert a == b2, "MK2 时间轴签名差异"
# MK2 待机体=1185（MK2 美术保留）
mk2_idle = [e.get('characterId') for e in find_sprite(tgt, MK2_GH).findall('.//subTags/item')
            if 'PlaceObject' in (e.get('type') or '') and e.get('depth') == '1']
print("MK2 待机体引用:", mk2_idle, "（应为 1185=MK2 自身美术）")
assert mk2_idle == ['1185']
# 受击新精灵
ex = find_sprite(tgt, HIT_NEW)
nf = len([e for e in ex.findall('.//subTags/item') if e.get('type') == 'ShowFrameTag'])
ss = [e.get('soundId') for e in ex.findall('.//subTags/item') if e.get('type') == 'StartSoundTag']
print("受击新精灵 %s: %d 帧 音效=%s" % (HIT_NEW, nf, ss))
assert ss == [HIT_SOUND_NEW]

# ---------- 写出 ----------
ET.ElementTree(tgt).write(OUT, encoding="utf-8", xml_declaration=True)
json.dump({
    "bodies": {lv: {"gh_sprite": tb, "src25_sprite": sb} for lv, tb, sb in BODIES},
    "mk2": {"gh_sprite": MK2_GH, "template": MK2_TEMPLATE, "idle_kept": "1185"},
    "bullets_inplace": {str(g): s for g, s in BULLETS},
    "lv6_bullet_inplace": {str(LV6_BULLET_GH): 1082},
    "hit_new_sprite": HIT_NEW, "dead_name_rebind": {DEAD_NAME: ["69", str(HIT_NEW)]},
    "fire_sound": {str(FIRE_SOUND_25): FIRE_SOUND_NEW},
    "hit_sound": {str(HIT_SOUND_25): HIT_SOUND_NEW},
    "new_id_range": [maxid + 1, next_id - 1],
    "imported_defs": len(import_defs),
}, open("cutter-restore-manifest.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("saved", OUT, " 新 ID 区间: %d - %d  导入定义: %d" % (maxid + 1, next_id - 1, len(import_defs)))
