# -*- coding: utf-8 -*-
# 四级挂点弹移除 前后对比图（f1 待机帧，2x）
from PIL import Image, ImageDraw, ImageFont
import glob, os, sys
sys.stdout.reconfigure(encoding='utf-8')

OLD = r'D:\superalloy\metalwartale3-reborn.git\tmp-goldflyblade-removebullet-20260916\render-old'
NEW = r'D:\superalloy\metalwartale3-reborn.git\tmp-goldflyblade-removebullet-20260916\render-new'
OUT = (r'D:\superalloy\metalwartale3-reborn.git\更新总结\武器特效总结\副武器家族'
       r'\恶魔牙家族（飞刃炮）\番外家族-黄金恶魔牙家族（黄金飞刃炮）')
Z = 2
font = ImageFont.truetype(r'C:\Windows\Fonts\msyh.ttc', 20)

LV = [('LV3 黄金地狱之触', '2774'), ('LV4 黄金深渊之刃', '2775'),
      ('LV5 黄金灭世之手', '2776'), ('LV6 黄金诸神之殁', '2777')]
cells = []
for name, sid in LV:
    o = Image.open(sorted(glob.glob(rf'{OLD}\DefineSprite_{sid}_goldflyBlade_lv*\1.png'))[0]).convert('RGBA')
    n = Image.open(sorted(glob.glob(rf'{NEW}\DefineSprite_{sid}_goldflyBlade_lv*\1.png'))[0]).convert('RGBA')
    w, h = o.size
    cells.append((name, o.resize((w*Z, h*Z), Image.NEAREST), n.resize((w*Z, h*Z), Image.NEAREST), w*Z, h*Z))

cw = max(c[3] for c in cells)
label_h, gap = 46, 14
col_w = cw + 16
W = max(col_w * 2 + 24, int(font.getlength('左=移除前（364 裁剪弹头，贴合失败）  右=移除后（画师新尖另行交付导入）')) + 24)
H = 60 + len(cells) * (label_h + cells[0][4] + gap)
sheet = Image.new('RGBA', (W, H), (34, 34, 34, 255))
d = ImageDraw.Draw(sheet)
d.text((10, 8), '黄金恶魔牙 LV3~LV6 挂点弹移除 · f1 待机帧前后对比（2x）', font=font, fill=(255,255,255,255))
d.text((10, 34), '左=移除前（364 裁剪弹头，贴合失败）  右=移除后（画师新尖另行交付导入）', font=font, fill=(255,220,120,255))
y = 60
for name, o, n, w, h in cells:
    x1, x2 = 12, 12 + col_w
    d.text((x1, y), f'{name} 移除前', font=font, fill=(255,255,255,255))
    d.text((x2, y), f'{name} 移除后', font=font, fill=(140,255,140,255))
    sheet.paste(o, (x1, y + label_h), o)
    sheet.paste(n, (x2, y + label_h), n)
    y += label_h + h + gap
sheet.convert('RGB').save(os.path.join(OUT, '黄金四级挂点弹移除对比-f1前后-20260916.png'))
print('saved 对比图')
