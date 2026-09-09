# 碎裂炮家族 · 家族档案

> 立项日期：2026-09-10（副武器第九家族）
> 当前状态：✅ **2.5 真实差异层回迁已构建入库待实测（2026-09-10）**——先读 `碎裂炮家族2.5回迁执行总结-20260910.md`：①lv1~lv5 本体时间轴整段回 2.5（蓄力发光层恢复；83 项闭包导入新 ID 2338~2420）②开火音 562 克隆为 2421 挂第 4 帧 ③受击零成本改绑 `bullet/blueness_energy` ④attackGap 1.4→0.9；**attackType=boom 按用户决策保留**，经济字段/reduceRa 未动。**回迁后五级本体全 75 帧 vs 2.5 渲染逐像素 0 差异**；sub1130=F0FACDBF、config=B7C53424、game.swf=B5095438；构建退出码 0＋BinaryData 回读全 PASS＋sa/sa_debug 双自检通过。前置：`碎裂炮家族2.5与当今版对比总结-20260910.md`。
> 家族定位：`boom/爆裂` 型副武器——"利用能量压缩技术，将超高能量压缩成球体，当发生碰撞后会发若干小型能量炮"（五级 description 原文）。

## 家族基本信息（已核实）

- **arms id**：`chipped`（subArms 配置 index=7；2.5 `subArms37.xml` 同 id 同 index=7）
- **攻击属性**：`attackType=boom`，`specialProperty=爆裂`，`reduceRa=0.7`（五级统一）
- **形态（当前版五级）**：挑战者（lv1）/ 粉碎者（lv2）/ 征服者（lv3）/ 终结者（lv4）/ 主宰者（lv5），本体 `imgLabel=chipped_lv1~lv5`
- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`（chipped 块）
- **子弹**：`bulletImgLabel=sub/chipped_lv1~lv5_bullet`（逐级独立，2.5 与当前配置一致）
- **受击（当前版）**：`hitImgLabel=bullet/blue_boom`（五级统一）
- **数值现状（当前版）**：`attackGap=1.4`（五级统一）、`bulletSpeed=35/35/35/35/25`、`bulletWidth=10/13/17/20/20`

## 立项预检线索（只读核对 2.5 subArms37.xml，未做全面对比；正式对比时映射与范围按用户安排）

- **形态**：2.5 五级与当前版五级**名称一一对应**（挑战者/粉碎者/征服者/终结者/主宰者），暂无新增形态迹象；3.4 侧（`subArms52`）尚未核对。
- **配置差异（2.5 vs 当前，字段级已核对）**：
  - `attackType`：2.5 `mixed` → 当前 `boom` ×5（同多米诺 mixed→motion 的方向性改动，注意克制表/分裂行为可能随之变化，待行为核实）
  - `attackGap`：2.5 `0.9` → 当前 `1.4` ×5（同响尾蛇/调皮/战殇/多米诺"GH 射速改慢"模式）
  - `reduceRa`：2.5 `0.6` → 当前 `0.7` ×5
  - `hitImgLabel`：2.5 裸名 `chipped_hit_effect` → 当前 `bullet/blue_boom`（整套更换）
  - `bulletSpeed`/`bulletWidth`/`bulletImgLabel`：2.5 与当前**一致**（35×4+25；10/13/17/20/20；逐级独立弹）
- **受击回迁资源提示**（来自 `武器特效总结\2.5受击特效提取-20260909` 包结论）：`chipped_hit_effect` **同名不同物**——2.5 版 8 帧（char 1632），当前 `sub1130.swf` #1424 为 3.4 版 7 帧；回迁**不可原位替换，须死名改绑**（先例：聚能轰击炮家族改绑 `bullet/blueness_energy`）。
- **爆裂分裂机制待核实**：配置块内无 `motion_hit_effect` 引用，"碰撞后发若干小型能量炮"走运行时代码；电磁炮家族审计记录"当前版 `motion_hit_effect_1~4` 仍被 xmlClass9 敌方 33 处＋**碎裂炮爆发**引用"——若涉及该公共受击特效，严禁原位替换，正式对比阶段核实引用入口。

## 已知注意事项（沿副武器阶段通用教训）

- 副武器本体时间轴内的 `basePoint`/`shootPoint` 挂点实例与挂点标记不是美术，三版实机均隐藏（`SWFLoaderManager` 按名隐藏），勿计入版本差异、勿作为回迁对象。
- `mixed→boom` 的 attackType 差异属于**行为字段**而非纯视觉，是否回迁需用户决策，并注意 HurtCount 克制表与爆裂分裂的联动。
- `chipped_hit_effect` 命名与本家族 id 同名，但它同时是被多家族共用的公共受击特效名（聚能轰击炮 2.5 侧曾引用），处理时先全域查引用再动手。

## 本家族文档索引

| 文件/目录 | 内容 |
|---|---|
| 碎裂炮家族2.5回迁执行总结-20260910.md | **先读**：回迁执行（83 项闭包导入＋时间轴替换＋开火音 2421 挂 f4＋受击零成本改绑＋射速 0.9；含验证链全表与勘误） |
| 碎裂炮家族2.5与当今版对比总结-20260910.md | 前置只读对比（元素键 A/B/C 全项；注意其"开火音 GH 无"已在该文勘误，实为音 414 被换） |
| chipped_restore_merge.py / chipped_config_patch.py | 合并脚本与配置补丁脚本 |
| 碎裂炮本体待机两版对比图-20260910.png 等 5 张＋碎裂炮回迁前后对比图-20260910.png | 对比与回迁证据 |
| 备份-被替换的旧资源-20260910/ | 旧 sub1130（0FA29E97）、旧配置 bin（B7A78A06） |
| 工作区（不入库） | `tmp-soya-family-test\chipped-25-gh-audit\`（两版/回迁后渲染与像素比对） |

## 归档规则

按 `副武器家族\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README。
