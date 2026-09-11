# 斯巴达家族（弧光贯通炮）· 家族档案

> 立项日期：2026-09-11（主武器第十七家族）
> 当前状态：✅* **子弹缩放位移已执行入库待实测（2026-09-11）**——先读 `斯巴达家族工作总结-20260911.md`（家族总入口：全流程叙事与经验沉淀），参数细节见 `斯巴达子弹缩放位移执行总结-20260911.md`：v3 矩阵 scale 0.65 + translateX 1180（59px），新弹 146×33 可见亮斑起点=100.0 正对枪口（按位图像素实测局部 x−108 锚定），光斑亮核（中心 81.45）全程可见；相对最初版内容差异仅 1 行 XML，arms1100 哈希 D1184767…，三处同步＋manifest 已更新，`--check sa` 通过。前置定位：`斯巴达3.4与当前版对比总结-20260911.md`（特效链路与 3.4 零差异，"缺焰"＝弹尾遮挡而非资产丢失；子弹保留新版设计；配置差 recoilValue 1→10＋penetrationB 当前独有）。
> 用户指令边界（2026-09-11）：①本武器 3.4 版本才开始有，**不检查 2.5**；②**新版本（GitHub 版）的子弹要保留**；③用户目前观察到的缺口为**蓄力特效与枪口火焰**（新版本没有；具体表现细节待用户进一步说明后再展开对比）。

## 家族基本信息（已核实）

- **arms id**：`arc`（主武器配置 index=56）
- **武器名称/类型**：斯巴达 / 弧光贯通炮
- **攻击属性**：`attackType=energy`；`specialProperty=成长型，穿透`（3.4 为"成长型"，GH 追加"穿透"）；`specialType=Level_Growth_35`（成长型单形态）
- **形态**：单形态 lv1（斯巴达），无多级形态；`commonLevel=90`
- **配置位置**：
  - GitHub：`decompiled\embedded-xml-assets\2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin` 的 `<arms index="56" id="arc">` 块
  - 3.4 参考：`原版\3.4（原版参考）\3.4代码库\reference-binary-data\12_arms61_xml$….bin` 同名块
- **资源包**：`arms1100.swf`（主武器体系）；导出名 `arc_lv1`（本体）、`arc_lv1_bullet`（子弹）；配置无 `smokeImgLabel`
- **受击**：两版配置 `hitImgLabel` 同为 `bullet/blue_energy`
- **关键数值（两版一致）**：`attackGap=0.1`、`bulletSpeed=30`、`hurt=2210`、`bulletWidth=10`、`energyUse=24`、`bulletNum=1`
- **已知配置差异（GH vs 3.4）**：`recoilValue` GH=10 / 3.4=1；GH 独有 `penetrationB=1`
- **获取路径（GH）**：等级礼包武器，`GameData.migrateClaimedLevelGiftWeapons()` 中 `needSparta` → `armsItems.addItems("arc_lv1",true)`（与 2013/snow 同路径）

## 符号 ID 速查（证据等级 B）

| 导出名 | 3.4 (arms52.swf) | 当前 (arms1100.swf) | 备注 |
|---|---|---|---|
| arc_lv1 | 25 | 541 | 两侧 ABC 类桩均存在（3.4 类源码见 `3.4代码库\assets\scripts\arc_lv1.as`，纯挂点容器，无蓄力逻辑） |
| arc_lv1_bullet | 20 | 536 | 子弹两版完全不同：3.4 矢量 129×44 vs GH 矢量 225×50；**按用户指令保留 GH 版** |

- 挂点：`basePoint` / `shootPoint`（GH 实测 translate 367,200 / 2224,275）
- 3.4 侧资源来源：`原版\3.4（原版参考）\3.4游戏\swf\arms52.swf`；素材检索入口 `3.4素材库\export\weapons\主武器\`

## 注意事项

- ⚠️ 光刃炮家族 README 已注明：`arc` 与 `edge`/`snow`/星座系列同为独立 arms，**不并入光刃炮家族**，本家族独立建档。
- 受击名 `bullet/blue_energy` 与等离子家族先例 `bullet/blueness_energy` 是**两个不同名字**，勿混淆；后续若涉受击回迁，先全域核查占用。
- 挂点通用教训适用：`basePoint`/`shootPoint` 是功能锚点不是美术，不构成版本差异、不作回迁对象。

## 工作区与文档索引

| 文件/目录 | 内容 |
|---|---|
| **斯巴达家族工作总结-20260911.md** | **家族总入口**：立项·对比·遮挡定位·三轮调参全流程叙事与经验沉淀 |
| 斯巴达3.4与当前版对比总结-20260911.md | 只读对比：配置全字段 diff、时间轴逐帧对比、位图/受击/音效像素与 MD5 对比、遮挡定位结论（第七节） |
| 斯巴达子弹缩放位移执行总结-20260911.md | **先读（最新）**：sprite536 矩阵修订记录（v1 ×0.9+165px → v2 ×0.75+114px → v3 ×0.65+59px 亮斑正对枪口）、验证链与哈希 |
| 斯巴达3.4与当前版美术对比图-20260911.png | 本体/光斑/受击六行左右对照图（两列零差异；子弹差异未入图） |
| 斯巴达子弹缩放位移前后对比图-20260911.png | 生成帧几何对比图（v2 上版 vs v3 本版，亮斑起点对准枪口） |
| 备份-被替换的旧资源-20260911/ | 旧 arms1100（9B02AAF0…）与回滚说明 |
| `tmp-soya-family-test\sparta-arc-audit-20260911\` | 对比证据工作区（XML 导出、位图/形状/音效导出、比对脚本） |
| `tmp-soya-family-test\sparta-bullet-shift-20260911\` | 缩放位移工作区（原始/修改 XML、output SWF、回读校验） |

## 归档规则

按 `..\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README。
