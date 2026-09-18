#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
chipped_restore_merge.py — 碎裂炮家族（chipped）2.5 回迁合并脚本（2026-09-10）

范围（用户批准）：真实差异层全部回 2.5，attackType=boom 按用户决策保留。
  ① 本体 lv1~lv5 时间轴整段换 2.5 模板（蓄力发光层恢复；挂点 110→104 引用改绑）
  ② 开火音：克隆 2.5 音 562 为 sub1130 新 DefineSound，五级 StartSound 挂第 4 帧
     （2.5 原挂第 2 帧；按炽天使铁律 playOnce 的 gotoAndStop(2) 落点帧永不触发，惯例第 4 帧）
  ③ 受击/射速在配置 bin 内另行等长/变长替换（见 chipped_config_patch 部分输出），不在本脚本内

输入：FFDec swf2xml 导出的两份 XML（2.5 sub37 / 当前 sub1130）
输出：修改后的 sub1130 XML（再经 ffdec-cli xml2swf 重建 SWF）
"""
import xml.etree.ElementTree as ET
import copy, hashlib, sys, os

WORK = r"D:\superalloy\tmp-soya-family-test\chipped-25-gh-audit\work"
SRC25 = os.path.join(WORK, "sub37-25.xml")
SRCGH = os.path.join(WORK, "sub1130-gh.xml")
OUT   = os.path.join(WORK, "sub1130-chipped-merged.xml")

# 2.5 本体精灵：lv1~lv5
BODY25 = {630: 1002, 621: 999, 585: 996, 580: 993, 577: 990}   # 2.5 spriteId -> GH spriteId
MOUNT25 = 110          # 2.5 挂点精灵（basePoint/shootPoint 实例）
MOUNT_GH = 104         # 当前挂点精灵（复用，不导入）
FIRE_SOUND25 = "562"   # 2.5 开火音
SOUND_MOVE_FRAME = 4   # 铁律：挂第 4 帧

ET.register_namespace('', 'http://www.jpexs.de/xml/flash/')

def tag_type(el):
    return el.get('type') or ''

def load(path):
    return ET.parse(path).getroot()

def build_def_index(root):
    """characterID/shapeId/spriteId -> 定义元素"""
    idx = {}
    for it in root.iter('item'):
        t = tag_type(it)
        if not t.startswith('Define'):
            continue
        for attr in ('characterID', 'shapeId', 'spriteId'):
            v = it.get(attr)
            if v is not None:
                idx.setdefault(int(v), it)
                break
    return idx

def collect_refs(el, acc):
    """收集元素子树内引用的所有数字 id（characterId/bitmapId/soundId）"""
    for e in el.iter():
        for attr in ('characterId', 'bitmapId', 'soundId'):
            v = e.get(attr)
            if v is not None and v.isdigit():
                acc.add(int(v))

def closure(defs, roots):
    """从根定义递归收集完整依赖闭包（不含挂点 MOUNT25，另行改绑）"""
    seen = set()
    stack = list(roots)
    while stack:
        cid = stack.pop()
        if cid in seen or cid == MOUNT25:
            continue
        seen.add(cid)
        el = defs.get(cid)
        if el is None:
            print(f'  ⚠ 2.5 中找不到定义 id={cid}')
            continue
        refs = set()
        collect_refs(el, refs)
        for r in refs:
            if r in defs and r not in seen:
                stack.append(r)
    return seen

def max_char_id(root):
    m = 0
    for it in root.iter('item'):
        t = tag_type(it)
        if not t.startswith('Define'):
            continue
        for attr in ('characterID', 'shapeId', 'spriteId'):
            v = it.get(attr)
            if v is not None:
                m = max(m, int(v))
                break
    return m

def main():
    r25 = load(SRC25)
    rgh = load(SRCGH)
    defs25 = build_def_index(r25)

    # 1) 闭包收集（五级本体）
    bodies = sorted(BODY25.keys())
    closure_ids = closure(defs25, bodies)
    # 移除本体精灵自身（不重复导入，仅替换时间轴）与挂点
    import_ids = sorted(closure_ids - set(bodies) - {MOUNT25})
    print(f'2.5 闭包：本体 {bodies}，需导入定义 {len(import_ids)} 项：{import_ids}')

    # 2) GH 新 ID 分配
    next_id = max_char_id(rgh) + 1
    print(f'GH 当前最大 Character ID = {next_id - 1}，新 ID 从 {next_id} 起')

    idmap = {}     # 2.5 id -> GH 新 id
    for cid in import_ids:
        idmap[cid] = next_id
        next_id += 1
    new_sound_id = str(next_id)          # 开火音新 ID
    next_id += 1
    # 挂点映射
    remap = {MOUNT25: MOUNT_GH}
    remap.update({k: v for k, v in idmap.items() if isinstance(k, int)})

    # 3) 把 2.5 定义深拷贝进 GH 树：插到 <tags> 内最后一个根级 Define 标签之后（保持 SWF 标签顺序合法）
    tags = rgh.find('tags')
    assert tags is not None, '<tags> 容器缺失'
    last_def_idx = -1
    for idx, it in enumerate(list(tags)):
        if tag_type(it).startswith('Define'):
            last_def_idx = idx
    imported_count = 0
    insert_at = last_def_idx + 1
    for cid in import_ids:
        el = defs25[cid]
        ne = copy.deepcopy(el)
        # 改写定义自身 id
        for attr in ('characterID', 'shapeId', 'spriteId'):
            if ne.get(attr) is not None:
                ne.set(attr, str(remap[cid]))
                break
        # 改写子树引用
        for e in ne.iter():
            for attr in ('characterId', 'bitmapId', 'soundId'):
                v = e.get(attr)
                if v is not None and v.isdigit() and int(v) in remap:
                    e.set(attr, str(remap[int(v)]))
        tags.insert(insert_at, ne)
        insert_at += 1
        imported_count += 1
    print(f'已导入定义 {imported_count} 项，映射示例：'
          f'623→{remap.get(623)} 626→{remap.get(626)} 564→{remap.get(564)}')

    # 4) 导入开火音 DefineSound 562 -> new_sound_id
    sound_el = None
    for it in rgh.iter('item'):
        pass
    for it in r25.iter('item'):
        if tag_type(it) == 'DefineSoundTag' and it.get('soundId') == FIRE_SOUND25:
            sound_el = copy.deepcopy(it)
            break
    assert sound_el is not None, '2.5 音 562 未找到'
    sound_el.set('soundId', new_sound_id)
    # 紧跟导入定义之后插入（先于任何引用它的 sprite 时间轴使用处即可）
    tags.insert(insert_at, sound_el)
    print(f'开火音 562 → 新音 {new_sound_id}（MP3，内容逐字节保留）')

    # 5) 替换五级本体时间轴
    gh_sprite = {}
    for it in rgh.iter('item'):
        if tag_type(it) == 'DefineSpriteTag':
            gh_sprite[it.get('spriteId')] = it

    for b25, bgh in BODY25.items():
        src = defs25[b25]
        dst = gh_sprite[str(bgh)]
        fc = src.get('frameCount')
        assert fc == '15', f'2.5 body {b25} frameCount={fc}'
        src_sub = src.find('subTags')
        dst_sub = dst.find('subTags')
        assert src_sub is not None and dst_sub is not None, 'subTags 容器缺失'
        # 取 2.5 原生 StartSoundTag 作为模板（保留完整 soundInfo 子元素）
        orig_ss = None
        for ch0 in src_sub:
            if tag_type(ch0) == 'StartSoundTag':
                orig_ss = ch0
                break
        assert orig_ss is not None, f'2.5 body {b25} 无 StartSound'
        # 清空 dst 时间轴，深拷贝 2.5 时间轴
        for ch in list(dst_sub):
            dst_sub.remove(ch)
        frame = 1
        for ch in copy.deepcopy(list(src_sub)):
            t = tag_type(ch)
            # 2.5 原开火音（第2帧、音562）不搬——改挂第4帧、换新音
            if t == 'StartSoundTag':
                continue
            # 引用重映射
            for e in ([ch] + list(ch.iter())):
                for attr in ('characterId', 'bitmapId'):
                    v = e.get(attr)
                    if v is not None and v.isdigit() and int(v) in remap:
                        e.set(attr, str(remap[int(v)]))
            dst_sub.append(ch)
            if t == 'ShowFrameTag':
                frame += 1
                if frame == SOUND_MOVE_FRAME:
                    # 第 4 帧内容开头 = 第 3 个 ShowFrameTag 之后
                    ss = copy.deepcopy(orig_ss)
                    ss.set('soundId', new_sound_id)
                    idx_ch = list(dst_sub).index(ch)
                    dst_sub.insert(idx_ch + 1, ss)
        dst.set('frameCount', fc)
    print('五级本体时间轴已替换为 2.5 模板（挂点→104，开火音挂 f4）')

    # 6) 写出
    tree = ET.ElementTree(rgh)
    tree.write(OUT, encoding='utf-8', xml_declaration=True)
    # 内容断言
    txt = open(OUT, encoding='utf-8').read()
    assert f'soundId="{new_sound_id}"' in txt
    assert 'name="basePoint"' in txt and 'name="shootPoint"' in txt
    print(f'输出：{OUT}')
    print(f'新 ID 区间：{min(idmap.values())}-{max(idmap.values())} 共 {len(idmap)} 项定义＋音 {new_sound_id}')
    print('合并脚本完成。下一步：xml2swf 重建 + 回读断言。')

if __name__ == '__main__':
    sys.exit(main())
