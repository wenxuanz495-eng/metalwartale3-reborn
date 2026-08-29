# Flash 加载界面卡死排查

## 现象与本质

游戏长时间停在加载界面时，不一定是资源下载或 SWF 构建失败。这个项目的主加载流程没有统一捕获 ActionScript 3 初始化异常；只要初始化函数抛出异常，后续完成事件就不会执行，画面看起来便像一直在加载。

纯 BAT 构建成功只能证明脚本可以编译，不能证明运行时初始化顺序正确。此类问题必须使用 Debug Flash Player 完整启动，并检查 `flashlog.txt`。

## 已知实例

### 设置 UI 过早刷新战斗 HUD

`AllBack.init()` 读取键位设置时，曾立即调用 `GamingUI` 的按键提示刷新函数。此时 `UIGroup` 尚未创建 `GamingUI`，因此触发 `Error #1009`。

修复原则：配置读取与界面刷新分成两个阶段。初始化早期只读数据；目标 UI 创建后再刷新。

### 武器定义构造期间反查武器家族

`DefineGroup.addData_byXML()` 会先向 `armsArr` 添加一个空数组，再构造当前家族的第一个 `OneArmsDefine`，最后才把定义写入数组。紫色芯片规则新增后，`OneArmsDefine.fleshData()` 在这段构造过程中调用了家族上限查询。

原调用顺序为：

```text
创建空家族数组
  -> OneArmsDefine.inData_byXML()
  -> OneArmsDefine.fleshData()
  -> ArmsItemsData.getPurpleChipGrowthLevel()
  -> canInstallPurpleChip()
  -> DefineGroup.getArmsDefineArr()
  -> 读取空家族的第 0 项并访问 define0.id
```

当前修复包含两层保护：

- `getPurpleChipGrowthLevel()` 先确认确实装有 `GoodsItemsData` 芯片，再查询依赖全局定义库的安装规则。
- `getArmsDefineArr()` 遍历时跳过空数组和 `null` 定义，允许定义库处于构建中状态。

## 后续修改的规避规则

- 不要在构造函数、`inData_byXML()` 或早期 `init()` 中访问稍后才创建的 UI、单例或数组元素。
- 不要在集合构建期间反查同一个正在构建的集合；确有必要时，查询函数必须允许空槽和部分完成状态。
- 短路条件从最便宜、最局部、最安全的判断开始。类型和空值检查应放在依赖 `Game.*` 全局状态的方法调用之前。
- 将“读取配置”“建立数据”“创建 UI”“刷新 UI”视为不同阶段，不要在读取阶段隐式刷新显示对象。
- 遍历反编译项目中的稀疏数组时，不要假定每个索引都有对象；访问字段前检查数组、元素和必要字段。
- 新增启动期调用时，必须沿调用链检查它依赖的对象究竟在哪一步创建和填充。

## 提交前启动检查

1. 运行纯 BAT 构建，确认最小脚本补丁成功注入。
2. 使用 `flashplayer_sa_debug.exe` 从头启动游戏，至少进入选服页或主界面。
3. 检查 `%APPDATA%\Macromedia\Flash Player\Logs\flashlog.txt`。
4. 重点搜索 `Error #1009`、`TypeError`、`RangeError`、`VerifyError`、栈溢出和类型转换错误。
5. 若加载停住，记录日志最后一个业务 trace，并沿该 trace 后面的初始化调用反向检查对象创建顺序。
6. 不能用“SWF 能编译”或“HTTP 返回 200”替代启动级验证。

## 快速判断

出现以下特征时，优先怀疑初始化异常：

- 资源加载进度已接近完成，但主界面不出现。
- 修改只涉及 UI 初始化、配置读取、定义数据或全局单例。
- Debug Player 日志在固定 trace 后停止。
- 恢复上一提交即可正常进入，且服务器与资源请求均正常。

此时应先查看异常栈，不要继续在加载动画或资源服务器上叠加补丁。
