# 希尔文（plasma）家族 2.5 / 3.4 / 当今 GitHub 版对比审计

日期：2026-09-07
审计人工作区：`D:\superalloy\tmp-soya-family-test\plasma-audit`
证据等级：A（配置、SWF 结构、渲染 PNG、像素比对、哈希多重印证）

## 一、家族与形态映射

家族 ID：`plasma`（配置 index=11），等离子炮系。

| 等级 | 2.5 | 3.4 | 当今 GitHub | 备注 |
|---|---|---|---|---|
| LV1 | 希尔文 | 希尔文 | 希尔文 | |
| LV2 | 雷沃汀 | 雷沃汀 | 雷沃汀 | |
| LV3 | 昆古尼尔 | 昆古尼尔 | 昆古尼尔 | 2.5/3.4 的 LV3 与新增 LV6 同为 Gungnir 音译，勿混淆 |
| LV4 | 米约尔尼尔 | 米约尔尼尔 | 米约尔尼尔 | |
| LV5 | 奥普 | 奥普 | 奥普 | |
| LV6 | — | — | **冈格尼尔（新增）** | 3.4 无此形态；配置/SWF 均为离线版新增 |

## 二、配置层结论

文件：
- 2.5：`原版\2.5（原版参考）\2.5版本素材库\raw\xml\arms_35.xml`
- 3.4：`原版\3.4（原版参考）\3.4代码库\reference-binary-data\12_arms61_xml$*.bin`
- GH：`decompiled\embedded-xml-assets\2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin`

1. GH 的 lv1~lv5 继承 3.4 体系：`attackType=energy`（2.5 为 mixed）、`hitImgLabel=bullet/blue_energy`（2.5 为 sub/chipped_hit_effect）、`reduceRa=1.2`。
2. GH 在离线版调整（非删减，属改版数值）：`attackGap` 0.23→0.15、`recoilValue` 6→9、价格与合成材料下调。
3. 子弹速度三版本一致（bulletSpeed=30），与 2.4.1/2.4.2 公告"速度统一"相符。
4. `smokeImgLabel` 接线三版本同惯例：lv1~lv4 用各自 smoke，lv5 沿用 lv4_smoke；GH 的 lv6 也沿用 lv4_smoke。虽然 GH 资源里已存在 lv5_smoke/lv6_smoke 导出，但配置未使用（属预留资源，非删减）。

## 三、资源层结论（arms SWF）

文件：2.5 `arms_34.swf`、3.4 `arms52.swf`、GH `swf\arms1100.swf`（运行副本 `build\swf\arms1100.swf`）。

### 3.1 本体与开火表现（2026-09-07 二次精查修正）

