#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
hilt_center_tool.py — 圆形剑柄/圆饰定心工具（恶魔牙家族实证，可复用于任何家族）

用途：
  对本体形状的"圆饰/毂"（圆形结构）做圆拟合求圆心，或对特效形状求视觉中心，
  直接给出"特效同心贴圆饰"的建议 PlaceObject 矩阵（twips）。

方法（详见《蓄力小圈与枪口火焰判别及白圈定心微调闭环-20260914.md》）：
  ⚠ 禁用包围盒中心/目视估读。
  - 圆饰（本体）：颜色掩码 → 最大连通域 → 边界像素 → Kasa 最小二乘圆拟合 → 圆心
  - 特效（软光晕圈）：渲染像素 alpha 加权质心（视觉中心 ≠ 包围盒中心）
  - 建议矩阵 tx = (圆饰x − 特效视觉中心x) × 20，ty 同理（20 twips = 1 px）

用法：
  1) 先用 FFDec 把目标 swf 全量导出 shape PNG（-export shape -format shape:png），
     PNG 画布 = shapeBounds 归一化（canvas(0,0) = bounds(Xmin,Ymin)）。
  2) python hilt_center_tool.py <shape.png> <Xmin> <Ymin> --preset teal --region 12,40,3,22 --overlay out.png
     preset: teal(恶魔牙青毂) / purple(金紫宝石) / white(白圈特效, 用 alpha 模式)
     --mode circle(默认,圆拟合) | weighted(alpha加权质心,用于特效软光晕)
     --region x0,x1,y0,y1 (画布坐标, 限定搜索区防装饰条纹污染)
  3) 返回画布与 sprite 双坐标 + 圆心/半径/残差 + 覆盖验证图。

