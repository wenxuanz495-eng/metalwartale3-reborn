# -*- coding: utf-8 -*-
# cutter_gold 配置 1 级扩 5 级（20260917）
# 口径（用户拍板）：成长 +10~+50；其余照抄本家对应级（hurt/bulletWidth/commonLevel/price/reduceRa）；
# 成长型约定：mustLevel=1（无等级要求）；材料 superalloy_Y_numN 系（经济类后续可调）；
# 不加 subAdd 控制训练；受击 hitImgLabel=sub/cut_effect 不动；Jprice=48 保留
import hashlib

BIN = r"D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"
BAK = "work/config-bin-backup-before-gold-lv5.bin"

raw = open(BIN, "rb").read()
h0 = hashlib.sha256(raw).hexdigest().upper()
assert h0.startswith("51DCA719"), "config 底稿哈希不符: %s" % h0
open(BAK, "wb").write(raw)
text = raw.decode("utf-8")
print("[0] config 底稿哈希 PASS (51DCA719)，已备份")

gs = text.rindex("<arms", 0, text.index('id="cutter_gold"'))
ge = text.index("</arms>", gs) + len("</arms>")
block = text[gs:ge]
assert block.count("<armsLevel>") == 1, "现块应为单级"

node_start = block.index("<armsLevel>")
node_end = block.index("</armsLevel>") + len("</armsLevel>")
node = block[node_start:node_end]

# 模板内唯一锚串替换
REPL = [
    ("<name>黄金深渊</name>", "<name>{name}</name>"),
    ("<commonLevel>75</commonLevel>", "<commonLevel>{common}</commonLevel>"),
    ("<reduceRa>0.7</reduceRa>", "<reduceRa>0.5</reduceRa>"),
    ("<mustLevel>60</mustLevel>", "<mustLevel>1</mustLevel>"),
    ("<mustItems>2,240,100</mustItems>", "<mustItems>{items}</mustItems>"),
    ("<price>1000000</price>", "<price>{price}</price>"),
    ("<hurt>272</hurt>", "<hurt>{hurt}</hurt>"),
    ("<bulletWidth>25</bulletWidth>", "<bulletWidth>{width}</bulletWidth>"),
    ("<specialType>Level_Growth_50</specialType>", "<specialType>Level_Growth_{growth}</specialType>"),
    ("<imgLabel>cutter_gold</imgLabel>", "<imgLabel>cutter_gold_lv{lv}</imgLabel>"),
    ("<bulletImgLabel>sub/cutter_gold_bullet</bulletImgLabel>",
     "<bulletImgLabel>sub/cutter_gold_lv{lv}_bullet</bulletImgLabel>"),
]
for old, _ in REPL:
    assert node.count(old) == 1, "模板锚串非唯一或缺失: %s" % old

LEVELS = [
    dict(lv=1, name="黄金黑绳", common=27, hurt=118, width=10, price=20000, growth=10, items=""),
    dict(lv=2, name="黄金叫唤", common=31, hurt=148, width=15, price=50000, growth=20, items="superalloy_Y_num50"),
    dict(lv=3, name="黄金焦热", common=36, hurt=190, width=20, price=100000, growth=30, items="superalloy_Y_num100"),
    dict(lv=4, name="黄金无间", common=45, hurt=272, width=25, price=150000, growth=40, items="superalloy_Y_num150"),
    dict(lv=5, name="黄金深渊", common=70, hurt=272, width=25, price=500000, growth=50, items="superalloy_Y_num200"),
]

nodes = []
for lv in LEVELS:
    n = node
    for old, new in REPL:
        n = n.replace(old, new.format(**lv))
    nodes.append(n)

new_block = block[:node_start] + ("\n\t\t".join(nodes)) + block[node_end:]
# 单级模板节点本身成为 lv1 的位置：nodes[0] 替换原位置，其余按原缩进拼接
new_text = text[:gs] + new_block + text[ge:]

# 断言1：块外零变化
assert new_text[:gs] == text[:gs]
assert new_text[gs + len(new_block):] == text[ge:], "块外内容被改动!"
# 断言2：逐节点锚串回换——前向渲染后逆向替换必须精确还原模板节点
for lv in LEVELS:
    fwd = node
    for old, new in REPL:
        fwd = fwd.replace(old, new.format(**lv))
    back = fwd
    for old, new in REPL:
        back = back.replace(new.format(**lv), old)
    assert back == node, "锚串回换失败: lv%d" % lv["lv"]
# 断言3：逐字段回读
import re
check = new_text[new_text.rindex("<arms", 0, new_text.index('id="cutter_gold"')):]
check = check[:check.index("</arms>")]
n_levels = check.count("<armsLevel>")
assert n_levels == 5, "armsLevel 数=%d" % n_levels
for bi, lv in enumerate(LEVELS, 1):
    blk = check.split("<armsLevel>")[bi]
    g = lambda t: (re.search("<%s>(.*?)</%s>" % (t, t), blk) or [None, ""])[1]
    assert g("name") == lv["name"], (bi, g("name"))
    assert g("hurt") == str(lv["hurt"])
    assert g("bulletWidth") == str(lv["width"])
    assert g("commonLevel") == str(lv["common"])
    assert g("mustLevel") == "1"
    assert g("mustItems") == lv["items"]
    assert g("price") == str(lv["price"])
    assert g("reduceRa") == "0.5"
    assert g("specialType") == "Level_Growth_%d" % lv["growth"]
    assert g("imgLabel") == "cutter_gold_lv%d" % lv["lv"]
    assert g("bulletImgLabel") == "sub/cutter_gold_lv%d_bullet" % lv["lv"]
    assert g("hitImgLabel") == "sub/cut_effect"
    assert "subAdd" not in blk, "不应有控制训练"
    assert g("attackGap") == "0.9" and g("attackDelay") == "0.2" and g("bulletSpeed") == "30"
    assert g("energyUse") == "10" and g("followB") == "2" and g("penetrationB") == "1"
    assert g("specialProperty") == "跟踪，穿透，成长型"
# 断言4：本系 cutter 与其余家族块零变化
cutter_s = text.index('<arms index="4" id="cutter">')
cutter_e = text.index("</arms>", cutter_s) + len("</arms>")
assert text[cutter_s:cutter_e] == new_text[cutter_s:cutter_e], "本家 cutter 块被改动!"

out = new_text.encode("utf-8")
open(BIN, "wb").write(out)
print("[1] 五级块写入完成。块大小 %d -> %d 字节（%+d）" % (len(block), len(new_block), len(new_block) - len(block)))
print("[2] 新 bin SHA-256:", hashlib.sha256(out).hexdigest().upper()[:16])
