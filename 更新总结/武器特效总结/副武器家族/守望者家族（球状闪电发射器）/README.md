# 守望者家族（球状闪电发射器）· 家族档案

> 建立日期：2026-09-09
> 分类：`武器特效总结\副武器家族\`（副武器 subArms 体系，资源包 sub1130.swf）
> 当前状态：✅ 全项 2.5 回迁 + shootPoint 右移 30px 已构建入库（2026-09-09）——射速 1.9 / 锁敌 / energy / 青白爆受击 / LV1~3 光晕层 / 出生点右移解遮挡；LV4/LV5 光晕扩展经实测撤销（闪屑投影为每级专属美术）；待实机确认

## 家族基本信息（GitHub 版配置）

- **arms id**：`lightningBall`（`<father>sub</father>`，index 3）
- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`
- **武器类型**：球形闪电发生器；`attackType=boom`；`specialProperty=跟踪`
- **资源包**：本体与子弹在 `sub1130.swf`（2.5 为 `sub37.swf`，3.4 为 `sub52.swf`）

## 形态结构（GitHub 版，5 级）

| 等级 | 名称 | 本体 imgLabel | 子弹 bulletImgLabel | 受击 hitImgLabel |
|---|---|---|---|---|
| LV1 | 守望者 | `lightningBall_lv1` | `sub/lightningBall_lv1_bullet` | `bullet/purple_energy` |
| LV2 | 捍卫者 | `lightningBall_lv2` | `sub/lightningBall_lv2_bullet` | `bullet/purple_energy` |
| LV3 | 驱逐者 | `lightningBall_lv3` | `sub/lightningBall_lv3_bullet` | `bullet/purple_energy` |
| LV4 | 审判者 | `lightningBall_lv4` | `sub/lightningBall_lv4_bullet` | `bullet/purple_energy` |
| LV5 | 制裁者 | `lightningBall_lv5` | `sub/lightningBall_lv5_bullet` | `bullet/purple_energy` |

> 注：五级受击在 GitHub 版配置中统一调用 `bullet/purple_energy`（bullet.swf）；2.5 / 3.4 的调用是否一致，待对比确认。

## 参考版本入口

- **2.5**：`原版\2.5（原版参考）\2.5版本素材库\export\weapons\副武器（sub）\`（来源 `sub37.swf`）；配置 `raw\xml\subArms37.xml`
- **3.4**：`原版\3.4（原版参考）\`（素材库 + 代码库；副武器 SWF 为 `sub52.swf`）
- **11.3 / GitHub 原型**：`超合金素材汇总\`

## 对比协议（本家族任务执行约定）

1. 对比版本由用户逐次指定；对比过程**只读，禁止修改**。
2. 对比四项：① 射速 / 子弹分散 / 子弹速度（B1/B2/B4）；② 子弹贴图 / 受击特效（A3/A5）；③ 待机与开火状态 / 枪口火焰（A1/A2/A6）；④ 新增形态与中间版本映射——**完全听用户安排，不自行推断**。
3. ⚠️ 副武器本体时间轴内的 `basePoint`/`shootPoint` 命名挂点在 FFDec 帧导出里渲染为醒目标记，实机被 `SWFLoaderManager` 隐藏（visible=false + 缩 0.1）——不代表任何版本的实机观感，不是美术本体，回迁时不搬运（见 `..\README.md` 通用教训）。

## 文档清单

- **守望者家族回迁工作流程总结-20260909.md**：本家族从立项到提交的九步标准流程沉淀（后续副武器家族模板）。
- **守望者家族全项2.5回迁执行总结-20260909.md**（先读）：用户决策全复原 2.5——①attackGap 2.9→1.9 ×5 ②跟踪→锁敌 ×5（仅提示文本，零行为风险）③attackType boom→energy ×5（伤害克制表生效；研发材料风味 boom→buncher，数值按禁令不动）④受击改绑 `sub/energy_hit_effect` 青白爆 ×5（零资源成本）⑤LV1~3 本体时间轴整段换 2.5 模板（depth2 发光本体层找回；闭包 35 项新 ID 1993-2029；挂点 110→104 矩阵强制；开火音重绑 946）。**回迁后 LV1~3 vs 2.5 全 12 帧 0 差异**；29 符号回归复核零变化；构建退出码 0 + 配置回读断言全 PASS + 双自检通过；旧资源备份齐。
- **shootPoint 右移 30px（2026-09-09 补充决策，同文档五之二节）**：用户实测子弹出生点罩住枪口火焰（三版皆然的固有几何：出生点 (51.6,20) ≈ 火焰亮核中心 (58,19)）。模拟三档对比（`开火模拟_偏移对比.gif`）后选定 **Δ=+30px**——五级 shootPoint translateX 各 +600 twips（1032/1400/1688/2042/2042 → 1632/2000/2288/2642/2642）。语义级断言全文内容差异恰 5 处、回读 PASS、内容回归 PASS（排除 fileOffset/nTranslateBits 元数据）；sub1130=`23861F61` 三处同步+manifest 更新；构建退出码 0（game.swf=26DDE359 不变属正常）+ 双自检通过。连带：子弹出生点前移 30px（实战无感）+ 挂载遮罩自动加宽（火焰拖尾被裁更少，加分）。脚本 `lightningball_shootpoint_shift.py`、检查图 `守望者shootPoint与枪口火焰对比图-20260909.png`。
- **守望者家族2.5-3.4-11.3对比审计-20260909.md**：回迁前的三版本只读审计（四项差异证据链）。
- **电弧音音量提升实验-20260909.md**：`lightningBall_lightning` ×4 音量实验（OneBulletBody 调用点，仍在生效，待实机判定）。
- 对比图/证据图 9 张（三版本逐帧、光晕放大与特写、受击对比、回迁后对比等）。
- 隔离工作区：`tmp-soya-family-test\lightningball-3ver-audit\`。
