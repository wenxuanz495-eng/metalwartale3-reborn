# -*- coding: utf-8 -*-
# 守望者家族（lightningBall）两项丢失改动重放恢复脚本（2026-09-15）
# 事故：2026-09-10 014dc62（炽天使导入）使用 09-09 23:22 的陈旧底稿 sub_GH.xml，
#       静默回退了 09-09 深夜已建库的 shootPoint+30px ×5 与开火音效 f3→f5 ×5。
# 本脚本：在当前底稿（16B97C0D，新鲜转储并断言 manifest）上重放两项改动，
#         参照基准 = 最后完好态 c46fe23 的 sub1130（8D885B69）。
# 铁律（本次事故沉淀）：TGT 底稿必须合并前现转储，并断言来源 SWF 哈希 == manifest 当前值。
# 禁区：除五级本体时间轴的 5 处挂点矩阵 + 5 处 StartSound 帧位外，零改动。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT_SWF = "fresh_cur.swf"          # 当前底稿（已断言 == manifest）
GOOD_XML = "chk_c46fe23.xml"       # 最后完好态（8D885B69）转储，只读参照
OUT_XML = "sub1130-restored.xml"
OUT_SWF = "sub1130-restored.swf"
FFDEC = r"..\tools\packaging\ffdec\ffdec-cli.exe"

BODIES = {  # spriteId -> (级别, 期望旧 translateX, 期望新 translateX)
    '1327': ('LV1', '1032', '1632'),
    '1323': ('LV2', '1400', '2000'),
    '1313': ('LV3', '1688', '2288'),
    '1307': ('LV4', '2042', '2642'),
    '1304': ('LV5', '2042', '2642'),
}

def sprites_of(root):
    return {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}

def walk_frames(sub):
    """按 1-based 帧号遍历，产出 (帧号, tag)"""
    frame = 1
    for tag in sub:
        t = tag.get('type') or ''
        if t == 'ShowFrameTag':
            frame += 1
            continue
        yield frame, tag

good = ET.parse(GOOD_XML).getroot()
tgt = ET.parse('fresh_cur.xml').getroot()
gs, ts = sprites_of(good), sprites_of(tgt)

# ---------- 提取完好态五级挂点矩阵（整体拷贝，含 nTranslateBits） ----------
good_mats = {}
for sid, (lv, old, new) in BODIES.items():
    for f, po in walk_frames(gs[sid].find('subTags')):
        if 'PlaceObject' in (po.get('type') or '') and po.get('name') == 'shootPoint':
            m = po.find('matrix')
            assert m is not None and m.get('translateX') == new, f"完好态 {lv} shootPoint 期望 tx={new}，实测 {m.get('translateX') if m is not None else None}"
            good_mats[sid] = copy.deepcopy(m)
assert len(good_mats) == 5
print("完好态五级 shootPoint 矩阵已提取（tx:", {lv: good_mats[sid].get('translateX') for sid, (lv, _, _) in BODIES.items()}, "）")

# ---------- 重放：矩阵替换 + StartSound 移帧 ----------
moved = replaced = 0
for sid, (lv, old, new) in BODIES.items():
    sub = ts[sid].find('subTags')
    # 1) shootPoint 矩阵整体替换
    hit = 0
    for f, po in walk_frames(sub):
        if 'PlaceObject' in (po.get('type') or '') and po.get('name') == 'shootPoint':
            m = po.find('matrix')
            assert m is not None and m.get('translateX') == old, f"{lv} 当前 shootPoint 期望 tx={old}，实测 {m.get('translateX')}"
            idx = list(po).index(m)
            po.remove(m)
            po.insert(idx, copy.deepcopy(good_mats[sid]))
            hit += 1
    assert hit == 1, f"{lv} shootPoint 放置数异常: {hit}"
    replaced += hit
    # 2) StartSound f3 -> f5（移到第 5 帧内容首位 = 第 4 个 ShowFrameTag 之后）
    children = list(sub)
    snd_idx = snd_frame = show_count = None
    for i, tag in enumerate(children):
        t = tag.get('type') or ''
        if t == 'ShowFrameTag':
            show_count = i
        elif 'StartSound' in t:
            snd_idx, snd_frame = i, sum(1 for x in children[:i] if (x.get('type') or '') == 'ShowFrameTag') + 1
    assert snd_idx is not None and snd_frame == 3, f"{lv} StartSound 期望 f3，实测 f{snd_frame}"
    snd = children[snd_idx]
    sub.remove(snd)
    # 找第 4 个 ShowFrameTag 的位置，插到它后面
    seen = 0
    for i, tag in enumerate(sub):
        if (tag.get('type') or '') == 'ShowFrameTag':
            seen += 1
            if seen == 4:
                sub.insert(i + 1, snd)
                break
    assert seen >= 4, f"{lv} ShowFrameTag 不足"
    moved += 1
    print(f"{lv}: shootPoint tx {old}->{good_mats[sid].get('translateX')}  StartSound f3->f5")