单张 shape 拆开比对（`shapes\` 目录）后修正帧级比对结论：

1. **待机图 lv1~lv5：三版本像素级一致**（2.5=3.4=GH，IDENTICAL）。
2. **开火姿态图 lv1~lv4：三版本像素级一致**（整图替换机制：f2 移除本体→放开火图，f4 移除开火图→放回本体；该机制与美术三版本完全相同）。
3. **lv5 开火表现：2.5 与 3.4/GH 机制+美术都不同**——
   - 2.5：本体留在 depth1 不动，枪口叠加**独立枪口焰光斑**（shape 214，48×33，蓝白光斑）于 depth2（tr=-20,0），f4 才移除；
   - 3.4/GH：改为与 lv1~lv4 相同的**整幅开火姿态图替换**（shape 528/1076，118×35，枪口焰直接画进炮口图），GH 与 3.4 像素一致。
   - 之前帧级比对中 lv5 f2/f3 的 61% 差异即由此而来。
4. **挂点标记差异（非枪体）**：之前 lv1~lv4 帧级 9~16% 的差异全部来自 basePoint/shootPoint 十字标记美术——2.5 为深红十字（char 4），3.4/GH 为带白圈的十字（char 7/20，与 2.5 差异 41.55%）。枪体本身无差异。
5. 音效三版本同一条 MP3；lv1~lv6 开火帧均 StartSound。

结论：**枪本体美术三版本一致；唯一实质差异是 lv5 的开火表现方式（2.5 独立焰层 vs 3.4/GH 整图替换）。**

### 3.2 子弹与烟迹：离线版已重构（替代，非删减）

- 2.5 与 3.4：每级独立子弹 shape（lv1~lv5 五个不同图形；两版本尺寸一致 60×25→122×40 但内容哈希不同，说明 3.4 也重画过）。烟迹为竖向拖尾（56×47~83×70），每级独立 shape。
- GH：全部 6 级子弹统一为共享核 `char 585 → DefineShape 584` + 逐级缩放 1.0/1.1/1.2/1.3/1.4/1.5；6 个 smoke 全部基于同一共享核做 5 帧 colorTransform 渐隐，尺寸=同等级子弹尺寸。
- 1.26.2.1-BAT 黄金基线的 game.swf 已含该结构，说明此重构早在 GitHub 工作区成立之前（海豹版 1.2 血统）就已完成，非近期改动。
- 结论：**若目标是"恢复 2.5/3.4 老特效"，plasma 家族真正与原版不同的就是子弹和烟迹（本体没有差异）。**

### 3.3 新形态 lv6（冈格尼尔）：3.4 无此形态

- 3.4 的 `arms52.swf` 无 plasma_lv6/`plasma_lv6_bullet`；2.5 同。3.4 配置同样只有 5 级。
- 2.5/3.4/GH 的 `parts.swf`（部件展示库）中一直存在 plasma_lv1~lv12 的静态部件（每级 1 shape，车库/商店展示用）。GH 的 parts.swf 与 3.4 字节级相同（SHA-256 88be2e3f…），lv6/lv7 部件展示完好。
- GH `arms1100.swf` 的 lv6 本体（131×35，比 lv5 的 119×35 更长）与 lv6 子弹（共享核 1.5 倍）为离线版自产美术，非 3.4 迁移。lv6 本体时间轴含 3 个 shape（1068 待机、1070 开火姿态、1071 枪口辉光）+ 共享音效 24。
- lv6 配置要点：`specialType=Broken_Plasma`、`floorBounce=1`、`hurt=2210`、`commonLevel=130`、`mustLevel=100`、`bulletWidth=20`（与 lv4/lv5 相同）、`smokeImgLabel=arms/plasma_lv4_smoke`。

### 3.4 发现的 lv6 时间轴缺陷（与家族惯例不符）

家族惯例（lv1~lv5）：f2/f3 显示整幅开火姿态，f4 恢复待机并 **RemoveObject2 清理开火层**。
lv6 现状：f2 将辉光 1071 放到 depth=2 后，**全时间轴无任何移除**——f4 与循环回 f1 时待机机身上仍残留枪口白光（渲染图已证实）。
修复建议：在 f4（第三个 ShowFrame 前）补 `RemoveObject2 depth=2`，或在 f4 复刻 lv5 的"移除开火层+放回待机图"顺序。修改对象为 `swf\arms1100.swf` 并同步 `build\swf\arms1100.swf`。

### 3.5 音效

三版本射击音效为同一条 MP3 数据（2.5 id=215 / 3.4 id=529 / GH id=24，soundData 前缀一致），无变化。lv1~lv6 均在开火帧 StartSound。

## 四、产物与证据位置

```text
plasma-audit\
  plasma-2.5.xml / plasma-3.4.xml / plasma-GH.xml   三版本配置块
  work\arms1100.GH.xml / arms52.34.xml / arms34.25.xml   FFDec XML 导出
  work\parts.GH.xml / parts.34.xml / parts.25.xml
  render2\GH / 34 / 25                              符号渲染 PNG（逐帧）
希尔文（plasma）家族2.5-3.4-当今版对比审计-20260907.md  本报告
```

## 五、后续可选动作

1. 修复 lv6 时间轴残留辉光（按 3.4.4 建议）。
2. 如需"原版老特效"：将 lv1~lv5 子弹/烟迹恢复为 3.4（或 2.5）的每级独立美术——需按标准流程做依赖闭包导入 + Character ID 重映射，注意 GH 子弹被等级缩放逻辑依赖（若仅换美术需确认 bulletWidth 配合）。
3. 若想让 lv6 用上专属资源：可将配置 `smokeImgLabel` 指向已存在的 `arms/plasma_lv6_smoke`（当前指向 lv4_smoke，视觉上偏小一号）。
