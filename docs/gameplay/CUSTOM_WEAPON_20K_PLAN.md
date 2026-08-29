# 定制武器 20,000 MB 上架任务

状态：**源码已落地（2026-07-21）**

## 决策

- 定制/往期装备进入商城
- **定制武器统一售价：20,000 M币**
- 定制车辆暂保持原离线上架价 2000（本次只改武器）

## 实现

文件：

- `decompiled/gamefile/scripts/goods/GoodsDefineGroup.as`
  - `addCustomGoods()`：主武器/副武器 `Mprice = 20000`
  - 识别条件：武器定义 `discount == -1000`（定制标记）
- `decompiled/gamefile/scripts/UI/shop/OneShopUI.as`
  - 移除“定制商品只展示不可购买”拦截
  - 仍保留“已拥有只能买一次”检查

构建：

- 基线：`runtime/game.base.swf`（海豹 1.2）
- 产物：`runtime/game.swf`
- 备份：`D:\superalloy\1.2文件备份\custom-weapon-20k-20260721`

## 验收

- [ ] 商城主武器/副武器页出现定制武器
- [ ] 价格显示为 20000 M币
- [ ] 未拥有时可购买并扣款
- [ ] 已拥有时提示只能购买一次
- [ ] 购买后写入 `saves/game_save.bin`
