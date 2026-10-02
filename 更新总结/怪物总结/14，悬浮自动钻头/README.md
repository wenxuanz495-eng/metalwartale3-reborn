# 14 悬浮自动钻头 · 路径索引

> 本夹档案：`悬浮自动钻头-档案-20260929.md`。全部相关路径集中于此，便于直接调用。
> ⚠️ 双名：图鉴"悬浮自动钻头"＝敌人表"自动钻机"。

## 代码（仓库 `decompiled\`）

- AI：`gamefile\scripts\enemy\drilling\`（与 15 超级自动钻机共用目录）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 14, id=Drilling**（表内 name=自动钻机）
- 敌方武器表：**无定义**（接触钻击）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"悬浮自动钻头"，顺序数组第 14 位）

## 资源

- 当前仓：`swf\Drilling.swf`（SHA-256 前8 `2C7F810A`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Drilling.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Drilling.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\钻机\`（23 帧同构；哈希因重编码与 ffdec 导出零重合，帧图已目视核实＝本怪）
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`（陆地突击型/高速转动钻头/破坏装甲）
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- `..\15，超级自动钻头\`（Drilling2，同模进化对：唯一差异 nextAttack 2→3）
