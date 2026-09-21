#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
龙之怒（dragonHead）2.5 / 3.4 / 当前版 三方像素比对脚本（只读）

用途：复跑本家族对比结论（本体/开火/子弹/烟雾/受击逐帧像素比对）。
前置：先用 FFDec 完成导出（见下方 PREP），产物放入 WORK 目录。

PREP（FFDec 26.2.1 CLI）：
  FFDEC="metalwartale3-reborn.git/tools/packaging/ffdec/ffdec-cli.exe"
  # 1) sprite/shape 渲染（三方 arms 包）
  "$FFDEC" -format shape:png,sprite:png -export shape,sprite work/render-25 "原版/2.5（原版参考）/2.5版本素材库/raw/swf/arms_34.swf"
  "$FFDEC" -format shape:png,sprite:png -export shape,sprite work/render-34 "原版/3.4（原版参考）/3.4游戏/swf/arms52.swf"
  "$FFDEC" -format shape:png,sprite:png -export shape,sprite work/render-GH "metalwartale3-reborn.git/swf/arms1100.swf"
  # 2) 受击特效（三方 sub 包，只导出目标精灵）
  "$FFDEC" -selectid 1876 -export sprite work/hit34 "原版/3.4（原版参考）/3.4游戏/swf/sub52.swf"
  "$FFDEC" -selectid 1509 -export sprite work/hitGH "metalwartale3-reborn.git/swf/sub1130.swf"
  # 2.5 侧直接取基准包：metalwartale3-reborn.git/更新总结/武器家族内容/2.5受击特效提取-20260909/cutter_hit_effect

用法：python dragonhead_compare.py <work目录> [--baseline <2.5受击基准包目录>]
"""
import os
import sys

from PIL import Image
import numpy as np

BODY_25 = 'render-25/sprites/DefineSprite_85_dragonHead_lv1'
BODY_34 = 'render-34/sprites/DefineSprite_335_dragonHead_lv1'
BODY_GH = 'render-GH/sprites/DefineSprite_861_dragonHead_lv1'
BULLET = {
    '2.5': 'render-25/sprites/DefineSprite_73_dragonHead_lv1_bullet',
    '3.4': 'render-34/sprites/DefineSprite_322_dragonHead_lv1_bullet',
    'GH': 'render-GH/sprites/DefineSprite_855_dragonHead_lv1_bullet',
}
SMOKE = {
    '2.5': 'render-25/sprites/DefineSprite_80_dragonHead_lv1_smoke',
    '3.4': 'render-34/sprites/DefineSprite_329_dragonHead_lv1_smoke',
    'GH': 'render-GH/sprites/DefineSprite_852_dragonHead_lv1_smoke',
}
SHAPES = {
    ('body', '2.5'): 'render-25/shapes/82.png',
    ('body', '3.4'): 'render-34/shapes/331.png',
    ('body', 'GH'): 'render-GH/shapes/857.png',
    ('fire', '2.5'): 'render-25/shapes/31.png',   # 独立枪口特效
    ('fire', '3.4'): 'render-34/shapes/333.png',  # 开火态整枪（烘焙）
    ('fire', 'GH'): 'render-GH/shapes/859.png',
}


def load(path):
    return np.array(Image.open(path).convert('RGBA')).astype(int)


def diff_pixels(a, b):
    """返回 (差异像素数, 总像素数)；尺寸不同返回 None。"""
    if a.shape != b.shape:
        return None
    d = np.abs(a - b).sum(axis=2)
    return int((d > 0).sum()), int(d.size)


def cmp_dir(work, d1, d2, label):
    p1, p2 = os.path.join(work, d1), os.path.join(work, d2)
    if not (os.path.isdir(p1) and os.path.isdir(p2)):
        print(f'{label}: 目录缺失，跳过')
        return
    n = min(len(os.listdir(p1)), len(os.listdir(p2)))
    for i in range(1, n + 1):
        a, b = load(f'{p1}/{i}.png'), load(f'{p2}/{i}.png')
        r = diff_pixels(a, b)
        print(f'  {label} f{i}: ' + ('尺寸不同' if r is None else f'{r[0]}/{r[1]} ({100*r[0]/r[1]:.2f}%)'))


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    work = sys.argv[1]

    print('== 本体待机帧（f1/f4 应仅挂点标记区域不同）==')
    cmp_dir(work, BODY_25, BODY_GH, '2.5vsGH ')
    cmp_dir(work, BODY_34, BODY_GH, '3.4vsGH ')
    print('== 本体开火帧（f2/f3：2.5=ADD×2.00；3.4/GH=烘焙×1.58）==')
    print('  提示：亮度倍率需按 f2/f1 逐像素求比值，见总结第三节')
    print('== 子弹（应 0.00%）==')
    cmp_dir(work, BULLET['2.5'], BULLET['3.4'], '2.5vs3.4')
    cmp_dir(work, BULLET['2.5'], BULLET['GH'], '2.5vsGH ')
    print('== 烟雾（应 0.00%）==')
    cmp_dir(work, SMOKE['2.5'], SMOKE['GH'], '2.5vsGH ')
    cmp_dir(work, SMOKE['3.4'], SMOKE['GH'], '3.4vsGH ')
    print('== 形状级：本体 / 开火 ==')
    for kind in ('body', 'fire'):
        for va, vb in (('2.5', '3.4'), ('2.5', 'GH'), ('3.4', 'GH')):
            pa, pb = os.path.join(work, SHAPES[(kind, va)]), os.path.join(work, SHAPES[(kind, vb)])
            if not (os.path.exists(pa) and os.path.exists(pb)):
                print(f'  {kind} {va}vs{vb}: 文件缺失，跳过')
                continue
            r = diff_pixels(load(pa), load(pb))
            print(f'  {kind} {va}vs{vb}: ' + ('尺寸不同' if r is None else f'{r[0]}/{r[1]} ({100*r[0]/r[1]:.2f}%)'))
    print('== 受击 cutter_hit_effect（2.5 基准包 vs 3.4/GH）==')
    print('  基准：更新总结/武器家族内容/2.5受击特效提取-20260909/cutter_hit_effect/frame_N.png')
    print('  3.4 ：work/hit34/DefineSprite_1876_cutter_hit_effect/N.png')
    print('  GH  ：work/hitGH/DefineSprite_1509_cutter_hit_effect/N.png')
    return 0


if __name__ == '__main__':
    sys.exit(main())
