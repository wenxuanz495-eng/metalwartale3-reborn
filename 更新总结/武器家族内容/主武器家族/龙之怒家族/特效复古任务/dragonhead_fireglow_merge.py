#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
龙之怒（dragonHead）开火整枪发光 2.5 回迁 — arms1100.swf XML 合并脚本

目标：把 2.5 的开火帧整枪发光（本体 + ADD 同图叠加 + 独立枪口特效）还原到当前版
      dragonHead_lv1（sprite 861）。

设计（复用文件内现有资源，零新增位图/形状）：
  - 枪口特效：复用现有形状 #831（= 独立枪口特效形状，位图 #830）
      #831 内部位图矩阵 translate=(1294,-170)；2.5 的 #31 内部 translate=(-510,-380)。
      2.5 绝对位置 = 2033-510 = 1523 / 297-380 = -83（与当前 #859 内嵌火焰坐标逐值一致）。
      故在 GH 坐标系放置 #831 的矩阵 = (1523-1294, -83-(-170)) = (229, 87)。
  - ADD 副本：新建 1 帧包装 sprite（含本体形状 #857 @0,0），f2 以 PO3 blendMode=8 放置于
      本体同矩阵 (0,0)，与 edge_lv1 的 #832 范式、2.5 的 #83 结构一致。
  - 原开火覆写形状 #859（含烘焙提亮本体 #858 + 火焰 #830）不再放置；定义保留（未引用，无害）。

sprite 861 变更：
  f2: [删] PlaceObject2Tag cid=859 d3 → [增] PO2 cid=831 d2 (229,87) + PO3 cid=<ADD> d3 blend8 (0,0)
  f4: [增] RemoveObject2Tag d2（原有 REMOVE d3 保留）

