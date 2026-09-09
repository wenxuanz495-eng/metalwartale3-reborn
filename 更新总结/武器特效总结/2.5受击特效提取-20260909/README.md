# 2.5 受击特效提取包

> 提取日期：2026-09-09
> 来源：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\sub37.swf`（只读参考，未做任何修改）
> 源文件 SHA-256：`9DBFEFC830045E8453763504AC27F37F186679A52BD17A938884FFD613FF392B`
> 工具：JPEXS FFDec 26.2.1 CLI（sprite 逐帧 PNG 导出，RGBA 透明背景），Java 25
> 用途：2.5 原版全部受击特效的视觉基准与迁移对照，供主武器收尾与副武器阶段的受击特效回迁使用

## 提取范围与统计

2.5 主武器配置 `arms_35.xml` 共 22 个家族、85 个形态，`hitImgLabel` 全部指向 `sub\` 资源组，**基础受击特效共 5 种**；加上副武器配置 `subArms37.xml` 用到的扩展，`sub37.swf` 内共有 **12 个受击特效导出名**，本次全部提取。

| 导出名 | 2.5 Character ID | 帧数（本次渲染） | 2.5 sprite 字节 | 使用者（2.5 配置） |
|---|---:|---:|---:|---|
| motion_hit_effect_1 | 1711 | 3 | 60 | 小黄豆/火神炮/夜叉/电热化学（运行时四选一） |
| motion_hit_effect_2 | 1707 | 3 | 60 | 同上 |
| motion_hit_effect_3 | 1702 | 3 | 60 | 同上 |
| motion_hit_effect_4 | 1697 | 3 | 60 | 同上 |
| boom_hit_effect | 1678 | 7 | 82 | 野火/感应炮/闪电炮/雪崩/跳弹 + 副武器 10 处 |
| boom_hit_effect2 | 1670 | 7 | 82 | 敌方/特殊调用（主副武器配置未直接引用） |
| energy_hit_effect | 1692 | 6 | 76 | 传说激光/波动/荷电粒子/微波/光刀/校本 |
| chipped_hit_effect | 1632 | 8 | 91 | 等离子/位相/振幅/苍蝇王/某某炮 |
| cutter_hit_effect | 1617 | 7 | 82 | 龙头/锋刃 + 副武器 9 处 |
| hot_hit_effect | 1656 | 6 | 67 | 副武器专用（5 处） |
| laser_hit_effect | 1643 | 5 | 58 | 副武器专用（4 处） |
| positron_hit_effect | 439 | 15 | 154 | 副武器正电子炮（3 处） |

注：GH sub1130.swf 同样存在全部 12 个同名导出，但**同名不等于同物**，逐项对照见下节。Character ID 两版各自独立编号（如 chipped：2.5=1632 / GH=1424），不可按数字互换。

主武器 5 种基础特效的配置引用统计（`arms_35.xml`）：`sub/boom_hit_effect` 28 处、`sub/energy_hit_effect` 23 处、`sub/motion_hit_effect` 20 处、`sub/chipped_hit_effect` 12 处、`sub/cutter_hit_effect` 2 处。

## 目录结构

```text
2.5受击特效提取-20260909/
├── README.md                 本说明
├── motion_hit_effect_1~4/    每变体一个文件夹，frame_N.png 为逐帧渲染
├── boom_hit_effect/  boom_hit_effect2/
├── energy_hit_effect/  chipped_hit_effect/  cutter_hit_effect/
└── hot_hit_effect/  laser_hit_effect/  positron_hit_effect/
```

## 运行时机制（已代码证实）

- `BulletBody.get hitImgLabel()`（`decompiled\gamefile\scripts\body\bullet\BulletBody.as` 约 94 行）：**只有**标签含 `motion_hit_effect` 时追加 `_<1~4>` 随机后缀，四变体静态四选一；其余受击特效均按裸名直接调用，无变体。
- `cutter_hit_effect` 在 `BodyGroupHit.as` 命中时带 ±15px 随机位移与随机旋转。
- `motion_hit_effect_N` 的末帧为清理帧（近空白），属正常结构，不是缺帧。

## 与当前版（sub1130）对照与已知审计结论（截至 2026-09-09）

以下综合各家族对比/回迁总结（见 `更新总结\武器特效总结` 各家族目录）：

| 导出名 | 当前版实况 | 回迁成本结论 |
|---|---|---|
| energy_hit_effect | 与 2.5 **逐帧字节级一致**（微波炮/光刃炮/守望者三份审计交叉证实） | 零成本，配置改绑即可 |
| boom_hit_effect | GH char 1454 渲染与 2.5 一致（调皮家族对比 20260909） | 零成本改绑；但被敌方 178 处+主武器 17 处共用，**严禁动其内容** |
| motion_hit_effect_1~4 | **同名不同物**：2.5 三帧 vs 当前两帧（电磁炮审计 20260908）；且被 xmlClass9 敌方 33 处+碎裂炮爆发引用 | 回迁须**死名改绑**，不可原位替换；电磁炮家族已决策不回迁 |
| chipped_hit_effect | sub1130 现存 **3.4 版 7 帧** ≠ 2.5 版 8 帧（聚能轰击炮对比 20260908） | 全量回迁需死名改绑（先例：聚能轰击炮改绑 `bullet/blueness_energy`） |
| cutter_hit_effect | 2.5 六态细线切割 → 3.4/GH 三态宽线（高周波切割炮对比 20260909）；GH 又被 xmlClass8 大量共用 | 先例：高周波切割炮新建独立精灵 1985 + 死名改绑 `cut_effect` |
| positron_hit_effect | 该导出名已被响尾蛇回迁**占用改绑**（新精灵 1702 = 响尾蛇/调皮共用 2.5 橙爆），2.5 同名资源是正电子炮 15 帧特效，**同名不同物** | 勿按名引用；需用时走死名/新精灵方案 |
| boom_hit_effect2 / hot / laser | 未见家族级审计结论 | 迁移前需按家族单独逐帧比对 |

## 迁移通用注意

- 两版导出名同名不代表同物：**先逐帧像素比对（本包 PNG 即 2.5 侧基准），再决定改绑或导入**。
- 原位替换只允许在"确认当前版无其他引用"时进行；公共特效一律走"新精灵 + 配置死名改绑"。
- 标准流程见 `tmp-soya-family-test\武器特效导入标准流程.md`；正式仓库不直接做实验，先在测试包隔离验证。

## 提取与核对命令记录

```text
ffdec-cli.jar -export sprite <out> input\sub37.swf -select "<12 个导出名>"   # 注：该版 -select 未生效，导出后按 DefineSprite_<ID>_<名> 文件夹拣选
swf 头 CWS zlib 解压后核对 SymbolClass/Export 导出名清单（2.5 与 GH 各 12 项同名）
```