依赖：Pillow、numpy。验证基线：金LV1 宝石 (24.32,37.20)（20260914 用户取色定稿）。
"""
import sys
import numpy as np
from PIL import Image, ImageDraw
from collections import deque

TW = 20.0  # twips per pixel

PRESETS = {
    # 恶魔牙/高阶枪体青色圆毂（青/蓝绿，排除深色描边与白高光）
    'teal':   lambda R, G, B, A: (B > 110) & (G > 100) & (R < G - 20) & (A > 90),
    # 金色枪体紫/品红宝石（排除金黄本体：G 必须显著低于 R、B）
    'purple': lambda R, G, B, A: (R > 100) & (B > 100) & (G < R - 35) & (G < B - 35) & (A > 90),
}


def load_rgba(path):
    return np.array(Image.open(path).convert('RGBA')).astype(int)


def color_mask(a, preset):
    R, G, B, A = a[..., 0], a[..., 1], a[..., 2], a[..., 3]
    fn = PRESETS.get(preset)
    if fn is None:
        raise ValueError(f'unknown preset {preset}; available: {list(PRESETS)}')
    return fn(R, G, B, A) & (A > 60)


def largest_blob(mask):
    H, W = mask.shape
    seen = np.zeros_like(mask, dtype=bool)
    best, bestn = None, 0
    for sy in range(H):
        for sx in range(W):
            if mask[sy, sx] and not seen[sy, sx]:
                q = deque([(sy, sx)]); seen[sy, sx] = True; pix = []
                while q:
                    y, x = q.popleft(); pix.append((y, x))
                    for dy in (-1, 0, 1):
                        for dx in (-1, 0, 1):
                            ny, nx = y + dy, x + dx
                            if 0 <= ny < H and 0 <= nx < W and mask[ny, nx] and not seen[ny, nx]:
                                seen[ny, nx] = True; q.append((ny, nx))
                if len(pix) > bestn:
                    bestn, best = len(pix), pix
    m = np.zeros_like(mask)
    if best:
        ys, xs = zip(*best)
        m[list(ys), list(xs)] = True
    return m, bestn


def boundary_pixels(blob):
    """blob 的边界像素（至少一个 4 邻不在 blob 内）"""
    H, W = blob.shape
    out = []
    ys, xs = np.where(blob)
    for y, x in zip(ys, xs):
        for dy, dx in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            ny, nx = y + dy, x + dx
            if not (0 <= ny < H and 0 <= nx < W) or not blob[ny, nx]:
                out.append((y, x)); break
    return out


def kasa_fit(pts):
    """Kasa 代数圆拟合：pts = [(x,y)]，返回 (cx, cy, r, rms)"""
    x = np.array([p[0] for p in pts], dtype=float)
    y = np.array([p[1] for p in pts], dtype=float)
    Amat = np.stack([x, y, np.ones_like(x)], axis=1)
    b = x * x + y * y
    sol, *_ = np.linalg.lstsq(Amat, b, rcond=None)
    cx, cy = sol[0] / 2, sol[1] / 2
    r = np.sqrt(sol[2] + cx * cx + cy * cy)
    rms = float(np.sqrt(np.mean((np.hypot(x - cx, y - cy) - r) ** 2)))
    return cx, cy, r, rms


def circle_center(png, Xmin, Ymin, preset, region=None, overlay=None):
    """圆饰圆心（sprite 坐标）。region=(x0,x1,y0,y1) 画布坐标限定搜索区。"""
    a = load_rgba(png)
    mask = color_mask(a, preset)
    if region:
        x0, x1, y0, y1 = region
        lim = np.zeros_like(mask); lim[y0:y1, x0:x1] = True
        mask &= lim
    blob, n = largest_blob(mask)
    bpts = boundary_pixels(blob)
    if len(bpts) < 8:
        raise RuntimeError(f'boundary too small ({len(bpts)} px) — 调整 preset/region')
    cx, cy, r, rms = kasa_fit([(x, y) for y, x in bpts])
    sc = (Xmin + cx, Ymin + cy)
    if overlay:
        im = Image.open(png).convert('RGBA')
        ov = Image.new('RGBA', im.size, (0, 0, 0, 0))
        d = ImageDraw.Draw(ov)
        d.ellipse([cx - r, cy - r, cx + r, cy + r], outline=(0, 255, 0, 255), width=1)
        d.point([(cx, cy)], fill=(255, 0, 0, 255))
        Image.alpha_composite(im, ov).resize((im.width * 8, im.height * 8), Image.NEAREST).save(overlay)
    return {'center_canvas': (round(cx, 2), round(cy, 2)),
            'center_sprite': (round(sc[0], 2), round(sc[1], 2)),
            'radius_px': round(r, 2), 'rms_px': round(rms, 2), 'blob_px': n}


def effect_visual_center(png):
    """特效软光晕圈视觉中心（sprite 相对量 = canvas 质心 + bounds 偏移由调用方加）。
    alpha 加权质心：视觉中心 ≠ 包围盒中心。"""
    a = load_rgba(png)
    al = a[..., 3].astype(float)
    ys, xs = np.mgrid[0:a.shape[0], 0:a.shape[1]]
    tot = al.sum()
    return (float((xs * al).sum() / tot), float((ys * al).sum() / tot))


def suggest_matrix(gem_sprite, ring_local):
    """由圆饰中心与特效形状空间视觉中心 → 建议 (tx,ty) twips"""
    return (round((gem_sprite[0] - ring_local[0]) * TW), round((gem_sprite[1] - ring_local[1]) * TW))


if __name__ == '__main__':
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument('png'); ap.add_argument('Xmin', type=float); ap.add_argument('Ymin', type=float)
    ap.add_argument('--preset', default='purple')
    ap.add_argument('--region', default=None, help='x0,x1,y0,y1 画布坐标')
    ap.add_argument('--mode', default='circle', choices=['circle', 'weighted'])
    ap.add_argument('--overlay', default=None)
    a = ap.parse_args()
    region = tuple(int(v) for v in a.region.split(',')) if a.region else None
    if a.mode == 'circle':
        r = circle_center(a.png, a.Xmin, a.Ymin, a.preset, region, a.overlay)
        print(r)
    else:
        print(effect_visual_center(a.png))
