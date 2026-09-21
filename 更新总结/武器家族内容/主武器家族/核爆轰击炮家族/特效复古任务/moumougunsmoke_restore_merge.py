#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
核爆轰击炮（moumouGun）拖尾烟雾 2.5 回迁合并脚本（arms1100.swf）

背景：
  GH 的 moumouGun_lv1_smoke（精灵 #810，6 帧）时间轴与 2.5 #33 逐字节同款
  （逐帧矩阵/颜色矩阵/GLOW 滤镜全等），但内层精灵 #809 是空壳（无任何视觉内容），
  导致子弹飞行无拖尾。11.3 原版素材同为空白（原版即被清空）。

方案（最小改动，零新增位图）：
  1) 新增形状 #1816 = 2.5 #31 的逐字节复制（居中 1020x760 twips 矩形，
     位图填充 20 倍矩阵），仅把 bitmapId 30 改为 GH 现成同位图 #830
     （#830 与 2.5 #30 zlib 数据逐字节相同，20260921 龙之怒回迁时已入库）。
  2) 在空壳精灵 #809 内加入对 #1816 的身份矩阵放置（镜像 2.5 #32 的结构）。
  本体、配置、SymbolClass、其他精灵一律不动。

用法：
  python moumougunsmoke_restore_merge.py <输入XML> <输出XML>
  随后：ffdec-cli -xml2swf <输出XML> arms1100.swf
