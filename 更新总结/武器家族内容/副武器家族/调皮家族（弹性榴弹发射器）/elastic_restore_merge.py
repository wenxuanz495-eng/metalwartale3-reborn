# -*- coding: utf-8 -*-
# 调皮家族（弹性榴弹发射器 elastic）2.5 回迁合并脚本（2026-09-09）
# 范围（用户决策）：③待机/开火状态＋枪口焰＋开火音效全部回到 2.5（SWF 时间轴整段替换）
#   ①射速、②受击特效走配置 bin 改绑（另脚本处理），本脚本不动配置
# 策略（沿响尾蛇先例）：
#   - 四级本体时间轴整段换成 2.5 原时间轴（角色/音效 ID 重映射，挂点矩阵强制当前值）
#   - 2.5 时间轴引用的全部定义（待机体/A 序列换体/B·C 枪口焰序列的 shape+bitmap）闭包后序导入
#   - 开火音效 1279（2.5 原音 46AC5021，sub1130 无等音）克隆为新 ID
#   - 受击不改 SWF：配置将改绑现有 positron_hit_effect（1702，已验证与 2.5 橙爆逐像素一致）
# 禁区：不动 boom_hit_effect/positron_hit_effect 等共用资源内容；不移除任何既有定义（旧焰效件留作孤儿，零风险）
# 铁律：全程持有同一棵 ElementTree，禁止重新读取原始 XML（鞭炮教训）
import xml.etree.ElementTree as ET
import copy, json

SRC = "../work/sub37.xml"       # 2.5 原版（只读参照）
TGT = "../work/sub1130.xml"     # 当前版（修改前导出）
OUT = "sub1130-restored.xml"

# 目标本体精灵（GH 现行）与 2.5 模板本体
BODIES = [
    # lv, gh_sprite, src25_sprite
    ("lv1", 1363, 1374),
    ("lv2", 1357, 1347),
    ("lv3", 1347, 1320),
    ("lv4", 1341, 1293),
]
FIRE_SOUND_25 = 1279   # 2.5 开火音（sub37），四级共用

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

# ---------- 预置映射：挂点用当前版等价角色（110 -> 104），其余全走闭包导入 ----------
id_map = {
    "110": "104",
}
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

for lv, tb, sb in BODIES:
    walk(sb)
print("导入闭包:", len(import_defs), " 缺失:", missing)
assert not missing, "2.5 闭包存在缺失定义！"

# ---------- 音效克隆（开火 1279 -> new） ----------
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
print("开火音效", FIRE_SOUND_25, "->", FIRE_SOUND_NEW)
id_map[str(FIRE_SOUND_25)] = FIRE_SOUND_NEW

# ---------- 克隆重映射 ----------
def remap_attrs(el, extra_map):
    for k, v in list(el.attrib.items()):
        if k in ('characterId', 'characterID', 'shapeId', 'spriteId', 'bitmapId', 'soundId'):
            if v == '65535': continue
            if v in extra_map: el.set(k, extra_map[v])
    for c in el: remap_attrs(c, extra_map)

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

# ---------- 定位插入点（lv1 本体之前） ----------
parent_map = {c: p for p in tgt.iter() for c in p}
first_body_el = find_sprite(tgt, BODIES[0][1])
parent = parent_map[first_body_el]
ins = list(parent).index(first_body_el)

# ---------- 插入导入闭包（后序=定义先于引用） ----------
for kind, src_id, el, new_id in import_defs:
    c = copy.deepcopy(el)
    remap_attrs(c, id_map)
    if kind == 'sprite':
        c.set('spriteId', new_id)
    elif kind == 'shape':
        c.set('shapeId', new_id)
    elif kind == 'sound':
        c.set('soundId', new_id)
    else:
        c.set('characterID', new_id)
    parent.insert(ins, c); ins += 1

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
    print("%s: sprite%d 时间轴已替换（2.5 模板 %d），帧数=%d" % (lv, tb, sb, frame_count))

# ---------- 校验 ----------
# 1) 导出表必须零变化（本脚本不涉及 SymbolClass）
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
assert diff == {}, "导出表异常变化: %s" % diff
print("导出表校验：零变化 OK")
# 2) 无重复 spriteId
sids = [it.get('spriteId') for it in tgt.iter('item') if it.get('spriteId')]
assert len(sids) == len(set(sids)), "存在重复 spriteId！"
# 3) 新 ID 无冲突
for i2 in range(maxid + 1, next_id):
    assert i2 not in orig_ids, "新 ID %d 与既有定义冲突！" % i2
# 4) 各级时间轴：帧数=15、StartSound 唯一且=新开火音、与 2.5 模板逐帧事件签名一致
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
    sig_new = timeline_signature(sp)
    sig_src = timeline_signature(find_sprite(src, sb))
    assert len(sig_new) == len(sig_src), "%s 事件数不一致" % lv
    for (a, b) in zip(sig_new, sig_src):
        assert a[0] == b[0] and a[1:] == b[1:], "%s 时间轴签名差异: %s vs %s" % (lv, a, b)
    ss = [e.get('soundId') for e in sp.findall('.//subTags/item') if e.get('type') == 'StartSoundTag']
    assert ss == [FIRE_SOUND_NEW], "%s StartSound=%s 应为 %s" % (lv, ss, FIRE_SOUND_NEW)
    frames = len([e for e in sp.findall('.//subTags/item') if e.get('type') == 'ShowFrameTag'])
    assert frames == 15, "%s 帧数 %d != 15" % (lv, frames)
    print("%s: 15 帧 OK 签名与 2.5 模板一致 OK 开火音=%s OK" % (lv, FIRE_SOUND_NEW))
# 5) 挂点名必须存在于当前版挂点集
for lv, tb, sb in BODIES:
    sp = find_sprite(tgt, tb)
    for po in sp.findall('.//subTags/item'):
        if 'PlaceObject' in (po.get('type') or '') and po.get('name'):
            assert po.get('name') in cur_markers[lv], "%s 出现未知挂点 %s" % (lv, po.get('name'))

# ---------- 写出 ----------
ET.ElementTree(tgt).write(OUT, encoding="utf-8", xml_declaration=True)
json.dump({
    "bodies": {lv: {"gh_sprite": tb, "src25_sprite": sb} for lv, tb, sb in BODIES},
    "fire_sound": {str(FIRE_SOUND_25): FIRE_SOUND_NEW},
    "anchor_map": {"110": "104"},
    "new_id_range": [maxid + 1, next_id - 1],
    "imported_defs": len(import_defs),
}, open("restore-manifest.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("saved", OUT, " 新 ID 区间: %d - %d  导入定义: %d" % (maxid + 1, next_id - 1, len(import_defs)))
