# 星际雷神家族 · 家族档案

> 立项日期：2026-09-15（副武器第十六家族）
> 当前状态：✅* **皮肤＋发射特效＋发射动画四段式重构已构建入库待实测（2026-09-17，V9）**——先读 `星际雷神家族皮肤与发射特效替换执行总结-20260917.md`（V1~V9 全程）。V9 现状：**16 帧四段式时间轴**（待机→发射[可见飞出导弹+尾焰+特效+音]→弧暴露+装填等待→滑动装填），弧常驻最底层不再即时生成；lv1 白球对准红核（左移 3px）；**bulletTranslation 对齐待机弹距**（lv1 13.75/lv2 14.5，config=18842298，出膛双弹与待机双弹平行）；累计新 ID 2900~2935；零形态、弹速未动；V10/P0＝攻击弹×0.75＋出膛点/散布对齐缩后行线（bulletTranslation lv1=10.5/lv2=11.05）；V11＝三组子弹统一同一 Y 行线（待机弹/飞出弹/真弹，根因=飞弹左上角错锚已修）；V12＝飞出导弹层序弧上枪下＋真子弹可见中心对齐逻辑原点（上移半弹高）；V13＝最终层序（部件2 最底层→火焰→子弹→本体→特效顶层）；V14＝删动画飞弹链（真子弹唯一可见出膛弹）＋lv1 真弹对位贴图弹（tran=11.5）；V15＝f4 起飞弹 1 帧补出膛连贯（真子弹 attackDelay 后接管）；V16＝attackDelay=0＋发射帧 f2（真子弹与贴图弹消失同帧）＋弧/焰层序纠正＋焰清除补齐（修焰残留）；V17＝修时间轴双帧边界bug(28→16帧边界,装填滑动首次可见)＋特效d10顶层确认；V18＝lv2 特效链换 星际雷神特效1~4（2936~2943）；V19＝lv2 特效回退 新特效1~5（用户澄清资产指向）；V20＝节奏重组（峰值3tick/残段即清/焰各2tick）；sub1130=FDB0B139、config=0D8AC183、game.swf=B361F8F8；构建 0＋双自检 0。**本家族为当前版独有，旧版均无此武器**，无旧版回迁面。
> 家族定位：`boom/爆裂`＋`跟踪` 型副武器（中子飞弹发射器，双联装）——"能同时发射两枚追踪飞弹，爆炸时以高能中子杀伤敌方大量目标"（两级 description 原文）。

## 家族基本信息（已核实）

