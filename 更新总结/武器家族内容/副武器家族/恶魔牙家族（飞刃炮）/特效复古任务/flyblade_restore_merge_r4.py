#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
flyblade_restore_merge_r4.py — 黄金恶魔牙/黄金撒旦之力 套用 2.5 恶魔牙/撒旦之力 特效链（2026-09-12，第五批）

范围（用户指示：2.5 恶魔牙特效→黄金恶魔牙、2.5 撒旦之力特效→黄金撒旦之力）：
  ① 黄金恶魔牙（391）：f1 保留 GH 金色本体＋挂点；f2~f11 接 2.5 恶魔牙 lv1（#523）链——
     四层电弧 520×4(blend8)＋枪口刀刃闪光 522＋白圈脉冲 460~485＋烟团 458~491
     **跳过 d1 本体换装（502）**：金色枪体不能闪成 2.5 红枪体；白圈序列深度 d2→d4（黄金本体占 d2）
  ② 黄金撒旦之力（399）：f1 保留；f2~f11 接 2.5 撒旦之力 lv2（#498）链（小点 454→白圈→烟团；
     深度 d4/d6 与黄金 d2 本体/d5 d7 挂点无冲突，不改）
  ③ 开火音维持 366；辉光 369~390 在 391/399 引用移除（定义保留——369~390 此后全库无引用，
     作为零风险孤儿资源暂不清理，留档待确认无他族引用后再议）
  ④ **零新导入**（复用第一批 68 项映射）；常规六形态、子弹、射速不动

输入：SRCGH = 第四批部署后正式 sub1130（75A54A3E）的 FFDec XML 导出
"""
import xml.etree.ElementTree as ET
import copy, sys, os

WORK = r"D:\superalloy\tmp-soya-family-test\flyblade-25-34-gh-audit\work"
SRC25 = os.path.join(WORK, "xml-25.xml")
SRCGH = os.path.join(WORK, "xml-gh.xml")
OUT   = os.path.join(WORK, "sub1130-flyblade-r4-merged.xml")

GH_FIRE_SOUND = "366"

BATCH1_IMPORTED = {109, 450, 453, 454, 456, 457, 458, 459, 460, 461, 462, 463, 464,
                   465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477,
                   478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490,
                   491, 493, 494, 496, 497, 499, 500, 501, 502, 503, 504, 505, 506,
                   507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519,
                   520, 521, 522}
B1 = {cid: 2644 + i for i, cid in enumerate(sorted(BATCH1_IMPORTED))}
assert B1[458] == 2650 and B1[460] == 2652 and B1[454] == 2647 \
       and B1[500] == 2689 and B1[522] == 2711, 'B1 映射锚点不符'

# 目标: (GH sprite, 2.5 链源, 深度改写规则, 是否剔除 d1 本体换装)
JOBS = [
    (391, 523, {'2': '4'}, True),    # 黄金恶魔牙 ← 2.5 恶魔牙（跳过本体换装；白圈 d2→d4）
    (399, 498, {},           False), # 黄金撒旦之力 ← 2.5 撒旦之力（深度不改）
]

def tag_type(el): return el.get('type') or ''

def main():
    r25 = ET.parse(SRC25).getroot()
    rgh = ET.parse(SRCGH).getroot()

    src25 = {}
    for it in r25.iter('item'):
        if tag_type(it) == 'DefineSpriteTag':
            src25[it.get('spriteId')] = it

    gh_sprite = {}
    for it in rgh.iter('item'):
        if tag_type(it) == 'DefineSpriteTag':
            gh_sprite[it.get('spriteId')] = it

    for sid, chain_src, depth_map, drop_body_swap in JOBS:
        src = src25[str(chain_src)]
        assert src.get('frameCount') == '11'
        children = list(src.find('subTags'))
        first_show = next(i for i, ch in enumerate(children) if tag_type(ch) == 'ShowFrameTag')
        tail = children[first_show + 1:]

        dst = gh_sprite[str(sid)]
        dst_sub = dst.find('subTags')
        dch = list(dst_sub)
        d_first = next(i for i, ch in enumerate(dch) if tag_type(ch) == 'ShowFrameTag')
        gh_head = dch[:d_first + 1]

        new_tail, dropped = [], 0
        for ch in copy.deepcopy(tail):
            t = tag_type(ch)
            if t == 'StartSoundTag':
                ch.set('soundId', GH_FIRE_SOUND)
            if t.startswith(('PlaceObject', 'RemoveObject')):
                dep = ch.get('depth')
                if drop_body_swap and t.startswith('PlaceObject') and dep == '1':
                    dropped += 1
                    continue                      # 跳过 2.5 本体换装（金色本体保留）
                if dep in depth_map:
                    ch.set('depth', depth_map[dep])
            for e in ([ch] + list(ch.iter())):
                for a in ('characterId', 'bitmapId'):
                    v = e.get(a)
                    if v is not None and v.isdigit() and int(v) in B1:
                        e.set(a, str(B1[int(v)]))
            new_tail.append(ch)
        if drop_body_swap:
            assert dropped == 1, f'本体换装剔除数异常 {dropped}'

        for ch in list(dst_sub):
            dst_sub.remove(ch)
        for ch in gh_head + new_tail:
            dst_sub.append(ch)
        n = sum(1 for ch in dst_sub if tag_type(ch) == 'ShowFrameTag')
        assert n == 11, f'{sid} 帧数 {n}'
        dst.set('frameCount', '11')
        print(f'GH {sid} ← 2.5 #{chain_src} 链（f1 保留金色本体/挂点；剔除本体换装 x{dropped}；音=366）')

    # 断言
    blob1 = ET.tostring(gh_sprite['391'], encoding='unicode')
    for key, lab in ((B1[520], '电弧'), (B1[522], '枪口刀刃闪光'), (B1[460], '白圈460'),
                     (B1[470], '白圈470'), (B1[485], '白圈485'), (B1[458], '烟团458')):
        assert f'characterId="{key}"' in blob1, f'391 缺 {lab}'
    assert f'characterId="{B1[502]}"' not in blob1, '391 不应含 2.5 换装本体 502'
    blob2 = ET.tostring(gh_sprite['399'], encoding='unicode')
    for key, lab in ((B1[454], '小点'), (B1[460], '白圈460'), (B1[485], '白圈485'),
                     (B1[458], '烟团458'), (B1[491], '烟团491')):
        assert f'characterId="{key}"' in blob2, f'399 缺 {lab}'
    for blob, sid in ((blob1, 391), (blob2, 399)):
        for gl in (369, 372, 375, 378, 381, 384, 387, 390):
            assert f'characterId="{gl}"' not in blob, f'{sid} 辉光 {gl} 仍被引用'
        assert 'name="basePoint"' in blob and 'name="shootPoint"' in blob, f'{sid} 挂点缺失'
        assert blob.count(f'soundId="{GH_FIRE_SOUND}"') == 1, f'{sid} 开火音数异常'
    print('断言通过：两级链就位/辉光移除/挂点保留/黄金本体未被换装')

    ET.ElementTree(rgh).write(OUT, encoding='utf-8', xml_declaration=True)
    print(f'输出：{OUT}')

if __name__ == '__main__':
    sys.exit(main())
