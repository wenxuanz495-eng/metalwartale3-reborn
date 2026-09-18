# 备份说明（2026-09-09 电磁炮 2.5 回迁执行前原件）

- `sub1130.swf-原版b8854b9a.swf`：回迁前的 sub1130.swf（SHA-256 前 8 位 b8854b9a），三处（swf\、build\swf\、runtime\swf\）替换前均为此版本。
- `6_EmbedXml_xmlClass7.bin-原版.bak`：回迁前的副武器配置 bin（lv1 attackGap=1.4、recoilValue=6 时代）。
- 本次移除的孤儿资源：形状 1400/1402、位图 1399（旧四级共用子弹贴图，回迁后无任何引用、无导出名绑定）——其完整数据包含在上面的 sub1130 原版 SWF 内，可用 FFDec 提取恢复。
- 回滚方法：将两个原件覆盖回 swf\、build\swf\、runtime\swf\ 与 decompiled\embedded-xml-assets\，并把 config\build\current-resource-manifest.sha256 中 sub1130 行哈希改回 B8854B9A37FCE37BD9F38F4361B3BB2BC16758ED0D679467CF9AC8CDE73643A8。
