# -*- coding: utf-8 -*-
# 黄金恶魔牙 LV3~LV6 数值调控（20260916，用户拍板：成长/控制训练超模 + 描述小数改百分号）
# 改动（仅 goldflyBlade 块，lv1/lv2 与本系 flyBlade 不动）：
#   specialType  Level_Growth_30/40/50/60 -> 25/30/35/40（lv3~lv6 原生成长）
#   addArr       subAdd:0.4/0.5/0.6/0.7  -> 0.35/0.4/0.45/0.5（控制训练）
#   description  自带0.4~0.7（小数）      -> 自带35%/40%/45%/50%（原作百分号形式）
# 安全：锚串逐条 count==1 断言（升序替换防串扰）、块外字节不变、六级逐字段回读
import sys
sys.stdout.reconfigure(encoding='utf-8')

BIN = r"..\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"
BLOCK_START = '<arms index="9" id="goldflyBlade">'
BLOCK_END = '</arms>'

data = open(BIN, 'rb').read().decode('utf-8')
i = data.find(BLOCK_START)
j = data.find(BLOCK_END, i)
assert i >= 0 and j > i
head, block, tail = data[:i], data[i:j + len(BLOCK_END)], data[j + len(BLOCK_END):]
print('块定位:', i, j + 7, 'len', len(block))

REPLACES = [
    ('<specialType>Level_Growth_30</specialType>', '<specialType>Level_Growth_25</specialType>'),
    ('<specialType>Level_Growth_40</specialType>', '<specialType>Level_Growth_30</specialType>'),
    ('<specialType>Level_Growth_50</specialType>', '<specialType>Level_Growth_35</specialType>'),
    ('<specialType>Level_Growth_60</specialType>', '<specialType>Level_Growth_40</specialType>'),
    ('<addArr>subAdd:0.4</addArr>', '<addArr>subAdd:0.35</addArr>'),
    ('<addArr>subAdd:0.5</addArr>', '<addArr>subAdd:0.4</addArr>'),
    ('<addArr>subAdd:0.6</addArr>', '<addArr>subAdd:0.45</addArr>'),
    ('<addArr>subAdd:0.7</addArr>', '<addArr>subAdd:0.5</addArr>'),
    ('<description>成长型武器,自带0.4的控制训练。</description>', '<description>成长型武器,自带35%的控制训练。</description>'),
    ('<description>成长型武器,自带0.5的控制训练。</description>', '<description>成长型武器,自带40%的控制训练。</description>'),
    ('<description>成长型武器,自带0.6的控制训练。</description>', '<description>成长型武器,自带45%的控制训练。</description>'),
    ('<description>成长型武器,自带0.7的控制训练。</description>', '<description>成长型武器,自带50%的控制训练。</description>'),
]
for old, new in REPLACES:
    assert block.count(old) == 1, ('锚串非唯一', old, block.count(old))
    block = block.replace(old, new)
print('12 条锚串替换完成（各恰 1 处）')

# ---------- 逐字段回读 ----------
import re
rows = re.findall(
    r'<name>([^<]+)</name>.*?<description>([^<]*)</description>.*?<specialType>Level_Growth_(\d+)</specialType>.*?<addArr>subAdd:([\d.]+)</addArr>',
    block, re.S)
assert len(rows) == 6, len(rows)
EXPECT = [
    ('黄金恶魔牙', '成长型武器,自带20%的控制训练。', '10', '0.2'),
    ('黄金撒旦之力', '成长型武器,自带30%的控制训练。', '20', '0.3'),
    ('黄金地狱之触', '成长型武器,自带35%的控制训练。', '25', '0.35'),
    ('黄金深渊之刃', '成长型武器,自带40%的控制训练。', '30', '0.4'),
    ('黄金灭世之手', '成长型武器,自带45%的控制训练。', '35', '0.45'),
    ('黄金诸神之殁', '成长型武器,自带50%的控制训练。', '40', '0.5'),
]
for got, exp in zip(rows, EXPECT):
    assert got == exp, (got, exp)
    print('回读 OK:', got)

# ---------- 块外字节不变（头尾切片断言，块长可变） ----------
new_data = head + block + tail
assert new_data.startswith(head) and new_data.endswith(tail), '块外字节变动'
open(BIN, 'wb').write(new_data.encode('utf-8'))
print('写出:', BIN, 'len', len(data), '->', len(new_data))
