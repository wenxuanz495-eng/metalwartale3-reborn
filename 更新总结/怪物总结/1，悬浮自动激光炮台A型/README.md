# 01 悬浮自动激光炮台A型 · 路径索引

> 本夹档案：`悬浮自动激光炮台A型-档案-20260929.md`。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI 三件套：`gamefile\scripts\enemy\airLaserFort\`——AirLaserFortBody.as（148 行）/ AirLaserFort_AI.as（66 行，含 selfBoom 自爆模式）/ AirLaserFortAAHD.as（19 行）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_EmbedXml_xmlClass8.bin` → **index 0, id=AirLaserFort**
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_EmbedXml_xmlClass9.bin` → **index 10000, id=AirLaserFort**（激光 hurt 1.0）
- 生成函数：`gamefile\scripts\bodyGroup\BodyGroup.as:265`（addAirLaserFort）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"悬浮自动激光炮台A型"，顺序数组第 1 位）

## 资源

- 当前仓：`swf\AirLaserFort.swf`（SHA-256 前8 `69CC4636`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\AirLaserFort.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\AirLaserFort.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\悬浮机器人炮塔1\`
- 图鉴图标：`swf\BookUI760.swf` 内嵌 **419.jpg**（青色涂装，与实机绿色不符）＝`D:\superalloy\原版\11.3超合金素材汇总\百科ui\images\419.jpg`

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍（包含老版本存在，但新版本被删减的内容。）.docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（敌人清单与三方硬比对.csv、compare_pass1/2.py）
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- `..\2，悬浮自动激光炮台B型\`（兄弟机型 AirLaserFort_2）
- **蓝光飞碟 UFO**（图鉴 16）：⚠️ 仅**代码层**共用 `BodyGroup.addAirLaserFort("ufo")` 生成函数与 AirLaserFortBody 类（数据全独立：自有敌人行 index 3／武器 idx 10005"飞碟的火炮"energy/hurt 0.2/bulletSpeed 25 无追踪）；**美术血统属追踪者/追猎者家族**（穹顶同款脑壳设计，蓝=追踪者系/粉=追猎者系，用户裁定＋帧图证据）——非悬浮炮台换皮，到其图鉴号时按此口径立档互链
- 设施复用：金币空间(4-1-5) 隐形发球塔＝本怪（`SpecialExtraLevel_6`）；`Level_2_12` 代码拉怪
