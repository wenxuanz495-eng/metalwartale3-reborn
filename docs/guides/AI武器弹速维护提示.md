# AI 武器弹速维护提示

遇到“子弹速度不对”“弹道密度不对”“看起来比 2.5/3.4 快”或“已经改了 `bulletSpeed` 但手感仍不一致”时，必须主动提醒使用者检查完整弹道参数，不得只修改一个字段。

## 必查字段

```text
bulletSpeed
bulletMaxV
bulletMaxVa
bulletLife
attackGap
shootNum
shootGap
followB
```

## 必须遵守的规则

1. 先按家族 ID 和家族阶段对应 2.5、3.4 与当前版本。
2. 2.5/3.4 已存在的武器，优先恢复完整运动参数，而不是只恢复初速度。
3. 如果旧版本 `bulletMaxVa=0`，当前版本却是非零，必须提示“存在飞行中加速风险”。
4. 如果当前版本独有武器按 2.5 倍降速，必须同时检查 `bulletMaxV` 和 `bulletMaxVa`，否则初速度降低后仍可能重新加速。
5. 修改后必须从最终 `build\game.swf` 导出 BinaryData 再核对，不能只检查源码 XML。
6. 必须更新 `docs\baselines\玩家武器弹道速度分类与进度.md`。

## 已知高风险家族

- `induction`：感应炮，旧版无加速度。
- `microwave`：微波炮，当前版本曾以极高加速度重新提速。
- `ioncanon`：无畏，当前版本独有，需同步处理最高速度与加速度。
- `shotgun`：霰弹炮，阶段速度为 `25/25/25/20`。
- `chipped`：碎裂炮，阶段速度为 `35/35/35/35/25`。

