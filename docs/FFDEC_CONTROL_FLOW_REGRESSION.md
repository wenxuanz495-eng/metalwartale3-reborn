# FFDec 反编译重编译导致的控制流回归

## 问题摘要

海豹版在第一章第 5 关可能卡死，Debug Player 最终报告：

```text
Error #1502: 脚本的执行时间已经超过了 15 秒的默认超时设置。
at hit::HitIO$/hitRectLine2()
at bodyGroup::BodyGroupHit/bulletHit_body()
at bodyGroup::BodyGroupHit/FTimer()
at Game/allTimer()
```

这不是原版游戏逻辑中的无限循环，而是 FFDec 将原始 SWF 反编译为 ActionScript、再通过 `-importScript` 编译回 SWF 时产生的控制流回归。

## 已确认的根因

问题方法位于：

```text
decompiled/gamefile/scripts/hit/HitIO.as
hit.HitIO.hitRectLine2()
```

未修改原版 `13_L4399Main_gamefile.swf` 的实际 P-code 使用有界循环：

```text
getlocal n
getlocal loopNum
iflt loop_body       ; n < loopNum 时继续
getlocal p0
returnvalue          ; 达到上限后返回 null
```

其实际语义是：

```actionscript
while (n < loopNum)
{
    // 碰撞检测
    n++;
}
return null;
```

FFDec 26.2.1 导出的 ActionScript 却是：

```actionscript
while (true)
{
    if (n < loopNum)
    {
        // 碰撞检测
        n++;
    }
}
return p0;
```

这段文本只是错误的反编译结果。原始 SWF 并不会在 `n >= loopNum` 后继续循环。

当工作台把错误文本重新导入 SWF 后，海豹版的 P-code 真的变成了无条件回跳。激光在 800 像素范围内没有命中矩形时，主线程永久循环，最终触发 `Error #1502`。

## 影响范围与同类风险

对 `decompiled/gamefile/scripts`、`decompiled/etjv1130/scripts` 和 `decompiled/main910/scripts` 中显式的 `while(true)` 进行了扫描和人工检查。

- 已确认的错误实例只有 `HitIO.hitRectLine2()`。
- `Bezier.InvertL()` 和两个 JSON `readString()` 中的 `do ... while(true)` 均有明确 `break`，属于正常写法。
- Base64、JSONDecoder、JSONTokenizer 和 FocusManager 中的其他无限循环也有明确的返回、异常或退出条件，未发现与本问题相同的明显缺口。

这次扫描只能排除容易从源码文本识别的同类问题，不能证明所有反编译源码都与原始 ABC 等价。条件跳转、短路表达式、异常处理、`switch` 和嵌套循环仍可能在结构化反编译时发生语义变化。

风险仅在“将反编译源码重新编译进 SWF”时落地。只查看反编译源码不会改变原始程序。

## 修复建议

将 `hitRectLine2()` 改为有界循环，并在没有命中时返回 `null`。可参考同文件中结构正确的 `hitRectArrLine2()`：

```actionscript
while (n < loopNum)
{
    x3 = x2 + cos0 * n - w1;
    y3 = y2 + sin0 * n - w1;
    bb = hit(rect.x,rect.y,rect.width,rect.height,x3,y3,w0,w0);
    if (bb)
    {
        return new Point(x2 + cos0 * n,y2 + sin0 * n);
    }
    n++;
}
return null;
```

## 后续构建检查

对于准备通过 `-importScript` 重编译的类：

1. 修改前导出原始 SWF 的 `script:pcodehex`。
2. 构建后再次导出同一方法的 P-code。
3. 对比条件跳转目标、循环退出边和返回路径，而不只比较反编译后的 ActionScript。
4. 使用 Debug Player 覆盖无命中、空数组、边界值和异常输入路径。
5. 优先只导入确实需要修改的类，减少无关反编译代码被重新编译的范围。

本问题的关键经验是：反编译文本不是可信源码基线；对于复杂控制流，原始 P-code 才是行为基准。
