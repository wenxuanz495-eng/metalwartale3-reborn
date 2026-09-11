备份说明（2026-09-11）

- arms1100.swf：斯巴达子弹缩放位移修改前的旧版副本
  SHA-256 = 9B02AAF01985F58D6E82B6A0740F94214938304FA96426B778838F3688B48640
- 本次修改：sprite 536（arc_lv1_bullet）内 shape 535 放置矩阵
  由 translate(0,0) 改为 scale 0.9 + translateX 3300 twips(165px)
  目的：消除新版子弹弹尾对枪口光斑区（x 43.4~119.4）的遮挡
- 新版哈希 = 6CC13184F22CCFA0693A83D7CB0044DB98121769E2FBB98E35D10D57D6247214
- 回滚方式：将本文件覆盖回 swf\、build\swf\、runtime\swf\ 三处，
  并把 config\build\current-resource-manifest.sha256 中 arms1100 行改回旧哈希
