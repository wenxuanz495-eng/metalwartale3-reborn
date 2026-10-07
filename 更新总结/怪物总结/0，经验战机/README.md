# 0 经验战机 · 文件索引与介绍

> 本夹档案：`经验战机-档案-20261007.md`（**第 0 档案**·图鉴外·刷经验专用机；2026-10-07 用户裁定图鉴外特殊单位立第 0 档案）。本 README＝该怪全部相关文件的索引字典。
> **三名并存**：敌表 name＝**经验飞机**／素材夹名＝**经验战机**／俗称＝经验战机（本档标题从俗）。代码 id `expflyer`（敌表 index 属性 18＝追加怪共享槽；arms 100020）。

## 代码文件（仓库 `decompiled\`）

- **无专属类**（全 decompiled 零引用）——通用空军体系 `Normal_FlyBody`＋`Normal_Fly_AI`；掷骰双名单（GameDefine.as:212/214）不含（理论项）。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as` getUnit **默认分支**（isAir→`addNormal_Fly("expflyer",1,…)`，armsNum=1）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 属性 18 id=expflyer**（追加怪共享槽家族；name=经验飞机/imgList `fly,shoot,die`/hitRect=hurtRect 同值 -42,-39,83,78/**baseExp 50·baseCoin 1＝同等级经验 50 倍全表断层第一**/baseLife 1 脆皮/energy 防/vx 五档 150~270/airRange -400,-600/hoverRect 与拦截机1号同款/敌表 description＝"加特林车载重炮"车辆文案错挂死数据；**2.5/3.4/4.0 数据层全零＝11.3 新增实锤**）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **arms index 100020 id=expflyer 单把"武器"**（实弹 motion hurt1×2 弹 45°/弹体 expflyer/bullet/type=太阳炮标签在/description=小黄豆文案搬运 67 载体家族）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **33 关 101 只，全战役节点关撒布**（1-1-3 突击者队长→1-4-79 击败守门人，几乎全为 Boss 关/里程碑关，每关 1~5 只；**enemyExp_ra 全缺＝50 倍纯靠 baseExp**；限时关沾边 3 处 1-4-49/50/66）；3.4/4.0 关卡表零引用。
- **图鉴外三重实锤**：`UI\book\BookUI.as:105` nameArr 零"经验"＝从未进图鉴名单；**BookUI760.swf 全部导出文本零命中＝时间轴无面板文字字段**（用户"图鉴里没有尤其时间轴里没有"逐项证实）；`图鉴顺序-BookUI.json` 82 条无它。

## 资源文件

- 当前仓：`swf\expflyer.swf`（68,621 字节 md5 `7fb1a730`）——**2.5/3.4/4.0 库均无**。
- 11.3 素材汇总：`经验战机\`＝直配夹（**夹名=俗称非表名**）——★**同批唯一 frames.gif 健康的直配夹**（四态有像素内容；其余怪夹全空帧）。
- **档案辨认动图（ffdec 自导，2026-10-07）**：`D:\superalloy\TMP\红蛛杀手建档-20261007\辨认材料00\`（fly/shoot/die GIF＋连拍 PNG＋弹体；TMP 不入仓）。
- **图鉴图标：无**（图鉴外单位不进 BookUI）。

## 文档与数据

- docx：**无条目**（经验/飞机零命中——非剧情怪，符合预期）。
- 数值侧总纲：`..\怪物分级与数值体系-20261005.md` 三节奖赏梯队——**50× 档已增补**（原 verified 最高 12×）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\敌人清单与三方硬比对.csv`——expflyer 属"仅当前存在"组（52 怪 11.3 新增组）。
- 音频审计：`更新总结\月球噪声\工具\swf_sound_audit.py`；die 帧3=f459def8 通用死亡爆炸（挂载点位随意样本）＋shoot 帧3=42c9fb9d 0.58s 专属开火音（全库唯一指纹）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`——**无此怪（82 条外）**。

## 家族关联

- idx 18 共享槽家族（搬运怪批：绿魔/赤钢/热破/阿尔西/闪电/镇压者/搜寻者/攻城者/沃克/布莱克/巴洛克/灰烬等，见总纲四.14）——expflyer 与它们共占 index 属性 18。
- 功能怪对照组：防卫卫星（Satellite，辅助单位定位）、警报塔（AlarmTower，充能演出装置）——图鉴外/低战斗定位的功能性单位。
- 小黄豆文案搬运家族（67 载体）、加特林文案错挂家族（38 钢铁暴牛兽同款）——外包复制粘贴痕迹的双料成员。
