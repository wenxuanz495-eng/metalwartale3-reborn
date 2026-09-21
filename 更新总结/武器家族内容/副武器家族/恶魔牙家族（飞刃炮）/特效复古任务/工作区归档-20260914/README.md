# 工作区归档说明（20260914）

> 本目录原收纳恶魔牙家族（含黄金番外）在 `tmp-soya-family-test` 的全部历史工作区（内含大量 SWF/XML 中间产物，已从 git 排除，本目录 .gitignore 生效）。

> **2026-09-21 数据外迁入冷备**：家族夹定位为"档案"（总结＋关键证据＋脚本），过程性工作区不再驻留仓库工作副本。本目录的**数据子目录已整体迁入 F 盘冷备**：
> `F:\超合金冷数据备份\TMP\端游端\3.0.0特效复古任务-家族TMP-20260921\恶魔牙家族（飞刃炮）\工作区归档-20260914\`
> （迁移中间态曾暂存 `D:\superalloy\TMP\3.0.0特效复古任务-家族TMP\`；56,545 文件 / 2.71 GB 校验一致）。
> 本目录现只保留 **本 README（索引）＋ `.gitignore`（排除规则）**；下方目录清单即冷备内容的索引。
> 需要回取：整目录从冷备拷回本路径即可（路径名不变，脚本与文档引用无需改动）。

## 目录清单（原 tmp-soya-family-test\<名称>；现位于上述冷备路径）

| 目录 | 主题 | 体积 |
|---|---|---|
| flyblade-25-34-gh-audit | 三版本对比+白圈定心主审计工作区（含 gold-fix 会话工作目录、report 证据图的**母本已复制到** `..\审计证据-20260914\`） | 1.5G |
| demon-tooth-audit | 恶魔牙专项审计 | 97M |
| demon-offset-fix / demon-offset-fix2 | 套链错位盲试修复（第六批前的失败尝试，教训已录） | 31M/78M |
| flyblade-25-restore | LV1~3 2.5 回迁工作区 | 121M |
| flyblade-25-satan-final-audit | LV2 终审计 | 21M |
| flyblade-audit | 早期审计 | 14M |
| flyblade-direct-timeline-fix | 时间轴直修尝试 | 89M |
| flyblade-lv5-lv6-restore-only | LV5/6 套链工作区 | 48M |
| flyblade-runtime-fix | 运行时修复 | 96M |
| gold-flyblade-25-restore | 前期黄金实验（含回退前 backup，见《黄金恶魔牙特效问题总结.md》） | 211M |
| goldflyblade-audit / goldflyblade-lv1-charge-fix | 黄金审计与蓄力修复 | 37M/122M |
| gold-satan-alignment-fix / charge-align / effect-offset-fix / effect-reimport / muzzle-align / shootpoint-fix | 黄金撒旦之力六轮对齐修复 | 各48M |

## ⚠️ 注意事项

1. **脚本路径**：各合并脚本（flyblade_restore_merge*.py 等）内硬编码了旧路径 `D:\superalloy\tmp-soya-family-test\flyblade-25-34-gh-audit\work`（20260914 目录整体迁入本处，2026-09-21 起数据在冷备）。重跑需先把数据从冷备整目录拷回本路径，再改脚本内路径或临时改回原名。
2. **残留锁定**：`flyblade-25-34-gh-audit\work\report\` 原目录被进程占用（疑似资源管理器/截图工具）未能移走，其内容已完整复制到 `..\审计证据-20260914\`；句柄释放后可手动删除空壳。
3. `abyss-gold-25-restore`（130M，原 tmp-soya-family-test 根目录）**未移入**：归属存疑（疑为"黄金深渊/深渊家族"素材，非恶魔牙家族），待用户确认后再归位。
