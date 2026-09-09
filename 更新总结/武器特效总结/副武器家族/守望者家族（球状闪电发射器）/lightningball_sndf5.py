# -*- coding: utf-8 -*-
# 守望者家族（lightningBall）开火音效起始帧 f3 → f5（2026-09-09）
# 用户决策：音效与枪口火焰出现帧（f5）对齐，消除"音效先响、火光后现"的脱节感
# 方案：五级本体时间轴的 StartSoundTag 从 f3 帧内容移至 f5 帧内容（音效数据/时长 1.924s 不变）
# 铁律：全程持有同一棵 ElementTree
import xml.etree.ElementTree as ET
import copy, sys
sys.stdout.reconfigure(encoding='utf-8')

TARGETS = [(1, 1327), (2, 1323), (3, 1313), (4, 1307), (5, 1304)]
SOUND_FRAME = 5   # 音效对齐到火焰首帧

root = ET.parse('sub1130_base2.xml').getroot()
sp = {}
for it in root.iter('item'):
    if it.get('type') == 'DefineSpriteTag':
        sp[int(it.get('spriteId'))] = it

for lv, cid in TARGETS:
    sub = sp[cid].find('subTags')
    # 1) 摘除现有 StartSound
    snd = None
    for ch in list(sub):
        if (ch.get('type') or '') == 'StartSoundTag':
            snd = copy.deepcopy(ch)
            sub.remove(ch)
    assert snd is not None, 'LV%d 未找到 StartSound' % lv
    # 2) 重新插入到第 SOUND_FRAME 帧的内容块（第 4 个 ShowFrame 之后）
    sf = 0
    inserted = False
    for idx, ch in enumerate(list(sub)):
        if (ch.get('type') or '') == 'ShowFrameTag':
            sf += 1
            if sf == SOUND_FRAME - 1:
                sub.insert(idx + 1, snd)
                inserted = True
                break
    assert inserted, 'LV%d 插入失败' % lv
    # 3) 复核帧位
    f = 0
    got = None
    for ch in sub:
        t = ch.get('type') or ''
        if t == 'ShowFrameTag': f += 1
        elif t == 'StartSoundTag': got = f + 1
    print('LV%d: 音效 f3 -> f%d' % (lv, got))
    assert got == SOUND_FRAME, 'LV%d 帧位错误: %s' % (lv, got)

ET.indent(root)
ET.ElementTree(root).write('sub1130-sndf5.xml', encoding='utf-8', xml_declaration=True)
print('写出: sub1130-sndf5.xml')
