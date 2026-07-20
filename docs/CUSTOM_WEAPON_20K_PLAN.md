# 定制武器 20,000 MB 上架任务

状态：规则已确认，数据落地待下一步。

## 决策

- 定制/往期装备进入商城
- 定制武器统一售价：**20,000 M币**

## 实施入口（候选）

- `decompiled/gamefile/scripts/goods/GoodsDefineGroup.as`
- 嵌入商品表 / dataMust
- `gameAll/api/Shop_API.as`
- 修改器定制武器列表

## 验收

- 商城可见定制武器
- 价格均为 20000
- 已拥有不可重复购买
- 购买写入 `game_save.bin`
