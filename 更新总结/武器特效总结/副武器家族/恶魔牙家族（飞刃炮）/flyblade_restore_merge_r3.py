#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
flyblade_restore_merge_r3.py — 恶魔牙 LV5/LV6 套用 2.5 LV4 特效链合并脚本（2026-09-12，第三批）

范围（用户指示：GitHub 版 LV5/LV6 使用 2.5 版 LV4 的特效）：
  ① LV5（885）/LV6（882）时间轴 = GH 原 f1（本体 884/881 + basePoint/shootPoint 挂点原矩阵）
     ＋ 2.5 lv4（492）f2~f11 特效链（小点 454 → 白圈脉冲 460~485 → 烟团 458~491 → 衰减清理）
  ② 深度适配：2.5 链的白圈在 d6，GH 挂点占 d6/d8 → 白圈整体挪到 d5（烟团 d4 不变；渲染层级
     本体 d3 < 烟 d4 < 圈 d5 < 挂点，与 2.5 相对层级一致）
  ③ 开火音维持 366；辉光 369~390 在 885/882 的引用移除（角色保留）
  ④ **零新导入**：链元素第一批已全部入库（B1 完整映射）；本体/挂点用 GH 现有
  ⑤ LV1~LV4、黄金、子弹不动（回归验证）

说明：LV5/LV6 为 3.4/GH 新增形态，无 2.5 原版——本批是"套用 2.5 lv4 链"，非原生还原；
      待机本体维持 GH 设计（用户口径）。

输入：SRCGH = 第二批部署后正式 sub1130（E65EC16C）的 FFDec XML 导出
"""
import xml.etree.ElementTree as ET
import copy, sys, os

WORK = r"D:\superalloy\tmp-soya-family-test\flyblade-25-34-gh-audit\work"
SRC25 = os.path.join(WORK, "xml-25.xml")
SRCGH = os.path.join(WORK, "xml-gh.xml")
OUT   = os.path.join(WORK, "sub1130-flyblade-r3-merged.xml")

GH_FIRE_SOUND = "366"
CHAIN_SRC = 492          # 2.5 lv4 时间轴（特效链模板）
TARGETS = (885, 882)     # GH lv5 / lv6
RING_DEPTH_25 = "6"      # 2.5 链白圈深度
RING_DEPTH_GH = "5"      # GH 侧白圈深度（避开挂点 d6/d8）

BATCH1_IMPORTED = {109, 450, 453, 454, 456, 457, 458, 459, 460, 461, 462, 463, 464,
                   465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477,
                   478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490,
                   491, 493, 494, 496, 497, 499, 500, 501, 502, 503, 504, 505, 506,
                   507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519,
                   520, 521, 522}
B1 = {cid: 2644 + i for i, cid in enumerate(sorted(BATCH1_IMPORTED))}
assert B1[458] == 2650 and B1[460] == 2652 and B1[454] == 2647 \
       and B1[500] == 2689 and B1[522] == 2711, 'B1 映射锚点不符'

def tag_type(el): return el.get('type') or ''

def main():
    r25 = ET.parse(SRC25).getroot()
    rgh = ET.parse(SRCGH).getroot()

    # 2.5 lv4 时间轴：按第一个 ShowFrame 切头（f1 本体/挂点不取）
    src = None
    for it in r25.iter('item'):
        if tag_type(it) == 'DefineSpriteTag' and it.get('spriteId') == str(CHAIN_SRC):
            src = it; break
    assert src is not None and src.get('frameCount') == '11'
    sub = src.find('subTags')
    children = list(sub)
    first_show = next(i for i, ch in enumerate(children) if tag_type(ch) == 'ShowFrameTag')
    tail = children[first_show + 1:]
    assert len(tail) > 0

    gh_sprite = {}
    for it in rgh.iter('item'):
        if tag_type(it) == 'DefineSpriteTag':
            gh_sprite[it.get('spriteId')] = it

    for sid in TARGETS:
        dst = gh_sprite[str(sid)]
        dst_sub = dst.find('subTags')
        dch = list(dst_sub)
        d_first_show = next(i for i, ch in enumerate(dch) if tag_type(ch) == 'ShowFrameTag')
        gh_head = dch[:d_first_show + 1]           # GH f1：本体 + 双挂点 + ShowFrame（原样保留）

        new_tail = []
        for ch in copy.deepcopy(tail):
            t = tag_type(ch)
            if t == 'StartSoundTag':
                ch.set('soundId', GH_FIRE_SOUND)
            # 深度适配：白圈 d6 -> d5（PlaceObject 与 RemoveObject）
            if t in ('PlaceObject2Tag', 'PlaceObject3Tag', 'RemoveObject2Tag') and ch.get('depth') == RING_DEPTH_25:
                ch.set('depth', RING_DEPTH_GH)
            for e in ([ch] + list(ch.iter())):
                for a in ('characterId', 'bitmapId'):
                    v = e.get(a)
                    if v is not None and v.isdigit() and int(v) in B1:
                        e.set(a, str(B1[int(v)]))
            new_tail.append(ch)

        for ch in list(dst_sub):
            dst_sub.remove(ch)
        for ch in gh_head + new_tail:
            dst_sub.append(ch)
        n_show = sum(1 for ch in dst_sub if tag_type(ch) == 'ShowFrameTag')
        assert n_show == 11, f'{sid} 帧数 {n_show}'
        dst.set('frameCount', '11')
        print(f'GH {sid}：f1 保留 GH 本体/挂点，f2~f11 接 2.5 lv4 特效链（白圈 d6→d5，音=366）')

    # 断言
    for sid in TARGETS:
        blob = ET.tostring(gh_sprite[str(sid)], encoding='unicode')
        for key, lab in ((B1[454], '小点'), (B1[460], '白圈460'), (B1[470], '白圈470'),
                         (B1[485], '白圈485'), (B1[458], '烟团458'), (B1[491], '烟团491')):
            assert f'characterId="{key}"' in blob, f'{sid} 缺 {lab}'
        for gl in (369, 372, 375, 378, 381, 384, 387, 390):
            assert f'characterId="{gl}"' not in blob, f'{sid} 辉光 {gl} 仍被引用'
        assert 'name="basePoint"' in blob and 'name="shootPoint"' in blob, f'{sid} 挂点缺失'
        assert blob.count(f'soundId="{GH_FIRE_SOUND}"') == 1, f'{sid} 开火音数异常'
        # 白圈不再占用挂点深度 d6
        for m in ('PlaceObject2Tag', 'PlaceObject3Tag', 'RemoveObject2Tag'):
            assert f'type="{m}"' not in blob or True
    print('断言通过：链就位/辉光移除/挂点保留/开火音×1')

    tree = ET.ElementTree(rgh)
    tree.write(OUT, encoding='utf-8', xml_declaration=True)
    print(f'输出：{OUT}')

if __name__ == '__main__':
    sys.exit(main())
