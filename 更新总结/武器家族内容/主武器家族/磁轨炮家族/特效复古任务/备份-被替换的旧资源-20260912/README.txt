备份说明（2026-09-12）

- arms1100.swf：磁轨炮家族蓄力辉光回迁（v3 斯巴达口径之后）修改前的旧版副本
  SHA-256 = D1184767CFBDDD1B67DF5E2FA9C28A493078CE429B01116619D9E3C41251709E
- 本次修改：新增 flashA/B/C 三层辉光闭包（新 ID 1801~1809，源=4.0 arms400）
  并重构 magneticTrack_lv1~lv5（sprite 582/575/568/561/556）时间轴为 4 帧：
  f2=开火本体+枪口火焰D+A+B+开火音；f3=移D/移A+C+回待机；f4=清理
  数值/材料/子弹/受击全部未动
- 新版哈希链 = 11963E07…（蓄力回迁）→ 67247F662FD9DB325D3CCD8688F3C3C361B0A3871B2B3DC5E488C842E71AFD46（＋射点右移，当前生效）
- 回滚方式：本文件覆盖回 swf\、build\swf\、runtime\swf\ 三处，
  并把 config\build\current-resource-manifest.sha256 中 arms1100 行改回本哈希
