#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
flyblade_restore_merge_r2.py — 恶魔牙家族（flyBlade）LV4 蓄力/枪口火焰 2.5 回迁合并脚本（2026-09-12，第二批·修订版）

范围（用户批准，2026-09-12 修订）：**仅 LV4（深渊之刃）2.5 原生还原**；LV5/LV6 按用户指示不做。
  ① LV4（888）时间轴整段换 2.5 lv4（#492）模板：小点 454 → 白圈 460~485 → 烟团 458~491
  ② 共用链复用第一批导入；本批仅补导 LV4 本体 452 及其位图 451（450 已在第一批导入）
  ③ 射速配置不动（lv4 attackGap 维持 1.4/0.1——用户未要求，待决策）；开火音维持 366
  ④ LV1~LV3、LV5/LV6、黄金、子弹全部不动（回归验证）

⚠ 修订说明（过程勘误，2026-09-12）：
  本脚本首版 B1 映射表由"重建第一批闭包"推算，漏了 109/450/453 三个 ID，导致整体偏移
  （推算 458→2649/460→2651；真实为 458→2650/460→2652——以第一批部署文件时间轴实测为准），
  LV4 因此引用了错误的内部形状（渲染差 615~3620 像素）。本版映射以部署产物逐条核对。

输入：SRCGH = 第一批部署后正式 sub1130 的 FFDec XML 导出
"""
import xml.etree.ElementTree as ET
import copy, sys, os

WORK = r"D:\superalloy\tmp-soya-family-test\flyblade-25-34-gh-audit\work"
SRC25 = os.path.join(WORK, "xml-25.xml")
SRCGH = os.path.join(WORK, "xml-gh.xml")
OUT   = os.path.join(WORK, "sub1130-flyblade-r2-merged.xml")

MOUNT25, MOUNT_GH = 110, 104
GH_FIRE_SOUND = "366"

# 第一批全部 68 项已导入 ID（运行期打印留档；按排序连续分配 2644 起）
BATCH1_IMPORTED = {109, 450, 453, 454, 456, 457, 458, 459, 460, 461, 462, 463, 464,
                   465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477,
                   478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490,
                   491, 493, 494, 496, 497, 499, 500, 501, 502, 503, 504, 505, 506,
                   507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519,
                   520, 521, 522}
# 第一批完整映射（2.5 id -> GH 新 id；sorted 连续分配——含位图 450→2645 等内部依赖）
B1 = {cid: 2644 + i for i, cid in enumerate(sorted(BATCH1_IMPORTED))}
# 抽查锚点（部署产物核对）：458→2650 460→2652 454→2647 500→2689 522→2711
assert B1[458] == 2650 and B1[460] == 2652 and B1[454] == 2647 \
       and B1[500] == 2689 and B1[522] == 2711, 'B1 映射锚点不符'

BODY_RESTORE = {492: 888}

def tag_type(el): return el.get('type') or ''

def def_id(el):
    if not tag_type(el).startswith('Define'): return None
    for a in ('characterID','shapeId','spriteId'):
        v = el.get(a)
        if v is not None: return int(v)
    return None

def build_def_index(root):
    idx = {}
    for it in root.iter('item'):
        cid = def_id(it)
        if cid is not None: idx.setdefault(cid, it)
    return idx

def collect_refs(el, acc):
    for e in el.iter():
        for a in ('characterId','bitmapId','soundId'):
            v = e.get(a)
            if v is not None and v.isdigit(): acc.add(int(v))

def max_char_id(root):
    return max((c for c in (def_id(it) for it in root.iter('item')) if c), default=0)

def main():
    r25 = ET.parse(SRC25).getroot()
    rgh = ET.parse(SRCGH).getroot()
    defs25 = build_def_index(r25)

    # ===== 1) LV4 闭包，排除第一批已导入 → 仅 451/452 =====
    seen, stack = set(), [492]
    while stack:
        cid = stack.pop()
        if cid in seen or cid in (MOUNT25, 455): continue
        seen.add(cid)
        el = defs25.get(cid)
        if el is None:
            print(f'  ⚠ 2.5 缺定义 {cid}'); continue
        refs = set(); collect_refs(el, refs)
        stack.extend(x for x in refs if x in defs25 and x not in seen)
    need = sorted(c for c in seen if c != 492 and c not in BATCH1_IMPORTED)
    print(f'LV4 闭包 {len(seen)} 项；需新导入 {len(need)} 项：{need}')
    assert need == [451, 452], f'need 异常: {need}'

    next_id = max_char_id(rgh) + 1
    print(f'GH 最大 Character ID = {next_id-1}，新 ID 从 {next_id} 起')
    idmap = {cid: next_id + i for i, cid in enumerate(need)}
    remap = {MOUNT25: MOUNT_GH}
    remap.update(B1); remap.update(idmap)

    # ===== 2) 导入新定义（插到 888 定义之前） =====
    tags = rgh.find('tags')
    children = list(tags)
    insert_at = children.index(next(it for it in children if it.get('spriteId') == '888'))
    imported = 0
    for it in r25.find('tags'):
        cid = def_id(it)
        if cid in idmap:
            ne = copy.deepcopy(it)
            for a in ('characterID','shapeId','spriteId'):
                if ne.get(a) is not None:
                    ne.set(a, str(idmap[cid])); break
            for e in ne.iter():
                for a in ('characterId','bitmapId','soundId'):
                    v = e.get(a)
                    if v is not None and v.isdigit() and int(v) in remap:
                        e.set(a, str(remap[int(v)]))
            tags.insert(insert_at, ne)
            insert_at += 1
            imported += 1
    assert imported == len(idmap), f'{imported}!={len(idmap)}'
    print(f'已导入 {imported} 项：451→{idmap[451]} 452→{idmap[452]}')

    # ===== 3) LV4 时间轴整段替换 =====
    gh_sprite = {}
    for it in rgh.iter('item'):
        if tag_type(it) == 'DefineSpriteTag':
            gh_sprite[it.get('spriteId')] = it
    src = defs25[492]
    dst = gh_sprite['888']
    assert src.get('frameCount') == '11'
    src_sub, dst_sub = src.find('subTags'), dst.find('subTags')
    for ch in list(dst_sub): dst_sub.remove(ch)
    for ch in copy.deepcopy(list(src_sub)):
        if tag_type(ch) == 'StartSoundTag':
            ch.set('soundId', GH_FIRE_SOUND)
        for e in ([ch] + list(ch.iter())):
            for a in ('characterId','bitmapId','soundId'):
                v = e.get(a)
                if v is not None and v.isdigit() and int(v) in remap:
                    e.set(a, str(remap[int(v)]))
        dst_sub.append(ch)
    dst.set('frameCount', '11')
    print('LV4(888) 时间轴已替换为 2.5 lv4 模板')

    # ===== 4) 断言 =====
    blob888 = ET.tostring(gh_sprite['888'], encoding='unicode')
    for key, lab in ((idmap[452], '本体452'), (B1[454], '小点454'), (B1[460], '白圈460'),
                     (B1[470], '白圈470'), (B1[485], '白圈485'), (B1[458], '烟团458'),
                     (B1[491], '烟团491')):
        assert f'characterId="{key}"' in blob888, f'{lab} 未引用'
    for gl in (369, 372, 375, 378, 381, 384, 387, 390):
        assert f'characterId="{gl}"' not in blob888, f'辉光 {gl} 仍被 888 引用'
    assert 'name="basePoint"' in blob888 and 'name="shootPoint"' in blob888
    assert blob888.count(f'soundId="{GH_FIRE_SOUND}"') == 1
    # LV5/LV6 保持原样（仍含辉光 369~390）
    for sid in ('885', '882'):
        b = ET.tostring(gh_sprite[sid], encoding='unicode')
        assert 'characterId="369"' in b and 'characterId="390"' in b, f'{sid} 辉光被动'
    print('断言通过：LV4 链就位/辉光移除仅限 888/挂点/开火音；LV5/LV6 未动')

    tree = ET.ElementTree(rgh)
    tree.write(OUT, encoding='utf-8', xml_declaration=True)
    print(f'输出：{OUT}')

if __name__ == '__main__':
    sys.exit(main())
