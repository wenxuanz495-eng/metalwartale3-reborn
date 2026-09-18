#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
flyblade_restore_merge.py — 恶魔牙家族（flyBlade）LV1~LV3 2.5 回迁合并脚本（2026-09-12）

范围（用户批准）：
  ① LV1~LV3 本体时间轴整段换 2.5 模板（蓄力白圈脉冲＋电弧层＋枪口刀刃能量帧＋烟团恢复；
     LV1 含本体互换 #500→#502 与枪口 #522；挂点 110→104 引用改绑）
  ② 当前版共享辉光 369~390 在 LV1~LV3 上的引用随之消失（整段替换）；角色保留供 LV4~LV6/黄金
  ③ 开火音保持现状：StartSound soundId 维持 366（2.5 结构原 455 不导入）
  ④ 射速 attackGap/attackDelay 在配置 bin 内另行等长替换，不在本脚本内
  ⑤ LV4~LV6、黄金、子弹、受击不动

输入：FFDec swf2xml 导出的两份 XML（2.5 sub37 / 当前 sub1130）
输出：修改后的 sub1130 XML（再经 ffdec-cli xml2swf 重建 SWF）
"""
import xml.etree.ElementTree as ET
import copy, sys, os

WORK = r"D:\superalloy\tmp-soya-family-test\flyblade-25-34-gh-audit\work"
SRC25 = os.path.join(WORK, "xml-25.xml")
SRCGH = os.path.join(WORK, "xml-gh.xml")
OUT   = os.path.join(WORK, "sub1130-flyblade-merged.xml")

# 2.5 本体精灵 → GH 本体精灵（仅替换时间轴；GH Sprite ID/导出名/SymbolClass 不变）
BODY25 = {523: 897, 498: 894, 495: 891}
MOUNT25 = 110            # 2.5 挂点精灵 → GH 104（复用不导入）
GH_FIRE_SOUND = "366"    # 当前版开火音（维持现状）
DROP_SOUND25 = "455"     # 2.5 开火音不导入

def tag_type(el):
    return el.get('type') or ''

def load(path):
    return ET.parse(path).getroot()

def def_id(el):
    t = tag_type(el)
    if not t.startswith('Define'):
        return None
    for attr in ('characterID', 'shapeId', 'spriteId'):
        v = el.get(attr)
        if v is not None:
            return int(v)
    return None

def build_def_index(root):
    idx = {}
    for it in root.iter('item'):
        cid = def_id(it)
        if cid is not None:
            idx.setdefault(cid, it)
    return idx

def collect_refs(el, acc):
    for e in el.iter():
        for attr in ('characterId', 'bitmapId', 'soundId'):
            v = e.get(attr)
            if v is not None and v.isdigit():
                acc.add(int(v))

def closure(defs, roots):
    seen, stack = set(), list(roots)
    while stack:
        cid = stack.pop()
        if cid in seen:
            continue
        seen.add(cid)
        el = defs.get(cid)
        if el is None:
            print(f'  ⚠ 2.5 中找不到定义 id={cid}')
            continue
        refs = set()
        collect_refs(el, refs)
        stack.extend(r for r in refs if r in defs and r not in seen)
    return seen

def max_char_id(root):
    m = 0
    for it in root.iter('item'):
        cid = def_id(it)
        if cid is not None:
            m = max(m, cid)
    return m

def main():
    r25 = load(SRC25)
    rgh = load(SRCGH)
    defs25 = build_def_index(r25)

    # 1) 递归闭包收集：三个 2.5 本体时间轴的完整依赖（含位图/精灵内部形状）
    body_ids = sorted(BODY25.keys())
    closure_ids = closure(defs25, body_ids)
    import_ids = sorted(closure_ids - set(body_ids) - {MOUNT25} - {int(DROP_SOUND25)})
    print(f'2.5 本体 {body_ids} 递归闭包 {len(closure_ids)} 项，需导入定义 {len(import_ids)} 项')
    print('  导入清单:', import_ids)

    # 2) GH 新 ID 分配
    next_id = max_char_id(rgh) + 1
    print(f'GH 当前最大 Character ID = {next_id - 1}，新 ID 从 {next_id} 起')
    idmap = {cid: next_id + i for i, cid in enumerate(import_ids)}
    remap = {MOUNT25: 104}
    remap.update(idmap)

    # 3) 按 2.5 文件原始顺序拷贝导入定义，插到 GH 最早目标精灵（891）之前
    tags = rgh.find('tags')
    assert tags is not None, '<tags> 容器缺失'
    children = list(tags)
    first_target = min(children.index(next(it for it in children if (it.get('spriteId') == str(v))))
                       for v in BODY25.values())
    print(f'导入插入点：tag 位置 {first_target}（目标精灵 891/894/897 之前）')

    imported = 0
    inserts = []
    for it in r25.find('tags'):  # 遍历 2.5 的 tags 作为拷贝源（保持先定义后引用顺序）
        cid = def_id(it)
        if cid in idmap:
            inserts.append((cid, it))
    for cid, el in inserts:
        ne = copy.deepcopy(el)
        for attr in ('characterID', 'shapeId', 'spriteId'):
            if ne.get(attr) is not None:
                ne.set(attr, str(idmap[cid]))
                break
        for e in ne.iter():
            for attr in ('characterId', 'bitmapId', 'soundId'):
                v = e.get(attr)
                if v is not None and v.isdigit() and int(v) in remap:
                    e.set(attr, str(remap[int(v)]))
        tags.insert(first_target, ne)
        first_target += 1
        imported += 1
    assert imported == len(import_ids), f'导入数不符 {imported} != {len(import_ids)}'
    print(f'已导入定义 {imported} 项；示例映射：500→{idmap.get(500)} 502→{idmap.get(502)} '
          f'460→{idmap.get(460)} 470→{idmap.get(470)} 520→{idmap.get(520)} 522→{idmap.get(522)} 454→{idmap.get(454)}')

    # 4) 替换三级本体时间轴
    gh_sprite = {}
    for it in rgh.iter('item'):
        if tag_type(it) == 'DefineSpriteTag':
            gh_sprite[it.get('spriteId')] = it

    for b25, bgh in BODY25.items():
        src = defs25[b25]
        dst = gh_sprite[str(bgh)]
        fc = src.get('frameCount')
        assert fc == '11', f'2.5 body {b25} frameCount={fc}'
        src_sub = src.find('subTags')
        dst_sub = dst.find('subTags')
        assert src_sub is not None and dst_sub is not None
        for ch in list(dst_sub):
            dst_sub.remove(ch)
        for ch in copy.deepcopy(list(src_sub)):
            t = tag_type(ch)
            # 开火音：结构位置保持（f2），soundId 换当前版 366
            if t == 'StartSoundTag':
                ch.set('soundId', GH_FIRE_SOUND)
            for e in ([ch] + list(ch.iter())):
                for attr in ('characterId', 'bitmapId', 'soundId'):
                    v = e.get(attr)
                    if v is not None and v.isdigit() and int(v) in remap:
                        e.set(attr, str(remap[int(v)]))
            if t == 'StartSoundTag':
                ch.set('soundId', GH_FIRE_SOUND)
            dst_sub.append(ch)
        dst.set('frameCount', fc)
    print('三级本体时间轴已替换为 2.5 模板（挂点→104，开火音=366 维持现状）')

    # 5) 断言
    txt_parts = []
    for it in rgh.iter('item'):
        if tag_type(it) == 'DefineSpriteTag' and it.get('spriteId') in ('897', '894', '891'):
            txt_parts.append(ET.tostring(it, encoding='unicode'))
    blob = ''.join(txt_parts)
    assert 'name="basePoint"' in blob and 'name="shootPoint"' in blob, '挂点缺失'
    assert f'soundId="{GH_FIRE_SOUND}"' in blob, '开火音缺失'
    for gl in (369, 372, 375, 378, 381, 384, 387, 390):
        assert f'characterId="{gl}"' not in blob, f'GH 辉光 {gl} 仍被 LV1~3 引用'
    assert f'characterId="{idmap[470]}"' in blob, '白圈峰值未引用'
    assert f'characterId="{idmap[520]}"' in blob, '电弧层未引用'
    assert f'characterId="{idmap[454]}"' in blob, 'LV2/3 小点未引用'
    print('断言通过：挂点/开火音/白圈/电弧/小点就位，GH 辉光在 LV1~3 已无引用')

    # 6) 写出
    tree = ET.ElementTree(rgh)
    tree.write(OUT, encoding='utf-8', xml_declaration=True)
    print(f'输出：{OUT}')
    print(f'新 ID 区间：{min(idmap.values())}-{max(idmap.values())} 共 {len(idmap)} 项定义')
    print('合并脚本完成。下一步：xml2swf 重建 + 回读断言 + 渲染对比。')

if __name__ == '__main__':
    sys.exit(main())
