# -*- coding: utf-8 -*-
# 守望者家族（lightningBall）shootPoint 右移 30px（2026-09-09）
# 用户决策：五级 shootPoint 统一右移 30px（+600 twips），解决子弹出生点压住枪口火焰的问题
# 依据：开火模拟三档对比（Δ=0/+30/+45），用户选定 Δ=+30px——火焰完整可见、球状闪电在火焰右缘同步飞出
# 范围：仅 5 个本体时间轴内 name="shootPoint" 的放置矩阵 translateX；Y/basePoint/其余内容零改动
# 铁律：全程持有同一棵 ElementTree
import xml.etree.ElementTree as ET
import sys
sys.stdout.reconfigure(encoding='utf-8')

SHIFT = 600  # twips（30px × 20）
TARGETS = [(1, 1327), (2, 1323), (3, 1313), (4, 1307), (5, 1304)]

root = ET.parse('sub1130_base.xml').getroot()
sp = {}
for it in root.iter('item'):
    if it.get('type') == 'DefineSpriteTag':
        sp[int(it.get('spriteId'))] = it

for lv, cid in TARGETS:
    hit = 0
    old = new = None
    for ch in sp[cid].find('subTags'):
        if 'PlaceObject' in (ch.get('type') or '') and ch.get('name') == 'shootPoint':
            m = ch.find('matrix')
            old = int(m.get('translateX'))
            new = old + SHIFT
            m.set('translateX', str(new))
            hit += 1
    assert hit == 1, 'LV%d shootPoint 放置数异常: %d' % (lv, hit)
    print('LV%d: shootPoint translateX %s -> %s (+%d twips = +%.1fpx)' % (lv, old, new, SHIFT, SHIFT/20))

ET.indent(root)
ET.ElementTree(root).write('sub1130-shifted.xml', encoding='utf-8', xml_declaration=True)
print('写出: sub1130-shifted.xml')
