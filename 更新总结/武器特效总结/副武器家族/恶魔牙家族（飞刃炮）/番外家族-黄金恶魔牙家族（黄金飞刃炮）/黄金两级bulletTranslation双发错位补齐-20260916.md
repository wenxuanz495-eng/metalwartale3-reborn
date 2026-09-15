# 黄金两级 bulletTranslation 双发错位补齐执行总结 - 20260916

## 一、目标

用户问题核查结论：飞刃炮双发是**真实双发**——配置 `bulletNum` 驱动 `ArmsAttack.as:57` 循环，每圈独立生成一颗子弹对象（各自碰撞各自判定），`bulletTranslation` 决定多发间的垂直错位距离（`ArmsAttack.as:118-124`，两发时 ±translation/2×2=±6px 上下错位，`angleRange` 未配=平行飞行）。

发现：恶魔牙本系 lv2~lv6 均为 `bulletNum=2 + bulletTranslation=6`（上下两颗可见），而 **goldflyBlade 两级虽有 `bulletNum=2` 却缺 `bulletTranslation`（`Number(缺省)`=0）→ 两颗子弹同点同角度完全重叠，观感一发、实质双倍判定**。用户指示：补上该字段，让黄金版双发像本系一样可见。

## 二、实际修改

`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`，goldflyBlade 块内两级 `<bulletNum>` 行后各插入一行 `<bulletTranslation>6</bulletTranslation>`（与 flyBlade lv2~lv6 同值同位置格式，变长 +88 字节，291786→291874）：

| 级 | bulletNum | bulletTranslation |
|---|---|---|
| 黄金恶魔牙（goldflyBlade_lv1） | 2（不动） | 无 → **6** |
| 黄金撒旦之力（goldflyBlade_lv2） | 2（不动） | 无 → **6** |

安全断言：锚串全文件恰 2 处且均落 goldflyBlade 块内（偏移 116574/118349，块 115640~119207）；按锚回换可精确还原原文件；全库 `<bulletTranslation>6<` 计数 +2；flyBlade 本系六级（1/无、2/6×5）复核原样；config bin SHA-256 **8B6C5E51… → 0132FFE9…**（0132FFE96A7D72254F37978BAE3435198DEA500B681BC469E0D1E40249317251）。该 bin 不在 current-resource-manifest 管辖（沿射速对齐先例），补丁清单不含 XML 配置（构建直接重嵌入）。

备注：黄金 lv1 双发（本系 lv1 单发）为既有设计（20260914 射速对齐总结"待实机项 2"记录在案），本次仅做双发**可见化**，不改每击弹数。

## 三、构建与验证

- `构建.bat` 退出码 0；`build\game.swf` 再生 = **E2ADE35C**7848CE765E04636A3A5AB2B82986B6D4FEAB6F76A60E1D91CC28BA7A（原 C07CAC3E…）；
- FFDec 导出 game.swf 内嵌 binaryData 回读：`6_EmbedXml_xmlClass7` 与修改后 bin **SHA-256 字节级一致**（0132FFE9…）；内嵌内容实测两级 `bulletNum=2 + bulletTranslation=6`、flyBlade 本系 `bulletTranslation` 计数 5 原样；
- `scripts\launch_game.bat --check sa` / `--check sa_debug` 双自检退出码均 0；`sub1130.swf`（E7164ABF）本批未动。

## 四、待实机确认项

1. 黄金恶魔牙 / 黄金撒旦之力开火：应见上下两颗金色子弹（±6px 错位、平行飞行），不再是单颗；
2. 双发命中：两颗子弹各自独立判定（本即如此），伤害感知应与补齐前一致（DPS 不变，只是从重叠变可见）；
3. 回归：恶魔牙本系 lv1 单发、lv2~lv6 双发观感不变。
