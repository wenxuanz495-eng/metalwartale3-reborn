# 08 鸵鸟战机 · 路径索引

> 本夹档案：`鸵鸟战机-档案-20260929.md`。全部相关路径集中于此，便于直接调用。
> ⚠️ 双名：图鉴"鸵鸟战机"＝敌人表"鸵鸟机器人"。

## 代码（仓库 `decompiled\`）

- AI 两文件：`gamefile\scripts\enemy\ostrich\`——OstrichBody.as（155 行，身体/受击/死亡）、Ostrich_AI.as（26 行，hoverAndAttack 节奏）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 24, id=Ostrich**（表内 name=鸵鸟机器人）
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100029**（鸵鸟机器人-火神炮，boom/bullet/angle 5/hurt 0.3/shootNum 4；双 armsLevel 数值相同＝冗余）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"鸵鸟战机"，顺序数组第 8 位）

## 资源

- 当前仓：`swf\Ostrich.swf`（SHA-256 前8 `039E6832`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Ostrich.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Ostrich.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\鸵鸟机器人1\`＋`鸵鸟机器人2\`（两夹并存）
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案（含用户批注"第九舰队 vs 陆军常见"矛盾）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- `Ostrich_S 鸵鸟-S机器人`（表 index 85，Boss 级变体，图鉴第 58 位）——到其图鉴号时立档互链（当前仓 `swf\Ostrich_S.swf`，仅当前存在/11.3 新增）
