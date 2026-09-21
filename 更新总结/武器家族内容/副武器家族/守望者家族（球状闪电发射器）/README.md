# 守望者家族（球状闪电发射器）· 家族档案

> 建立日期：2026-09-09
> 分类：`武器家族内容\副武器家族\`（副武器 subArms 体系，资源包 sub1130.swf）
> 当前状态：✅ 全项 2.5 回迁 + shootPoint 右移 30px + 开火音效对齐火焰帧（f3→f5）已构建入库（2026-09-09）——射速 1.9 / 锁敌 / energy / 青白爆受击 / LV1~3 光晕层 / 出生点右移解遮挡 / 音效火光同帧；LV4/LV5 光晕扩展经实测撤销（闪屑投影为每级专属美术）；待实机确认
> ⚠️ 事故与恢复（2026-09-15）：上述 shootPoint+30px 与开火音 f5 两项曾被 09-10 炽天使导入（陈旧底稿）静默回退，已在当前底稿重放恢复（sub1130=**2F422962**，五级本体与完好态 8D885B69 结构全等），详见 `..\..\..\bug 维护\3.0前瞻版本bug维护\守望者两项已入库改动被炽天使导入静默回退-20260915.md`
> ✅ LV4/LV5 碎屑三帧已导入并升级为 LV1 同款全周期脉冲（2026-09-15，画师图特效1/2/3 按强度档轮换，含 ADD 闪白与 GLOW 辉光；火焰回归 depth4 排布；颜色原样零改写）——sub1130=**4784C902**，待实机确认，详见 `LV4LV5碎屑三帧-画师素材分析-20260915\`

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

## 文件夹结构与文档清单（2026-09-15 重组：复古任务 / 新加特效 分管）

> 全程工作过程记录：[守望者家族工作过程总结-20260915.md](守望者家族工作过程总结-20260915.md)

### `特效复古任务\`——2.5 复古回迁任务（20260909 起）

- **守望者家族回迁工作流程总结-20260909.md**：九步标准流程沉淀（后续副武器家族模板）。
- **守望者家族全项2.5回迁执行总结-20260909.md**（先读）：全项复原 2.5 的决策与执行（射速/锁敌/energy/青白爆受击/LV1~3 本体时间轴，回迁后 vs 2.5 全 12 帧 0 差异）。
- **开火音效起始帧 f3→f5 / shootPoint 右移 30px**：两项补充决策（同执行总结五之二、三节），脚本 `lightningball_sndf5.py` / `lightningball_shootpoint_shift.py`。⚠️ 曾被炽天使导入静默回退，09-15 重放恢复（见 bug 维护区）。
- **守望者家族2.5-3.4-11.3对比审计-20260909.md**：回迁前三版本只读审计。
- **电弧音音量提升实验-20260909.md**：×4 音量实验，待实机判定。
- **lightningball_lost_restore.py**：两项丢失改动重放恢复脚本（底稿哈希断言 + 五级全等回读）。
- **备份-被替换的旧资源-20260909\** 与对比图/证据图 13 张。

### `LV4LV5碎屑三帧-画师素材分析-20260915\`——新加特效任务（20260915 起）

- 素材交接包、导入前分析（结构同构/交付图对位）、**导入执行总结**（含修订轮：全周期脉冲）、导入脚本两枚、导入后 12 帧实渲染图与对位预览 14 张；交付图在工作区 `相关素材\守望者\`。

### 其他

- 隔离工作区：`tmp-soya-family-test\lightningball-3ver-audit\`（已入冷备）。
