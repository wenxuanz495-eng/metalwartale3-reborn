#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
flyblade_chain_reanchor_r5.py — 恶魔牙“保本体换链”四级特效错位几何重锚（2026-09-12，第六批）

问题（用户实机报告）：黄金撒旦之力特效悬在枪体上方 ~27px；同类错位在 20260905 黄金实验与
demon-offset-fix2（测试包盲试统一+480twips）中反复出现。

根因（几何实测）：套链时保留的 GH 本体形状，其图形相对"原点"的位置与 2.5 链源本体不同；
链坐标按 2.5 本体几何调校，原样照搬即整体错位。逐级差值（GH本体原点 − 2.5链源本体原点）：

  目标            GH本体   原点(px)   2.5链源本体        原点(px)   链平移增量(twips)
  黄金恶魔牙 391   365     (4,27)     500 恶魔牙        (-1,23)    (+88, +79)
  黄金撒旦之力 399 398     (4,27)     497 撒旦之力       (0,0)      (+90,+542)
  灭世之手 885     884     (-9,-5)    452 深渊之刃       (-8,-2)    (-30, -51)
  诸神之殁 882     881     (0,0)      452 深渊之刃       (-8,-2)    (+150,+40)

做法：对四级 sprite 的 f2~f11（首个 ShowFrame 之后）全部 PlaceObject 矩阵加平移增量；
f1 本体/挂点不动；LV1~LV4 原生还原（本体+链同源）无此问题、不动。
"""
import xml.etree.ElementTree as ET
import sys, os

WORK = r"D:\superalloy\tmp-soya-family-test\flyblade-25-34-gh-audit\work"
SRCGH = os.path.join(WORK, "xml-gh.xml")   # 部署版 BA9D8CFE 的导出
OUT   = os.path.join(WORK, "sub1130-flyblade-r5-merged.xml")

# sprite -> (dx, dy) twips
DELTAS = {391: (88, 79), 399: (90, 542), 885: (-30, -51), 882: (150, 40)}

def tag_type(el): return el.get('type') or ''

def main():
    rgh = ET.parse(SRCGH).getroot()
    gh_sprite = {}
    for it in rgh.iter('item'):
        if tag_type(it) == 'DefineSpriteTag':
            gh_sprite[it.get('spriteId')] = it

    total = 0
    for sid, (dx, dy) in DELTAS.items():
        dst = gh_sprite[str(sid)]
        sub = dst.find('subTags')
        ch = list(sub)
        first = next(i for i, c in enumerate(ch) if tag_type(c) == 'ShowFrameTag')
        n = 0
        for c in ch[first + 1:]:
            if tag_type(c).startswith('PlaceObject'):
                m = c.find('matrix')
                if m is not None:
                    m.set('translateX', str(int(m.get('translateX', '0')) + dx))
                    m.set('translateY', str(int(m.get('translateY', '0')) + dy))
                    n += 1
        print(f'GH {sid}: f2~f11 平移 {n} 个 PlaceObject 矩阵 +({dx},{dy}) twips')
        total += n
    assert total > 0

    ET.ElementTree(rgh).write(OUT, encoding='utf-8', xml_declaration=True)
    print(f'输出：{OUT}（共 {total} 处）')

if __name__ == '__main__':
    sys.exit(main())
