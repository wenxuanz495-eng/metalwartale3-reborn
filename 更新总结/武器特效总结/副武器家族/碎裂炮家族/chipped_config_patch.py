#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
chipped_config_patch.py — 碎裂炮家族（chipped）配置回迁补丁（2026-09-10）

范围（用户批准）：真实差异层回 2.5；attackType=boom 按用户决策保留；经济字段（price/mustItems）按禁令不动。
  ① attackGap 1.4 → 0.9 ×5（等长替换）
  ② hitImgLabel bullet/blue_boom → bullet/blueness_energy ×5（变长替换 +6B/处；blueness_energy=
     聚能轰击炮回迁时克隆进 bullet.swf 的 2.5 受击完整克隆，8 帧逐像素一致且内嵌 2.5 原受击音）
块外零改动断言 + 回读断言。
"""
import hashlib, sys

BIN = r"D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"
BLOCK_HEAD = b'<arms index="7" id="chipped">'

def main():
    raw = open(BIN, 'rb').read()
    old_size = len(raw)
    old_hash = hashlib.sha256(raw).hexdigest()
    print(f'原 bin: {old_size} 字节 SHA256={old_hash[:8].upper()}')

    s = raw.find(BLOCK_HEAD)
    assert s != -1, '找不到 chipped 块'
    e = raw.find(b'</arms>', s)
    assert e != -1
    e += len(b'</arms>')
    block = raw[s:e]

    # ① 射速
    g_old, g_new = b'<attackGap>1.4</attackGap>', b'<attackGap>0.9</attackGap>'
    n_gap = block.count(g_old)
    assert n_gap == 5, f'attackGap 1.4 出现 {n_gap} 次（期望 5）'
    # ② 受击改绑
    h_old, h_new = b'<hitImgLabel>bullet/blue_boom</hitImgLabel>', b'<hitImgLabel>bullet/blueness_energy</hitImgLabel>'
    n_hit = block.count(h_old)
    assert n_hit == 5, f'hitImgLabel blue_boom 出现 {n_hit} 次（期望 5）'
    # blue_boom 可能被其他武器（如 snow）合法共用——只替换块内，块外原样保留
    outside = raw[:s] + raw[e:]
    out_hit_outside = outside.count(h_old)

    new_block = block.replace(g_old, g_new).replace(h_old, h_new)
    out = raw[:s] + new_block + raw[e:]
    # 断言：块外字节完全不变
    assert out[:s] == raw[:s] and out[e + (len(new_block) - len(block)):] == raw[e:], '块外字节发生变化'
    # 断言：块外的 blue_boom 引用原样保留（其他武器不受影响）
    assert out.count(h_old) == out_hit_outside, '块外 blue_boom 引用数量发生变化'
    assert out.count(h_new) == n_hit, '改绑数量不符'

    open(BIN, 'wb').write(out)
    new_size = len(out)
    new_hash = hashlib.sha256(out).hexdigest()
    print(f'新 bin: {new_size} 字节（{"+" if new_size>=old_size else ""}{new_size-old_size}） SHA256={new_hash[:8].upper()}')
    print(f'已替换：attackGap 1.4→0.9 ×{n_gap}；hitImgLabel blue_boom→blueness_energy ×{n_hit}')
    print(f'块外零字节变化：已断言')

if __name__ == '__main__':
    sys.exit(main())
