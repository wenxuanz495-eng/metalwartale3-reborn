# 6.1 风隼战机 · 路径索引

> 本夹档案：`风隼战机-档案-20260929.md`（图鉴外变体，父＝06 天隼战机）。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI：`gamefile\scripts\enemy\` 无独立 fengsun 目录——飞行怪通用 AI 体系复用（enemy\AI\Enemy_AI 系）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 90, id=fengsunzhanji**（纯拼音 id）
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 1000105**（`投弹`，energy/bullet/angle 90/hurt 3/gap 0.1）
- 图鉴：**无条目**（BookUI 82 条数组无此项；编号 6.1 系用户裁定）

## 资源

- 当前仓：`swf\fengsunzhanji.swf`（SHA-256 前8 `8F962A16`，**仅当前存在**＝11.3 新增，无 2.5/3.4 原件）
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\风隼战机\`（夹名一致；本体帧 6.png 118x44）
- 图鉴图标：无（图鉴缺位）

## 文档与数据

- 图鉴文案：**docx 亦无本怪条目**（世界观源文档同样缺位）
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（"仅当前存在"组）
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（本怪不在清单）

## 家族关联（四隼＋1）

- `..\5，游隼战机\`（四隼家族总表）／`..\6，天隼战机\`（父单位：同机身红饰、投弹 boom 0.5×3 连发）
- 猎隼战机 SakerFighter（index 20，1-2-3 Boss）——到其图鉴号（第 27 位）时立档互链