print(f"共替换矩阵 {replaced} 处，移帧 {moved} 处")

# ---------- 写出并回读 ----------
ET.indent(tgt)
ET.ElementTree(tgt).write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest()
print("写出:", OUT_SWF, " sha256:", new_hash.upper()[:8])

# 回读：再转储一次做全套断言
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, "readback.xml"], capture_output=True, text=True)
assert r.returncode == 0
rb = ET.parse("readback.xml").getroot()
rbs = sprites_of(rb)

def norm_sig(sp):
    """本体时间轴完整结构签名（不归一化——重放后应与完好态全等）"""
    sig = []
    frame = 1
    for tag in sp.find('subTags'):
        t = tag.get('type') or ''
        if t == 'ShowFrameTag':
            frame += 1
            sig.append(f"F{frame}")
            continue
        mt = tag.find('matrix')
        ct = tag.find('colorTransform')
        fl = tag.find('surfaceFilterList')
        sig.append("|".join([
            f"f{frame}", t,
            str(sorted((k, v) for k, v in tag.attrib.items() if k != 'forceWriteAsLong')),
            ET.tostring(mt, encoding='unicode') if mt is not None else '',
            ET.tostring(ct, encoding='unicode') if ct is not None else '',
            ET.tostring(fl, encoding='unicode') if fl is not None else '',
        ]))
    return sig

print("\n=== 回读断言 ===")
ok = True
for sid, (lv, old, new) in BODIES.items():
    a, b = norm_sig(gs[sid]), norm_sig(rbs[sid])
    same = a == b
    ok &= same
    print(f"  {lv} 本体时间轴 vs 完好态(8D885B69): {'全等 PASS' if same else '有差异 FAIL'}")
    if not same:
        for i, (x, y) in enumerate(zip(a, b)):
            if x != y:
                print("    差异行", i, "\n     GOOD:", x[:160], "\n     NEW :", y[:160])
# 其余精灵零变化（与当前底稿逐字节比）
cur0 = sprites_of(ET.parse('fresh_cur.xml').getroot())
diff_sprites = []
for sid in cur0:
    if sid in BODIES:
        continue
    a = ET.tostring(cur0[sid].find('subTags'), encoding='unicode')
    b = ET.tostring(rbs[sid].find('subTags'), encoding='unicode')
    if a != b:
        diff_sprites.append(sid)
print(f"  其余 {len(cur0)-5} 个精灵 vs 当前底稿: {'零变化 PASS' if not diff_sprites else '变化 FAIL ' + str(diff_sprites)}")
ok &= not diff_sprites
# SymbolClass 与帧数
names_cur = [n.text for it in ET.parse('fresh_cur.xml').getroot().iter('item') if it.get('type') == 'SymbolClassTag' for n in it.find('names')]
names_new = [n.text for it in rb.iter('item') if it.get('type') == 'SymbolClassTag' for n in it.find('names')]
print(f"  SymbolClass names: {'原样 PASS' if names_cur == names_new else 'FAIL'}")
ok &= names_cur == names_new
assert ok, "回读断言存在 FAIL"
print("\n全部断言 PASS，新 sub1130 =", OUT_SWF)
