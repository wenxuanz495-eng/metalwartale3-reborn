# 04 自爆蜘蛛机 · 路径索引

> 本夹档案：`自爆蜘蛛机-档案-20260929.md`。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI 四件套：`gamefile\scripts\enemy\spider\`——SpiderBody.as（146 行）/ Spider_AI.as（59 行，跳跃扑击＋每秒加速）/ SpiderAAHD.as / SpiderDefine.as
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 6, id=Spider**
- 敌方武器表：**无定义**（接触/扑击伤害）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"自爆蜘蛛机"，顺序数组第 4 位）

## 资源

- 当前仓：`swf\Spider.swf`（SHA-256 前8 `F1624010`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Spider.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Spider.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\小型爆炸机器人\`（⚠️ 夹名与怪名完全无关，已按帧图核实=本怪）
- 图鉴图标：BookUI760 内嵌 JPG（银色红细节，与实机一致）

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- `..\..\怪物总结\图鉴顺序-BookUI.json` 中"跳蚤机器人"前身＝老版本删减内容（2.5 素材库待考）
- `SpiderFort 蜘蛛炮台`（表 index 35，图鉴 17 位）为另一独立怪（素材夹 `..\..\..\原版\11.3超合金素材汇总\蜘蛛炮台\`），到其图鉴号时立档互链
