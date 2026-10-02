# 11 原子塔 · 路径索引

> 本夹档案：`原子塔-档案-20260929.md`（设计 Boss：1-1-5 神秘研究所）。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI 三件套：`gamefile\scripts\enemy\atomicTower\`——AtomicTowerBody.as / AtomicTower_AI.as / AtomicTowerAAHD.as
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 27, id=AtomicTower**
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 10008**（原子塔-声波炮，3 armsLevel，boom/angle 180/hurt 0.4）
- Boss 标记：关卡表 `17_EmbedXml_xmlClass11_….bin` → 1-1-5 `boss="原子塔"` ＋ unit `type="boss"`
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"原子塔"，顺序数组第 11 位）

## 资源

- 当前仓：`swf\AtomicTower.swf`（SHA-256 前8 `F1802AA8`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\AtomicTower.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\AtomicTower.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\原子塔\`
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案（含用户批注"新版本至少删减一半介绍/升级版原子反应堆"）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- **原子反应堆** `AtomicTower2`（表 index 28，升级版；素材夹 `..\..\..\原版\11.3超合金素材汇总\双层原子塔\`）——到其图鉴位时立档互链
