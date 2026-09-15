# 画师参考包生成：挂点弹真相（363/364 位图原件 + 365 组合体结构）
# 依据：sub1130.swf 365=DefineShape2（位图填充裁剪），SVG 矩阵实证：
#   枪 363 -> 1:1 置于 (0,0)
#   弹 364 -> 缩放 0.5、水平翻转，填充窗口 local x57.25~93.75 / y4.35~14.85
#   可见弹头 = 364 原件左侧约 29.5px（弹头段）缩到 50% 后露出枪口 ~15px
from PIL import Image, ImageDraw, ImageFont
import os, shutil

SRC = r'D:\superalloy\原版\11.3超合金素材汇总\11.3副武器\images'
RENDER = r'D:\superalloy\原版\11.3超合金素材汇总\11.3副武器\shapes\365.png'
SVG = r'D:\superalloy\metalwartale3-reborn.git\tmp-artist-bullet-probe-20260916\svg\365.svg'
OUT = (r'D:\superalloy\metalwartale3-reborn.git\更新总结\武器特效总结\副武器家族'
       r'\恶魔牙家族（飞刃炮）\番外家族-黄金恶魔牙家族（黄金飞刃炮）\素材-画师-挂点弹与枪体原件包-20260916')
os.makedirs(OUT, exist_ok=True)

b363 = Image.open(os.path.join(SRC, '363.png')).convert('RGBA')  # 79x22
b364 = Image.open(os.path.join(SRC, '364.png')).convert('RGBA')  # 73x21
r365 = Image.open(RENDER).convert('RGBA')                        # 94x23

# 0) 原件直接入库（已验证与仓库 SWF 导出像素级一致 maxdiff=0）
b363.save(os.path.join(OUT, '原件-363-枪体位图-79x22-1比1像素.png'))
b364.save(os.path.join(OUT, '原件-364-子弹位图-73x21-1比1像素.png'))
shutil.copy(SVG, os.path.join(OUT, '原件-365-组合体矢量结构-打开即见两层位图填充.svg'))

# 1) 364 标注版 4x：左侧 ~30px 弹头段 = 游戏内出膛可见段来源（缩 50% + 翻转后）
Z = 4
big = b364.resize((73 * Z, 21 * Z), Image.NEAREST)
tint = Image.new('RGBA', big.size, (255, 220, 0, 80))
mark = Image.alpha_composite(big, tint)
d = ImageDraw.Draw(mark)
d.rectangle([0, 0, int(29.5 * Z) - 1, 21 * Z - 1], outline=(255, 40, 40, 255), width=Z)
font = ImageFont.truetype(r'C:\Windows\Fonts\msyh.ttc', 22)
l1 = '364 子弹位图原件（弹头朝左）  4x 放大'
l2 = '红框内（左侧约30px 弹头段）= 游戏内枪口出膛那段的真实来源：缩 50% + 水平翻转'
tw = max(d.textlength(l1, font=font), d.textlength(l2, font=font))
info = Image.new('RGBA', (int(tw) + 16, mark.height + 64), (30, 30, 30, 255))
info.paste(mark, (0, 64))
di = ImageDraw.Draw(info)
di.text((8, 6), l1, font=font, fill=(255, 255, 255, 255))
di.text((8, 34), l2, font=font, fill=(255, 230, 120, 255))
info.save(os.path.join(OUT, '解读-364-子弹位图标注版-弹头段来源-4x.png'))

# 2) 组合体结构复原 vs FFDec 渲染对照（4x）
Z = 4
bullet_small = b364.resize((int(36.5 * Z), int(10.5 * Z)), Image.LANCZOS).transpose(Image.FLIP_LEFT_RIGHT)
comp = Image.new('RGBA', (94 * Z, 23 * Z), (0, 0, 0, 0))
comp.paste(bullet_small, (int(57.25 * Z), int(4.35 * Z)), bullet_small)
gun = b363.resize((79 * Z, 22 * Z), Image.NEAREST)
comp.paste(gun, (0, 0), gun)
render_big = r365.resize((94 * Z, 23 * Z), Image.NEAREST)

font2 = ImageFont.truetype(r'C:\Windows\Fonts\msyh.ttc', 22)
row_h = 23 * Z
gap = 56
W = max(94 * Z + 16, int(font2.getlength('下排：按矢量矩阵复原（弹=364 缩50%+翻转，枪=363 原尺寸）——两者应一致')) + 16, 700)
H = 96 + row_h + gap + row_h + 8
sheet = Image.new('RGBA', (W, H), (30, 30, 30, 255))
ds = ImageDraw.Draw(sheet)
ds.text((8, 6), '上排：游戏内组合体（365）的权威渲染', font=font2, fill=(255, 255, 255, 255))
ds.text((8, 38), '下排：按矢量矩阵复原（弹=364 缩50%+翻转，枪=363 原尺寸）——两者应一致',
        font=font2, fill=(255, 230, 120, 255))
sheet.paste(render_big, (8, 96), render_big)
sheet.paste(comp, (8, 96 + row_h + gap), comp)
sheet.save(os.path.join(OUT, '解读-365-组合体结构复原对照-上渲染下复原-4x.png'))

# 3) 组合体渲染 1:1 原件
r365.save(os.path.join(OUT, '原件-365-组合体渲染图-94x23-注意这是渲染结果不是像素原件.png'))
print('done:', os.listdir(OUT))
