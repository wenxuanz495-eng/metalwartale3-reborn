#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
snake_sound_merge.py — 纳米号家族（snake）开火音回迁合并脚本（2026-09-10）

用户批准范围：开火音**仅银蛇狂舞（snake_lv1）回 2.5**，金蛇狂舞（snake_lv2）保留当前音 198。
  ① 克隆 2.5 音 147（MP3 3512B，ea60de79554c）为 sub1130 新 DefineSound（内容逐字节保留）
  ② snake_lv1(591) StartSound 音 198→新 ID（挂帧 f6 不变；f6 非第 2 帧，无 playOnce 铁律问题）
  ③ snake_lv2(603) 不动（继续用音 198）
"""
import xml.etree.ElementTree as ET
import copy, hashlib, os, sys

WORK = r"D:\superalloy\tmp-soya-family-test\snake-3ver-audit\work"
SRC25 = os.path.join(WORK, "sub37-25.xml")
SRCGH = os.path.join(WORK, "sub1130-gh.xml")
OUT   = os.path.join(WORK, "sub1130-snake-merged.xml")

SNAKE_LV1_GH = "591"
FIRE_SOUND25 = "147"   # 2.5 开火音

def main():
    r25 = ET.parse(SRC25).getroot()
    rgh = ET.parse(SRCGH).getroot()

    # GH 当前最大 ID
    m = 0
    for it in rgh.iter('item'):
        t = it.get('type') or ''
        if t.startswith('Define'):
            for attr in ('characterID', 'shapeId', 'spriteId', 'soundId'):
                v = it.get(attr)
                if v is not None:
                    m = max(m, int(v)); break
    new_sound_id = str(m + 1)
    print(f'GH 当前最大 ID = {m}，新音 ID = {new_sound_id}')

    # 克隆 2.5 音 147
    snd = None
    for it in r25.iter('item'):
        if it.get('type') == 'DefineSoundTag' and it.get('soundId') == FIRE_SOUND25:
            snd = copy.deepcopy(it); break
    assert snd is not None, '2.5 音 147 未找到'
    d = snd.get('soundData') or ''
    print(f'2.5 音147 内容哈希 {hashlib.md5(bytes.fromhex(d)).hexdigest()[:12]}（{len(d)//2}B），克隆为 {new_sound_id}')
    snd.set('soundId', new_sound_id)

    # 插到 <tags> 内最后一个 Define 标签之后
    tags = rgh.find('tags')
    assert tags is not None
    last = max(i for i, it in enumerate(list(tags)) if (it.get('type') or '').startswith('Define'))
    tags.insert(last + 1, snd)

    # 银蛇 lv1(591) StartSound 改绑（位置/帧不动）
    hit = 0
    for it in rgh.iter('item'):
        if it.get('type') == 'DefineSpriteTag' and it.get('spriteId') == SNAKE_LV1_GH:
            for c in it.iter('item'):
                if c.get('type') == 'StartSoundTag' and c.get('soundId') == '198':
                    c.set('soundId', new_sound_id)
                    hit += 1
    assert hit == 1, f'lv1 StartSound 改绑 {hit} 处（期望 1）'
    # 金蛇 603 保持 198 断言
    for it in rgh.iter('item'):
        if it.get('type') == 'DefineSpriteTag' and it.get('spriteId') == '603':
            ss = [c.get('soundId') for c in it.iter('item') if c.get('type') == 'StartSoundTag']
            assert ss == ['198'], f'lv2 音意外变化: {ss}'
            print(f'金蛇(603) StartSound={ss} 保持不变 ✓')

    tree = ET.ElementTree(rgh)
    tree.write(OUT, encoding='utf-8', xml_declaration=True)
    print(f'输出：{OUT}')
    print('完成。下一步：xml2swf 重建＋回读断言。')

if __name__ == '__main__':
    sys.exit(main())
