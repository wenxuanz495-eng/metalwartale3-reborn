# -*- coding: utf-8 -*-
# 高周波切割炮家族配置补丁（2026-09-09）
# 受击改绑：cutter 块内 hitImgLabel sub/cutter_hit_effect -> sub/cut_effect（6 处，lv1~lv6，-9 字节/处）
# cutter_hit_effect 被 xmlClass8(415)/xmlClass7(34)/xmlClass9(5)/xmlClass3(2) 共用，不可动其内容/原位替换；
# cut_effect 为零引用死名（配置+脚本+存档全域扫描），已由 SWF 侧改绑至 2.5 六态受击新精灵 1985
import hashlib

BIN = r"D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"
BAK = "config-bin-backup-before-cutter-patch.bin"

raw = open(BIN, "rb").read()
open(BAK, "wb").write(raw)
text = raw.decode("utf-8")

start = text.index('<arms index="4" id="cutter">')
end = text.index('</arms>', start) + len('</arms>')
block = text[start:end]
print("cutter 块范围: 字符 %d - %d（长度 %d）" % (start, end, end - start))

OLD = "<hitImgLabel>sub/cutter_hit_effect</hitImgLabel>"
NEW = "<hitImgLabel>sub/cut_effect</hitImgLabel>"
n = block.count(OLD)
print("块内 sub/cutter_hit_effect 出现:", n)
assert n == 6, "出现次数异常: %d" % n

new_block = block.replace(OLD, NEW)
assert new_block.count(NEW) == 6 and OLD not in new_block

new_text = text[:start] + new_block + text[end:]
assert new_text[:start] == text[:start]
assert new_text[start + len(new_block):] == text[end:]
out = new_text.encode("utf-8")
open(BIN, "wb").write(out)
print("已写盘。原大小=%d 新大小=%d（差 %+d）" % (len(raw), len(out), len(out) - len(raw)))
print("原 bin SHA-256:", hashlib.sha256(raw).hexdigest()[:16])
print("新 bin SHA-256:", hashlib.sha256(out).hexdigest()[:16])
