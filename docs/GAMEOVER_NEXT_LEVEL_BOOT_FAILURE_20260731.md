# 结算页“进入下一关”按钮引发的加载界面故障报告

日期：2026-07-31  
影响版本：2.1.4 后续维护构建（尚未重新封装）  
故障等级：高（阻断进入离线存档与游戏主界面）

## 一、故障现象

启动 Flash 后可以看到原版《超合金战记 3》标题画面，但点击“开始游戏”后不能继续进入离线存档选择和游戏主界面。画面持续停留在原版标题页，看起来类似资源仍在加载。

这不是普通网络等待，也不是存档损坏。合作版主 UI 在初始化过程中发生异常，初始化流程被中止，因此后续界面没有创建完成。

## 二、触发改动

本次维护计划在战斗胜利结算页的“返回关卡选择”和“重玩本关”下方增加第三个“进入下一关”按钮。

第一次实现直接修改 `UI.gameover.GameOverUI`：

- 新增公开字段 `nextLevel_btn`。
- 直接实例化第三个 `PicButton`。
- 在 `UIGroup` 中访问该字段并注册点击事件。

发现问题后，第二次曾将按钮对象从 `PicButton` 改成普通 `Sprite`，但仍保留了 `GameOverUI.nextLevel_btn` 这个新增字段以及 `UIGroup` 对它的跨类引用，因此加载故障依旧存在。

## 三、日志证据

客户端错误日志 `build/saves/client_errors.log` 记录了两次失败：

```text
2026-07-31T22:23:59+08:00
kind=boot-fail
message=uiLoader_complete failed: ReferenceError: Error #1069

2026-07-31T22:26:44+08:00
kind=boot-fail
message=uiLoader_complete failed: ReferenceError: Error #1069
```

异常发生于 `uiLoader_complete`，即主 UI 资源载入完毕后、合作版 UI 实例化的阶段。由于异常发生得很早，玩家只能看到原版标题界面。

撤回对 `GameOverUI` 类结构的扩展后，实际启动日志恢复为：

```text
2026-07-31T22:29:26+08:00
kind=boot-step
message=uiLoader_complete done

2026-07-31T22:31:43+08:00
kind=boot-step
message=uiLoader_complete done
```

## 四、基线核验

本次故障没有修改 SWF 基线。

固定基线：

```text
swf/baselines/1.26.2.1-BAT.game.swf
SHA-256:
F54B78B5F3DC57101C62556B2D3830B051F686304D12C13B1DB8ABD0F833A37E
```

该哈希与 `config/build/swf-baseline.sha256` 完全一致，Git 也没有报告基线文件发生修改。构建仍然采用“固定基线 + 81 个显式 ActionScript 补丁 + 5 个 BinaryData 补丁”的最小补丁流程。

因此，故障不是基线漂移、SWF 被覆盖或资源包损坏造成的。

## 五、根本原因

`GameOverUI` 不是普通的纯代码 UI 类，而是与原版 SWF 时间轴导出符号绑定的类。它的实例结构、命名子对象和原版时间轴素材存在强耦合。

直接向这种时间轴绑定类增加新的公开显示对象字段，并让另一个补丁类在初始化阶段跨类访问该字段，会使旧 SWF 中的时间轴实例结构与新编译脚本的类结构产生不兼容。在主 UI 创建 `GameOverUI`、随后由 `UIGroup` 访问新增属性时，Flash 抛出：

```text
ReferenceError: Error #1069
```

第一次使用 `PicButton` 还额外引入了风险：原版 `PicButton` 本身依赖时间轴中预先存在的 `back`、`pic`、`new_tip` 等命名子对象，不适合被当作普通代码控件随意实例化。但第二次改成 `Sprite` 后仍失败，证明本次阻断加载的核心不只是按钮类型，而是扩展 `GameOverUI` 时间轴类结构及跨类访问新增槽位。

## 六、最终修复

最终方案完全撤销 `GameOverUI` 中的新增字段和按钮构造代码，恢复该时间轴类原有结构。

“进入下一关”按钮改为：

- 仅在已经长期参与补丁的外层 `UIGroup` 内保存动态按钮引用。
- 使用纯 `Sprite + Graphics + TextField` 绘制，不实例化原版 `PicButton`。
- 等原版 `GameOverUI` 创建并初始化完成后，再由 `UIGroup` 将按钮作为普通子对象挂载到结算页。
- 点击事件也由 `UIGroup` 自己处理，不再跨类访问 `GameOverUI` 的新增属性。
- 普通关卡胜利且存在下一关时显示；失败、副本、竞技场、公会战、教程关和最后一关隐藏。

修复后的实际启动连续两次得到 `uiLoader_complete done`，未再出现 `boot-fail`。

当前修复构建：

```text
build/game.swf
SHA-256:
E3288E0A19DFE8C747D0A16EE407C0BC80194670AE02503A455E1AC1CC7B5E14
```

## 七、影响范围

故障仅存在于加入不安全“下一关”按钮的两个中间维护构建中，这些构建没有封装为正式发布包。

以下内容不是故障原因，修复时予以保留：

- 开发者推荐 BGM 与玩家自定义歌单分流。
- 玩家自定义歌单独立播放开关。
- 精英副本免费扫荡资格修复。
- 固定 SWF 基线和既有资源补丁。

## 八、后续维护规则

以后修改反编译 Flash UI 时遵守以下规则：

1. 不直接向时间轴绑定类增加供其他类访问的新公开显示对象槽位。
2. 不假设原版 `PicButton`、`MovieClip` 子类可以脱离其导出符号单独实例化。
3. 新控件优先由稳定的外层容器动态挂载，使用纯 `Sprite`、`Shape` 和 `TextField`。
4. 必须在完整构建后实际启动游戏，并检查 `client_errors.log` 是否出现新的 `boot-fail`。
5. 仅通过 ActionScript 编译和 SWF 反向导出，不足以证明时间轴类在运行时兼容。
6. 任何修改主 UI 初始化路径的补丁，在封装前至少连续启动验证两次。

## 九、结论

此次加载界面故障是新增结算按钮时错误扩展原版时间轴绑定类造成的运行时类结构不兼容，不是基线被修改，也不是玩家存档、服务器端口或资源文件损坏。

通过恢复 `GameOverUI` 原始类结构，并将按钮改为由 `UIGroup` 在运行时动态挂载，已恢复正常加载。
