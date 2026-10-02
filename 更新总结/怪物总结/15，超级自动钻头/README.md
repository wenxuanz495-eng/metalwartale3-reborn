# 15 超级自动钻头 · 路径索引

> 本夹档案：`超级自动钻头-档案-20260929.md`。全部相关路径集中于此，便于直接调用。
> ⚠️ 双名：图鉴"超级自动钻头"＝敌人表"超级自动钻机"。

## 代码（仓库 `decompiled\`）

- AI 五文件：`gamefile\scripts\enemy\drilling\`（与 14 共用目录）——**DrillingBody2.as（140 行）为本怪专属身体类**（伸缩机构载体）、Drilling2_AI.as（46 行）；DrillingBody/Drilling_AI/DrillingAAHD 归 14
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 15, id=Drilling2**（表内 name=超级自动钻机）
- 敌方武器表：**无定义**（伸缩钻杆长行程扎击，动画判定层）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"超级自动钻头"，顺序数组第 15 位）

## 资源

- 当前仓：`swf\Drilling2.swf`（SHA-256 前8 `A5CB2F05`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Drilling2.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Drilling2.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\钻机1\`（23 帧同构，帧图核实；含紫色分节钻杆帧 47.jpg——伸缩钻杆贴图）
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`（伸缩连接装置/攻击范围提升）
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- `..\14，悬浮自动钻头\`（Drilling，同模：唯一差异 nextAttack 2→3，"超级"命名相悖疑点记录在双方档案）
