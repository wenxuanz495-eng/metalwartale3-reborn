# -*- coding: utf-8 -*-
# 战殇家族（激光棱束炮 laser）配置补丁（2026-09-09）
# 用户决策：仅射速回 2.5 —— laser 块内 attackGap 2.4 -> 1.5（4 处，等长替换）
# 受击特效维持现状（3.4/GH 三态），bulletLink 死配置保留不动
# 铁律：只在 laser <arms> 块内替换；单次拼接写盘，写盘后断言
import hashlib

BIN = r"D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"
BAK = "config-bin-backup-before-laser-patch.bin"

raw = open(BIN, "rb").read()
open(BAK, "wb").write(raw)  # 修改前备份留工作区
text = raw.decode("utf-8")

start = text.index('<arms index="6" id="laser">')
end = text.index('</arms>', start) + len('</arms>')
block = text[start:end]
print("laser 块范围: 字符 %d - %d（长度 %d）" % (start, end, end - start))

OLD = "<attackGap>2.4</attackGap>"
NEW = "<attackGap>1.5</attackGap>"
n = block.count(OLD)
print("块内 attackGap 2.4 出现:", n)
assert n == 4, "attackGap 出现次数异常: %d" % n

new_block = block.replace(OLD, NEW)
assert new_block.count(NEW) == 4 and OLD not in new_block

new_text = text[:start] + new_block + text[end:]
# 块外零变化断言
assert new_text[:start] == text[:start]
assert new_text[start + len(new_block):] == text[end:]
out = new_text.encode("utf-8")
open(BIN, "wb").write(out)
print("已写盘。原大小=%d 新大小=%d（差 %+d，等长替换应为 0）" % (len(raw), len(out), len(out) - len(raw)))
print("原 bin SHA-256:", hashlib.sha256(raw).hexdigest()[:16])
print("新 bin SHA-256:", hashlib.sha256(out).hexdigest()[:16])
