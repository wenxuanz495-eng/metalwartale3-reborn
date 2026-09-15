# -*- coding: utf-8 -*-
# 黄金恶魔牙 LV3~LV6 挂点弹移除（20260916，画师裁定：364 位图贴合失败差距过大，画师另画新尖）
# 手术内容：
#   1) 四条时间轴 2774~2777 中删除挂点弹放置（PlaceObject2 characterId=2773, depth=1，各 1 处）
#   2) 删除孤儿定义：DefineBitsLossless2 2772 + DefineShape 2773
# 安全断言：底稿哈希、全库引用枚举（删前/删后）、枪体 d2 不动、SpriteClass 257 项不变
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT = r"..\swf\sub1130.swf"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
FFDEC = r"..\tools\packaging\ffdec\ffdec-cli.exe"
IN_XML = "cur.xml"
OUT_XML = "sub1130-nobullet.xml"
OUT_SWF = "sub1130-nobullet.swf"
BULLET_BMP, BULLET_SHAPE = '2772', '2773'
SPRITES = ['2774', '2775', '2776', '2777']
REF_ATTRS = ('characterId', 'shapeId', 'bitmapId', 'spriteId', 'characterID', 'bitmapIdRef')

# ---------- 0. 底稿哈希断言 ----------
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper(), f"底稿 {actual} != manifest {manifest_line}"
print("底稿哈希断言 PASS:", actual[:8])

tree = ET.parse(IN_XML); root = tree.getroot()

def scan_refs():
    """枚举全库对 2772/2773 的引用 -> {(attr,value): [描述]}"""
    out = {BULLET_BMP: [], BULLET_SHAPE: []}
    for it in root.iter('item'):
        for k in REF_ATTRS:
            v = it.get(k)
            if v in (BULLET_BMP, BULLET_SHAPE):
                out[v].append((k, it.get('type'), it.get('shapeId') or it.get('characterID') or it.get('spriteId') or '?'))
    return out

before = scan_refs()
print("删前引用枚举:")
for v, refs in before.items():
    for r in refs:
        print("  ", v, r)
# 断言：2773 = 定义1 + 放置4 = 5 项；2772 = 定义1 + 2773形状内FILLSTYLE 1 = 2 项
assert len(before[BULLET_SHAPE]) == 5, before[BULLET_SHAPE]
assert len(before[BULLET_BMP]) == 2, before[BULLET_BMP]
places = [r for r in before[BULLET_SHAPE] if r[0] == 'characterId']
assert len(places) == 4, places

# ---------- 1. 删除四条时间轴中的挂点弹放置 ----------
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
removed_places = 0
for sid in SPRITES:
    sub = sprites[sid].find('subTags')
    hits = [t for t in sub if (t.get('type') or '') == 'PlaceObject2Tag'
            and t.get('characterId') == BULLET_SHAPE]
    assert len(hits) == 1, (sid, len(hits))
    for t in hits:
        assert t.get('depth') == '1', (sid, t.get('depth'))
        sub.remove(t)
        removed_places += 1
    # 枪体 d2 必须仍在
    assert any((t.get('type') or '') == 'PlaceObject2Tag' and t.get('depth') == '2' for t in sub), sid
print("已删放置:", removed_places, "处（每条时间轴 d1）")

# ---------- 2. 删除孤儿定义 ----------
parent_map = {c: p for p in root.iter() for c in p}
removed_defs = 0
for it in list(root.iter('item')):
    if (it.get('type') in ('DefineBitsLossless2Tag',) and it.get('characterID') == BULLET_BMP) \
       or (it.get('type') == 'DefineShapeTag' and it.get('shapeId') == BULLET_SHAPE):
        parent_map[it].remove(it)
        removed_defs += 1
assert removed_defs == 2, removed_defs
print("已删定义:", removed_defs, "项（2772/2773）")

# ---------- 3. 删后引用归零断言 ----------
after = scan_refs()
for v in (BULLET_BMP, BULLET_SHAPE):
    assert not after[v], (v, after[v])
print("删后引用扫描: 2772/2773 全库归零 PASS")

# SymbolClass 项数不变（257）
sc = next(it for it in root.iter('item') if (it.get('type') or '') == 'SymbolClassTag')
assert len(sc.find('tags')) == 257, len(sc.find('tags'))
print("SymbolClass 257 项不变 PASS")

# ---------- 4. 写出 ----------
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
h = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
print("写出:", OUT_SWF, h[:8])
