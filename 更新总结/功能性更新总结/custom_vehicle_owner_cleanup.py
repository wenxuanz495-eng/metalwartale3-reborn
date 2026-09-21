# -*- coding: utf-8 -*-
"""
custom_vehicle_owner_cleanup.py — 定制战车介绍去「车主」（用户追加指示：战车车主也要删）

用户口径：与定制武器同理——战车介绍里「车主：谁谁谁」把车主名字删掉，
「车主」二字及冒号也不留（连同句末「。」一并移除，避免残留前导句号）。

范围：20_EmbedXml_xmlClass4.bin（战车配置）共 15 处，全部位于 <description> 开头：
  白金战车/Vincent 擎天柱/炮王 威震天/叫兽 亡语者/愤怒大机 擎天柱Ⅱ/Snow 幽明 闪电/
  AV、男纸 法拉利梦幻/斌斌 精灵斗士/焰の菲 补天士/小博士 奥迪Z/S神风追击 神风追击/
  死灵骑士 死灵骑士/爱の：-D甜心 飓风之锤/暗尘绝杀 月光/混沌荔枝 混沌荔枝
（同名车主列表与定制武器部分一致，属同一批定制活动的玩家署名。）
"""
import hashlib, re, os

BIN = r"D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets\20_EmbedXml_xmlClass4.bin"
PAT = re.compile(r'(?<=<description>)车主：[^。]*。')
EXPECT = 15

def main():
    raw = open(BIN, 'rb').read()
    old_hash = hashlib.sha256(raw).hexdigest()
    txt = raw.decode('utf-8')

    hits = PAT.findall(txt)
    assert len(hits) == EXPECT, "共 %d 处（期望 %d）：%s" % (len(hits), EXPECT, hits)

    new = PAT.sub('', txt)
    assert '车主' not in new, "替换后仍残留「车主」"
    # 覆盖未预期变体：全文其他位置不得再有「~主：」（如「机主：」）
    leftovers = re.findall(r'[^\s<>=]{1,4}主：[^。]*。', new)
    assert not leftovers, "仍有其他归属语残留：%s" % leftovers

    open(BIN, 'wb').write(new.encode('utf-8'))
    nb = open(BIN, 'rb').read()
    print("[OK] %s" % os.path.basename(BIN))
    print("     移除 %d 处：%s" % (len(hits), "、".join(hits)))
    print("     字节 %d -> %d（-%d）  SHA256 %s -> %s" % (
        len(raw), len(nb), len(raw) - len(nb), old_hash[:16].upper(), hashlib.sha256(nb).hexdigest()[:16].upper()))

if __name__ == '__main__':
    main()
