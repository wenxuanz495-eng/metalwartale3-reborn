# 12 碾压者 · 路径索引

> 本夹档案：`碾压者-档案-20260929.md`（设计 Boss：1-1-6 城市杀手）。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI 三件套：`gamefile\scripts\enemy\rolling\`——RollingBody.as / Rolling_AI.as / RollingAAHD.as
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 36, id=Rolling**
- 敌方武器表：**无定义**（接触碾压；imgList shoot_1/shoot_2 为碾压动作帧）
- Boss 标记：关卡表 `17_EmbedXml_xmlClass11_….bin` → 1-1-6 `boss="碾压者"` ＋ unit `type="boss"`
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"碾压者"，顺序数组第 12 位）

## 资源

- 当前仓：`swf\Rolling.swf`（SHA-256 前8 `7F255569`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Rolling.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Rolling.swf`
- 11.3 素材汇总：**无直接对应夹**（实机图需自 swf 导出）
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案（含用户批注"他有网页资料，但是我暂时打不开了"）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- 无同名/同 id 变体；1-1-23 的三台复用与 1-1-999(VIP) 出场详见档案出场清单
