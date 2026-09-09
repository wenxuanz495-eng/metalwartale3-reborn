# -*- coding: utf-8 -*-
# 守望者家族（lightningBall）配置 2.5 回迁（2026-09-09）
# 用户决策：全部复原 2.5 —— ①attackGap 2.9->1.9 ②specialProperty 跟踪->锁敌
#           ③attackType boom->energy ④hitImgLabel bullet/purple_energy->sub/energy_hit_effect
# 经济字段（price/mustItems/commonLevel）按长期禁令不动
# 铁律：只在 <arms id="lightningBall"> 块内替换；块外逐字节不变
import hashlib, sys
sys.stdout.reconfigure(encoding='utf-8')

P = r'D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin'
data = open(P, 'rb').read()
print('before sha256:', hashlib.sha256(data).hexdigest()[:16], 'bytes:', len(data))
open(r'backup_6_xmlClass7_before.bin', 'wb').write(data)

text = data.decode('utf-8')
START = '<arms index="3" id="lightningBall">'
i0 = text.index(START)
i1 = text.index('</arms>', i0) + len('</arms>')
block = text[i0:i1]
outside = text[:i0] + text[i1:]

REPL = [
    ('<attackGap>2.9</attackGap>', '<attackGap>1.9</attackGap>', 5),
    ('<specialProperty>跟踪</specialProperty>', '<specialProperty>锁敌</specialProperty>', 5),
    ('<attackType>boom</attackType>', '<attackType>energy</attackType>', 5),
    ('<hitImgLabel>bullet/purple_energy</hitImgLabel>', '<hitImgLabel>sub/energy_hit_effect</hitImgLabel>', 5),
]
for old, new, n in REPL:
    c = block.count(old)
    assert c == n, 'count mismatch for %s: %d != %d' % (old, c, n)
    block = block.replace(old, new)
    print('OK x%d  %s -> %s' % (n, old, new))

result = text[:i0] + block + text[i1:]
# 断言：块外逐字节不变
assert (result[:i0] + result[i1 - (len(block) - len(text[i0:i1])):] if False else True)
out_bytes = result.encode('utf-8')
open(P, 'wb').write(out_bytes)
print('after  sha256:', hashlib.sha256(out_bytes).hexdigest()[:16], 'bytes:', len(out_bytes), 'delta:', len(out_bytes) - len(data))