- **arms id**：`zhongzifeidan`（subArms 配置 index=2；块位于 `6_EmbedXml_xmlClass7_...bin` 文件末尾，前一块为黄金鞭炮 `Goldbanger` index=4）
- **攻击属性**：`attackType=boom`，`specialProperty=跟踪`，特有字段 `followB=2`（追踪参数，两级统一）
- **形态（当前版两级）**：星际雷神（lv1，commonLevel 200）/ 星际雷神MK2（lv2，commonLevel 220），本体 `imgLabel=zhongzifeidan_lv1/lv2`
- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`（zhongzifeidan 块）
- **子弹**：`bulletImgLabel=sub/zhongzifeidan_lv1_bullet`（**两级共用 lv1 弹**）
- **受击（当前版）**：`hitImgLabel=bullet/purple_boom`（两级统一）
- **数值现状（当前版，两级统一）**：`attackGap=0.4`、`attackDelay=0.1`、`bulletNum=2`（双发）、`bulletSpeed=12`、`bulletMaxV=30`、`bulletLife=2.5`、`bulletWidth=7`、`hurt=80`、`energyUse=10`、`recoilValue=2`；`bulletTranslation` lv1=10 / lv2=8
- **经济现状**：`price=80000000`、`mustLevel=150`、`mustItems=boom_7_num8000,superalloy_num8000,superalloy_Z_num4000,superalloy_X_num2000,superalloy_Y_num500`、`Mprice=100`（两级相同；经济字段按用户禁令不动）
- **符号速查（当前 `swf\sub1130.swf` SymbolClass 实测，全库 253 符号）**：`zhongzifeidan_lv1`=121、`zhongzifeidan_lv2`=115、`zhongzifeidan_lv1_bullet`=100
- **弹速清单状态**：`docs\baselines\玩家武器弹道速度分类与进度.md` "其余武器"段——星际雷神 / 星际雷神MK2 基准弹速=当前弹速=12，状态"已完成-降速2.5倍"；立项核查当前配置 `bulletSpeed=12` 与清单一致
- **立项时点资源快照（2026-09-15，随后续任何家族工作变动）**：sub1130=4784C902、xmlClass7 配置=8B6C5E51（sha256 前 8 位）

## 立项预检（GH 当前版内部核查，只读）

- **无旧版对比面**：用户确认旧版均无此武器，本家族不适用"三版本对比/回迁"流程；后续工作（若有）只能是当前版内部修订或新特效制作，届时流程按 `..\..\通用\武器特效导入标准流程.md` 执行。
- **配置与资源一致性**：配置引用的三个 imgLabel（lv1 本体 / lv2 本体 / 共用弹）在 `swf\sub1130.swf` SymbolClass 中全部存在，无死引用。
- **形态命名**：MK2 后缀两级，同黄金鞭炮 / 灰狐 / 火花 / 上帝之杖等当前版独有家族的命名模式。
- **索引注意**：xmlClass7 中 `index` 字段跨 id 重复出现（Boomcannon 与本家族同 index=2，Goldbanger 与 tianjidiancipao 同 index=4）——index 非全局唯一键，检索与改动一律以 `id` 为准。

## 已知注意事项（沿副武器阶段通用教训）

- **开火音效 108 共用**：音 108 同时挂 `zhongzifeidan_lv1/lv2` 与 `killPig_lv1`（#551）——本家族动开火音时不得原位改数据，须走新增音效 ID（先例：响尾蛇家族回迁）。
- **`bullet/purple_boom` 为共用受击名**：主武器 XML（xmlClass3）另有 9 处引用＋本家族 2 处——受击若改动严禁原位重建，须死名改绑新 ID。
- 副武器本体时间轴内的 `basePoint`/`shootPoint` 挂点实例与红色挂点标记不是美术，实机均被 `SWFLoaderManager` 按名隐藏，勿计入差异、勿作为修改对象（见 `..\README.md` 通用教训节）。
- 经济字段（price/mustItems/Mprice 等）按用户禁令不动。
- 改弹速前必读 `docs\guides\AI武器弹速维护提示.md` 并同步 `docs\baselines\` 名单（本家族弹速已完结，当前无需动作）。

## 本家族文档索引

| 文件/目录 | 内容 |
|---|---|
| 星际雷神家族皮肤与发射特效替换执行总结-20260917.md | **先读**：皮肤＋发射特效整体替换（V1 四段式＋第五节 V2 修订；含 ID 勘误与待实机清单） |
| 预览-sprite121-逐帧.png / 预览-sprite115-逐帧.png | V1 逐帧重放预览 |
| v2预览-sprite115-逐帧.png / v2预览-sprite121-逐帧.png / v2三联对照.png | V2 逐帧预览与"发射后｜V2 合成｜完整参考"三联对照 |
| zzzd_skin_import.py / zzzd_skin_v2_lv2.py | V1 导入脚本与 V2 修订脚本（断言齐全） |
| 备份-被替换的旧资源-20260917/ | 旧 sub1130（5445301E） |
| 工作区（不入库） | `tmp-zzzd-skin-20260917\`（底稿 XML/输入素材/报告） |

## 归档规则

按 `副武器家族\README.md`：总结命名 `主题-YYYYMMDD.md`；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README（`..\README.md` 家族清单表＋`..\..\各家族变更档案.md` 对应小节）。