"""
import re
import sys

NEW_SHAPE_ID = "1816"
TARGET_SMOKE_SPRITE = "809"
BITMAP_ID_GH = "830"


def find_block(lines, pattern):
    """按行首缩进定位顶层 <item ...> 块，返回 (start, end) 行号。"""
    start = None
    for i, l in enumerate(lines):
        if re.match(pattern, l):
            start = i
            break
    if start is None:
        raise SystemExit("未找到目标块: " + pattern)
    end = len(lines)
    for j in range(start + 1, len(lines)):
        if lines[j].startswith("    <item ") or lines[j].startswith("  </tags>"):
            end = j
            break
    return start, end


def main():
    if len(sys.argv) != 3:
        print(__doc__)
        return 1
    src, dst = sys.argv[1], sys.argv[2]
    xml = open(src, encoding="utf-8").read()
    lines = xml.split("\n")

    # --- 1) 构造新形状（复制 2.5 #31 结构，替换 bitmapId 与 shapeId） ---
    # 2.5 #31 的模板：居中矩形 + 位图填充（20 倍矩阵, translate(-510,-380)）
    new_shape = f'''    <item type="DefineShapeTag" forceWriteAsLong="true" shapeId="{NEW_SHAPE_ID}">
      <shapeBounds type="RECT" Xmax="510" Xmin="-510" Ymax="380" Ymin="-380" nbits="10"/>
      <shapes type="SHAPEWITHSTYLE" numFillBits="2" numLineBits="0">
        <fillStyles type="FILLSTYLEARRAY">
          <fillStyles>
            <item type="FILLSTYLE" bitmapId="65535" fillStyleType="65">
              <bitmapMatrix type="MATRIX" hasRotate="false" hasScale="true" nRotateBits="0" nScaleBits="22" nTranslateBits="0" scaleX="20.0" scaleY="20.0" translateX="0" translateY="0"/>
            </item>
            <item type="FILLSTYLE" bitmapId="{BITMAP_ID_GH}" fillStyleType="65">
              <bitmapMatrix type="MATRIX" hasRotate="false" hasScale="true" nRotateBits="0" nScaleBits="22" nTranslateBits="10" scaleX="20.0" scaleY="20.0" translateX="-510" translateY="-380"/>
            </item>
          </fillStyles>
        </fillStyles>
        <lineStyles type="LINESTYLEARRAY">
          <lineStyles/>
        </lineStyles>
        <shapeRecords>
          <item type="StyleChangeRecord" fillStyle1="2" moveBits="10" moveDeltaX="510" moveDeltaY="380" stateFillStyle0="false" stateFillStyle1="true" stateLineStyle="false" stateMoveTo="true" stateNewStyles="false"/>
          <item type="StraightEdgeRecord" deltaX="-1020" generalLineFlag="false" numBits="9" vertLineFlag="false"/>
          <item type="StraightEdgeRecord" deltaY="-760" generalLineFlag="false" numBits="9" vertLineFlag="true"/>
          <item type="StraightEdgeRecord" deltaX="1020" generalLineFlag="false" numBits="9" vertLineFlag="false"/>
          <item type="StraightEdgeRecord" deltaY="760" generalLineFlag="false" numBits="9" vertLineFlag="true"/>
          <item type="EndShapeRecord" endOfShape="0"/>
        </shapeRecords>
      </shapes>
    </item>'''

    # 断言：位图 830 存在且与目标尺寸相符
    if not re.search(r'<item type="DefineBits\w+Tag"[^>]*characterID="%s"[^>]*bitmapWidth="51"[^>]*bitmapHeight="38"' % BITMAP_ID_GH, xml):
        if not re.search(r'<item type="DefineBits\w+Tag"[^>]*characterID="%s"' % BITMAP_ID_GH, xml):
            raise SystemExit("GH 位图 #%s 不存在，需先导入" % BITMAP_ID_GH)

    # 断言：新 ID 未被占用
    if re.search(r'(?:spriteId|shapeId|characterID|bitmapId)="%s"' % NEW_SHAPE_ID, xml):
        raise SystemExit("ID %s 已被占用" % NEW_SHAPE_ID)

    # --- 2) 在 #809 内插入放置指令（镜像 2.5 #32） ---
    s_start, s_end = find_block(
        lines, r'    <item type="DefineSpriteTag"[^>]*spriteId="%s"' % TARGET_SMOKE_SPRITE)
    smoke_block = "\n".join(lines[s_start:s_end])
    if '<item type="PlaceObject' in smoke_block:
        raise SystemExit("#%s 内已存在放置指令，拒绝重复插入" % TARGET_SMOKE_SPRITE)
    place = f'''        <item type="PlaceObject2Tag" characterId="{NEW_SHAPE_ID}" depth="1" forceWriteAsLong="false" placeFlagHasCharacter="true" placeFlagHasClipActions="false" placeFlagHasClipDepth="false" placeFlagHasColorTransform="false" placeFlagHasMatrix="true" placeFlagHasName="false" placeFlagHasRatio="false" placeFlagMove="false">
          <matrix type="MATRIX" hasRotate="false" hasScale="false" nRotateBits="0" nScaleBits="0" nTranslateBits="0" translateX="0" translateY="0"/>
        </item>'''
    new_lines = []
    for i, l in enumerate(lines):
        if s_start <= i < s_end and '<item type="ShowFrameTag"' in l:
            new_lines.append(place)
        new_lines.append(l)
    lines = new_lines

    # --- 3) 在 #809 块之前插入新形状定义（保证定义先于引用） ---
    s_start, _ = find_block(
        lines, r'    <item type="DefineSpriteTag"[^>]*spriteId="%s"' % TARGET_SMOKE_SPRITE)
    lines = lines[:s_start] + new_shape.split("\n") + lines[s_start:]

    out = "\n".join(lines)
    # --- 4) 写盘前断言 ---
    assert f'shapeId="{NEW_SHAPE_ID}"' in out, "新形状缺失"
    assert out.count(f'characterId="{NEW_SHAPE_ID}"') == 1, "放置指令异常"
    assert f'bitmapId="{BITMAP_ID_GH}"' in out, "位图引用缺失"
    open(dst, "w", encoding="utf-8").write(out)
    print("OK 已写出:", dst)
    return 0


if __name__ == "__main__":
    sys.exit(main())
