# 2.5 受击特效美术导出（chipped_hit_effect）

> 导出日期：2026-09-08　来源：`原版\2.5（原版参考）\2.5版本素材库\raw\swf\sub37.swf`（FFDec 21.1.1）
> 用途：聚能轰击炮家族受击特效 2.5 版美术的存档与检索（20260908 已回迁入 bullet.swf `blueness_energy`）。

## 在游戏中的存在形式（四层结构）

```text
sub37.swf（副武器资源包）
└─ DefineSprite 1632 "chipped_hit_effect"（8 帧时间轴；f8 为清理帧）
   ├─ f1..f7 各摆 1 个 DefineShape（1619/1621/.../1631，深度 1，恒等矩阵）
   │   └─ 每个造型 = 位图填充矩形（无矢量线条），填充引用一张 DefineBitsJPEG3 位图
   │       （1618/1620/.../1630，填充矩阵 scale 20/20，即 20 twips = 1 像素）
   └─ f2 StartSound → DefineSound 282（命中音效，随特效播放）
```

运行时：配置 `hitImgLabel = sub/chipped_hit_effect` → 引擎按前缀定位资源包、按导出名取 sprite → 子弹命中时在命中点播放 8 帧。

## 本目录内容

- `逐帧合成/chipped_hit_effect_帧01~08.png`：sprite 整体逐帧渲染（215×212），即游戏内实际看到的画面；帧 8 为透明清理帧。
- `分层光斑/光斑层<shapeID>.png`：7 个光斑造型单独渲染（按 shape Character ID 命名）：
  | shape | 尺寸(px) | 对应帧 |
  |---|---|---|
  | 1619 | 89×89 | f1 |
  | 1621 | 75×75 | f2 |
  | 1623 | 95×96 | f3 |
  | 1625 | 126×125 | f4 |
  | 1627 | 202×184 | f5 |
  | 1629 | 212×185 | f6 |
  | 1631 | 209×205 | f7 |
  （渲染尺寸=造型边界框/20，个别 +1px 为渲染器边缘余量；造型坐标含负值原点，非以 (0,0) 为中心。）

## 与当前版本的对应

20260908 回迁后，GitHub 版 bullet.swf 内 `blueness_energy`（sprite 140，由死名 75 改绑）即本特效的完整克隆：sprite→新 140、shape→125~137、音效→139，逐帧与本文档素材一致。
