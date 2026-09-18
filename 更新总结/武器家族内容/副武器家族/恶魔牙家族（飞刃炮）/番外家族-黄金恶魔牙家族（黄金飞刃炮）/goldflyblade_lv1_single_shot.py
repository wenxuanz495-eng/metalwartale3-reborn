# -*- coding: utf-8 -*-
# 黄金恶魔牙 LV1 恢复单发（20260916，用户裁定：lv1 应单发、lv2 起双发，与本系恶魔牙 1/无、2/6 对齐）
# 查证：lv1 bulletNum=2 为初始提交（ba10543，11.3 基底）既有值，历次提交未改；
#       观感双发来自 52f929e 补 bulletTranslation=6 使原"同点重叠双弹"变可见。
# 修改：仅 goldflyBlade 块 lv1 节点——bulletNum 2→1、删 bulletTranslation 6（各恰 1 处断言）。
import hashlib, re, sys
sys.stdout.reconfigure(encoding='utf-8')

BIN = r'..\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin'
EXPECT = '7AA24AF5'  # 本脚本运行时的底稿（lv1 恢复单发前）

actual = hashlib.sha256(open(BIN, 'rb').read()).hexdigest().upper()
assert actual.startswith(EXPECT), actual
print('底稿哈希断言 PASS:', actual[:8])

data = open(BIN, 'rb').read().decode('utf-8')
BS = '<arms index="9" id="goldflyBlade">'
BE = '</arms>'
i = data.find(BS)
j = data.find(BE, i)
head, block, tail = data[:i], data[i:j + 7], data[j + 7:]

k = block.find('黄金撒旦之力')          # lv1 段 = 块首 → lv2 name 之前
assert k > 0
seg, rest = block[:k], block[k:]
assert seg.count('<bulletNum>2</bulletNum>') == 1
assert seg.count('<bulletTranslation>6</bulletTranslation>') == 1
seg = seg.replace('<bulletNum>2</bulletNum>', '<bulletNum>1</bulletNum>')
seg = seg.replace('<bulletTranslation>6</bulletTranslation>', '')
block = seg + rest

rows = re.findall(r'<name>([^<]+)</name>(?:(?!</armsLevel>).)*?<bulletNum>(\d+)</bulletNum>((?:(?!</armsLevel>).)*)', block, re.S)
assert len(rows) == 6, len(rows)
for name, num, rest2 in rows:
    m = re.search(r'<bulletTranslation>(\d+)</bulletTranslation>', rest2)
    print(name, 'bulletNum=', num, 'translation=', m.group(1) if m else '无')
assert rows[0][:2] == ('黄金恶魔牙', '1') and 'bulletTranslation' not in rows[0][2]
for name, num, rest2 in rows[1:]:
    assert num == '2' and '<bulletTranslation>6</bulletTranslation>' in rest2, name

new_data = head + block + tail
assert new_data.startswith(head) and new_data.endswith(tail)
open(BIN, 'wb').write(new_data.encode('utf-8'))
print('写出 len', len(data), '->', len(new_data), '新哈希', hashlib.sha256(new_data.encode('utf-8')).hexdigest().upper()[:8])
