# -*- coding: utf-8 -*-
# goldflyBlade 配置追加 lv3~lv6（2026-09-16，用户已拍板成长值 30/40/50/60）
# 模板 = goldflyBlade lv2 节点，仅替换：name/description/mustItems/specialType/addArr/imgLabel
# 其余字段（hurt 1876 / commonLevel 60 / attackGap 0.9 / attackDelay 0.2 / bulletNum 2 /
# bulletTranslation 6 / subAdd 档位递增）沿金家既有口径
import sys, re, hashlib
sys.stdout.reconfigure(encoding='utf-8')

P = r"..\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"
before = open(P, encoding='utf-8').read()
hb = hashlib.sha256(before.encode('utf-8')).hexdigest().upper()
assert hb.startswith('0132FFE9'), hb
print('config bin 现状:', hb[:8])

j = before.find('id="goldflyBlade"')
i = before.rfind('<arms', 0, j)
e = before.find('</arms>', j)
blk = before[i:e]
lvs = re.findall(r'<armsLevel>.*?</armsLevel>', blk, re.S)
assert len(lvs) == 2, len(lvs)
tpl = lvs[1]   # lv2 节点

def setf(seg, field, value):
    return re.sub(r'<%s>[^<]*</%s>' % (field, field), '<%s>%s</%s>' % (field, value, field), seg, count=1)

LEVELS = [
    ('3', '黄金地狱之触', 'Level_Growth_30', 'subAdd:0.4', '0.4', 'superalloy_Y_num100'),
    ('4', '黄金深渊之刃', 'Level_Growth_40', 'subAdd:0.5', '0.5', 'superalloy_Y_num150'),
    ('5', '黄金灭世之手', 'Level_Growth_50', 'subAdd:0.6', '0.6', 'superalloy_Y_num200'),
    ('6', '黄金诸神之殁', 'Level_Growth_60', 'subAdd:0.7', '0.7', 'superalloy_Y_num300'),
]
news = []
for lv, name, growth, add, pct, items in LEVELS:
    seg = tpl
    seg = setf(seg, 'name', name)
    seg = setf(seg, 'description', '成长型武器,自带%s的控制训练。' % pct)
    seg = setf(seg, 'mustItems', items)
    seg = setf(seg, 'specialType', growth)
    seg = setf(seg, 'addArr', add)
    seg = setf(seg, 'imgLabel', 'goldflyBlade_lv' + lv)
    assert ('<name>' + name + '</name>') in seg, name
    assert ('<specialType>' + growth + '</specialType>') in seg
    assert ('<imgLabel>goldflyBlade_lv' + lv + '</imgLabel>') in seg
    assert ('</' + name + '>') not in seg and ('</Level_Growth') not in seg
    news.append(seg)
    print(f'{name}: growth={growth} add={add} items={items} img=goldflyBlade_lv{lv}')

insert = ''.join('\t\t' + s + '\n' for s in news)
after = before[:e] + insert + before[e:]
# 还原断言：删掉插入段应精确还原
assert after.replace(insert, '', 1) == before, '无法精确还原'
# 计数断言
assert after.count('goldflyBlade_lv3') == before.count('goldflyBlade_lv3') + 1
assert after.count('superalloy_Y_num100') == before.count('superalloy_Y_num100') + 1
# 本系块回归
i_fly = after.find('<arms index="9" id="flyBlade">')
fly = after[i_fly:after.find('</arms>', i_fly)]
assert re.findall(r'<bulletNum>(\d+)</bulletNum>', fly) == ['1', '2', '2', '2', '2', '2']
print('断言 PASS（可精确还原 / 本系六级原样）')

open(P, 'w', encoding='utf-8', newline='').write(after)
ha = hashlib.sha256(open(P, 'rb').read()).hexdigest().upper()
print('config bin:', hb[:8], '->', ha[:8])
