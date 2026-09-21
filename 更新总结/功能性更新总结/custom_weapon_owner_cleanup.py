# -*- coding: utf-8 -*-
"""
custom_weapon_owner_cleanup.py — 定制武器介绍去「武器主人」

用户口径：定制武器介绍里「武器主人：谁谁谁」这种模式 → 删除武器主人名字；
「武器主人」四个字及后面的冒号也不留（连同该句句末「。」一并移除，避免残留前导句号）。

范围（全仓库生效配置，共 14 处；均在 <description> 开头）：
  2_EmbedXml_xmlClass3_...bin  —— 8 处：7×「武器主人：X。」（dragonHead 龙之怒/beelzebub 魔王专用/
      moumouGun 小小的太阳/nuclearBomb 基洛夫/kaisazhilei 凯撒之泪/lightlizhi 曙光荔枝/shenfenpao 神风追击）
      ＋1×简写变体「主人：暗尘绝杀。」（hanbingfengbao 寒冰风暴）
  6_EmbedXml_xmlClass7_...bin  —— 6 处：4×「武器主人：X。」（windSword 塞巴斯塔/skullHeads 黑寡妇/
      blueKnife 龙吟/darklizhi 暗黑荔枝）＋2×简写变体「主人：X。」（killPig 杀猪刀/shilongren 噬龙刃）
不含 20_EmbedXml_xmlClass4 的「车主：X。」（战车车主，用户范围外）。
"""
import hashlib, re, os

ROOT = r"D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets"
FILES = [
    (os.path.join(ROOT, "2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin"), 8),
    (os.path.join(ROOT, "6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"), 6),
]
# 仅匹配 <description> 开头处的归属语；短变体「主人：」一并覆盖
PAT = re.compile(r'(?<=<description>)(?:武器)?主人：[^。]*。')

def main():
    total = 0
    for path, expect in FILES:
        raw = open(path, 'rb').read()
        old_hash = hashlib.sha256(raw).hexdigest()
        txt = raw.decode('utf-8')

        hits = PAT.findall(txt)
        assert len(hits) == expect, "共 %d 处（期望 %d）：%s" % (len(hits), expect, hits)
        # 全文其他位置不得再有「主人」（覆盖未预期变体）
        rest = PAT.sub('', txt)
        leftovers = re.findall(r'.{0,6}主人.{0,12}', rest)
        assert not leftovers, "仍有残留：%s" % leftovers

        new = PAT.sub('', txt)
        open(path, 'wb').write(new.encode('utf-8'))
        nb = open(path, 'rb').read()
        total += len(hits)
        print("[OK] %s" % os.path.basename(path))
        print("     移除 %d 处：%s" % (len(hits), "、".join(hits)))
        print("     字节 %d -> %d  SHA256 %s -> %s" % (
            len(raw), len(nb), old_hash[:16].upper(), hashlib.sha256(nb).hexdigest()[:16].upper()))
    print("[done] 合计移除 %d 处" % total)

if __name__ == '__main__':
    main()
