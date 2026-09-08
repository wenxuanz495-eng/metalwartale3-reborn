# -*- coding: utf-8 -*-
# 调皮家族配置 bin 补丁（2026-09-09）
# ①射速：elastic 块内 attackGap 0.9 -> 0.4（4 处，等长替换）
# ②受击：elastic 块内 hitImgLabel bullet/purple_boom -> sub/positron_hit_effect（4 处，变长 +5 字节/处）
# 铁律：只在 elastic <arms> 块内替换（其他家族的 0.9/purple_boom 一律不动）；单次拼接写盘，写盘后断言
import io, hashlib, sys

BIN = r"D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"
BAK = "config-bin-backup.bin"

raw = open(BIN, "rb").read()
open(BAK, "wb").write(raw)  # 修改前备份留工作区
text = raw.decode("utf-8")

start = text.index('<arms index="2" id="elastic">')
end = text.index('</arms>', start) + len('</arms>')
block = text[start:end]
print("elastic 块范围: 字符 %d - %d（长度 %d）" % (start, end, end - start))

OLD_GAP = "<attackGap>0.9</attackGap>"
NEW_GAP = "<attackGap>0.4</attackGap>"
OLD_HIT = "<hitImgLabel>bullet/purple_boom</hitImgLabel>"
NEW_HIT = "<hitImgLabel>sub/positron_hit_effect</hitImgLabel>"

n_gap = block.count(OLD_GAP)
n_hit = block.count(OLD_HIT)
print("块内 attackGap 0.9 出现:", n_gap, "  hitImgLabel purple_boom 出现:", n_hit)
assert n_gap == 4, "attackGap 出现次数异常: %d" % n_gap
assert n_hit == 4, "hitImgLabel 出现次数异常: %d" % n_hit

new_block = block.replace(OLD_GAP, NEW_GAP).replace(OLD_HIT, NEW_HIT)
# 替换后块内不得再含 purple_boom / attackGap 0.9
assert "purple_boom" not in new_block, "块内仍残留 purple_boom"
assert "<attackGap>0.9<" not in new_block.replace("</attackGap>", "<"), "块内仍残留 attackGap 0.9"
assert new_block.count(NEW_GAP) == 4 and new_block.count(NEW_HIT) == 4

new_text = text[:start] + new_block + text[end:]
# 块外零变化断言
assert new_text[:start] == text[:start] and new_text[end + (len(new_block) - len(block)):] == text[end:]
out = new_text.encode("utf-8")
open(BIN, "wb").write(out)
print("已写盘。原大小=%d 新大小=%d（差 %+d）" % (len(raw), len(out), len(out) - len(raw)))
print("原 bin SHA-256:", hashlib.sha256(raw).hexdigest()[:16])
print("新 bin SHA-256:", hashlib.sha256(out).hexdigest()[:16])