用法：python dragonhead_fireglow_merge.py <in.xml> <out.xml> [--add-id 1815]
"""
import sys
import xml.etree.ElementTree as ET

ADD_SPRITE_ID = 1815     # 新增 ADD 包装 sprite（1814=snow_lv3 后的下一个空闲 ID）
FLASH_SHAPE = '831'      # 复用：独立枪口特效形状
BODY_SHAPE = '857'       # dragonHead 本体形状
BODY_SPRITE = '861'      # dragonHead_lv1
FIRE_SHAPE_OLD = '859'   # 旧：开火态整枪烘焙形状（本次不再放置）
FLASH_DX, FLASH_DY = 229, 87
BODY_MATRIX = ('0', '0')


def find_item(root, **kw):
    for el in root.iter('item'):
        if all(el.get(k) == v for k, v in kw.items()):
            return el
    return None


def matrix_node(tx, ty):
    return ET.fromstring(
        f'<matrix type="MATRIX" hasRotate="false" hasScale="false" nRotateBits="0" nScaleBits="0" '
        f'nTranslateBits="13" translateX="{tx}" translateY="{ty}" />')


def po2(cid, depth, tx, ty):
    el = ET.Element('item', {
        'type': 'PlaceObject2Tag', 'characterId': cid, 'depth': str(depth),
        'forceWriteAsLong': 'true',
        'placeFlagHasCharacter': 'true', 'placeFlagHasClipActions': 'false',
        'placeFlagHasClipDepth': 'false', 'placeFlagHasColorTransform': 'false',
        'placeFlagHasMatrix': 'true', 'placeFlagHasName': 'false',
        'placeFlagHasRatio': 'false', 'placeFlagMove': 'false'})
    el.append(matrix_node(tx, ty))
    return el


def po3_blend8(cid, depth, tx, ty):
    el = ET.Element('item', {
        'type': 'PlaceObject3Tag', 'characterId': cid, 'depth': str(depth),
        'blendMode': '8', 'forceWriteAsLong': 'true',
        'placeFlagHasBlendMode': 'true', 'placeFlagHasCacheAsBitmap': 'false',
        'placeFlagHasCharacter': 'true', 'placeFlagHasClassName': 'false',
        'placeFlagHasClipActions': 'false', 'placeFlagHasClipDepth': 'false',
        'placeFlagHasColorTransform': 'false', 'placeFlagHasFilterList': 'false',
        'placeFlagHasImage': 'false', 'placeFlagHasMatrix': 'true',
        'placeFlagHasName': 'false', 'placeFlagHasRatio': 'false',
        'placeFlagHasVisible': 'false', 'placeFlagMove': 'false',
        'placeFlagOpaqueBackground': 'false', 'reserved': 'false'})
    el.append(matrix_node(tx, ty))
    return el


def remove2(depth):
    return ET.Element('item', {'type': 'RemoveObject2Tag', 'depth': str(depth),
                               'forceWriteAsLong': 'false'})


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 1
    src, dst = sys.argv[1], sys.argv[2]

    raw = open(src, encoding='utf-8', errors='replace').read()
    header = raw[:raw.index('<swf')]          # XML 声明 + WARNING 注释，原样保留
    tree = ET.parse(src)
    root = tree.getroot()

    # ---- 前置断言 ----
    assert find_item(root, shapeId=FLASH_SHAPE) is not None, '#831 不存在'
    assert find_item(root, shapeId=BODY_SHAPE) is not None, '#857 不存在'
    sprite = find_item(root, spriteId=BODY_SPRITE)
    assert sprite is not None, 'sprite 861 不存在'
    add_id = ADD_SPRITE_ID
    if '--add-id' in sys.argv:
        add_id = sys.argv[sys.argv.index('--add-id') + 1]
    assert find_item(root, spriteId=add_id) is None, f'#{add_id} 已被占用'

    # 校验 #831 内部移位数（用于放置矩阵换算）
    sh831 = find_item(root, shapeId=FLASH_SHAPE)
    fills = [f for f in sh831.iter('item') if f.get('type') == 'FILLSTYLE' and f.get('bitmapId') != '65535']
    assert len(fills) == 1, '#831 应只有 1 个有效位图填充'
    m = fills[0].find('bitmapMatrix')
    assert (m.get('translateX'), m.get('translateY')) == ('1294', '-170'), \
        f'#831 内部矩阵意外: {m.get("translateX")},{m.get("translateY")}'

    # ---- 1) 新建 ADD 包装 sprite（#857 @0,0，1 帧） ----
    add_sprite = ET.Element('item', {
        'type': 'DefineSpriteTag', 'forceWriteAsLong': 'true',
        'frameCount': '1', 'hasEndTag': 'true', 'spriteId': str(add_id)})
    sub = ET.SubElement(add_sprite, 'subTags')
    sub.append(ET.Element('item', {
        'type': 'SoundStreamHead2Tag', 'forceWriteAsLong': 'false',
        'playBackSoundRate': '3', 'playBackSoundSize': 'true', 'playBackSoundType': 'true',
        'reserved': '0', 'streamSoundCompression': '0', 'streamSoundRate': '0',
        'streamSoundSampleCount': '0', 'streamSoundSize': 'false', 'streamSoundType': 'false'}))
    sub.append(po2(BODY_SHAPE, 1, *BODY_MATRIX))
    sub.append(ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'}))
    assert sub is not None

    # 插到 sprite 861 之前（定义先于引用）
    tags = root.find('tags')
    children = list(tags)
    tags.insert(children.index(sprite), add_sprite)

    # ---- 2) 改 sprite 861 ----
    frames = []   # [(frame_no, [elements])]
    cur = []
    for st in sprite:
        if st.tag != 'subTags':
            continue
        for op in list(st):
            if op.get('type') == 'ShowFrameTag':
                frames.append(cur)
                cur = []
            else:
                cur.append(op)
    assert len(frames) == 4, f'sprite 861 应为 4 帧，实际 {len(frames)}'

    # f2（帧序号 1）：删 #859 放置，增 枪口特效 + ADD 副本
    f2 = frames[1]
    old = [op for op in f2 if op.get('type', '').startswith('PlaceObject') and op.get('characterId') == FIRE_SHAPE_OLD]
    assert len(old) == 1, f'f2 应有 1 处 #859 放置，实际 {len(old)}'
    idx = f2.index(old[0])
    f2.remove(old[0])
    f2.insert(idx, po2(FLASH_SHAPE, 2, FLASH_DX, FLASH_DY))
    f2.insert(idx + 1, po3_blend8(str(add_id), 3, *BODY_MATRIX))

    # f4（帧序号 3）：增 REMOVE d2，保留 REMOVE d3
    f4 = frames[3]
    depths = [op.get('depth') for op in f4 if op.get('type') == 'RemoveObject2Tag']
    assert depths == ['3'], f'f4 移除深度意外: {depths}'
    f4.insert(0, remove2(2))

    # 按帧序重写 subTags
    st = sprite.find('subTags')
    for op in list(st):
        st.remove(op)
    st.append(ET.Element('item', {'type': 'SoundStreamHead2Tag', 'forceWriteAsLong': 'false',
                                  'playBackSoundRate': '3', 'playBackSoundSize': 'true',
                                  'playBackSoundType': 'true', 'reserved': '0',
                                  'streamSoundCompression': '0', 'streamSoundRate': '0',
                                  'streamSoundSampleCount': '0', 'streamSoundSize': 'false',
                                  'streamSoundType': 'false'}))
    for ops in frames:
        for op in ops:
            st.append(op)
        st.append(ET.Element('item', {'type': 'ShowFrameTag', 'forceWriteAsLong': 'false'}))

    # ---- 写出 ----
    body = ET.tostring(root, encoding='unicode')
    with open(dst, 'w', encoding='utf-8', newline='\n') as fh:
        fh.write(header + body)
    print(f'[OK] 写出 {dst}')
    print(f'  f2 = 本体#857 + 枪口特效#831@({FLASH_DX},{FLASH_DY}) + ADD#{add_id}@(0,0) blend8 + 音')
    print(f'  f4 = REMOVE d2 + REMOVE d3')
    print(f'  新增：DefineSpriteTag #{add_id}（1 帧，#857@0,0）')
    return 0


if __name__ == '__main__':
    sys.exit(main())
