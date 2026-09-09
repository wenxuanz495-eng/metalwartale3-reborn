#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
snake_config_patch.py — 纳米号家族（snake）受击改绑配置补丁（2026-09-10）

用户批准范围：受击特效回 2.5 版（银蛇+金蛇两级）；子弹保留 3.4 后版本；本体时间轴与属性字段不动。
  hitImgLabel: sub/cutter_hit_effect → sub/cut_effect ×2（变长 -7B/处）
  cut_effect(1985) = 高周波切割炮家族回迁时克隆进 sub1130 的 2.5 版 cutter_hit_effect 六态＋原受击音
块外零改动断言（cutter_hit_effect 被多武器共用，严禁原位替换/全局替换）。
"""
import hashlib, sys

BIN = r"D:\superalloy\metalwartale3-reborn.git\decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin"
BLOCK_HEAD = b'<arms index="12" id="snake">'

def main():
    raw = open(BIN, 'rb').read()
    old_size = len(raw)
    print(f'原 bin: {old_size} 字节 SHA256={hashlib.sha256(raw).hexdigest()[:8].upper()}')

    s = raw.find(BLOCK_HEAD)
    assert s != -1, '找不到 snake 块'
    e = raw.find(b'</arms>', s) + len(b'</arms>')
    block = raw[s:e]

    h_old, h_new = b'<hitImgLabel>sub/cutter_hit_effect</hitImgLabel>', b'<hitImgLabel>sub/cut_effect</hitImgLabel>'
    n = block.count(h_old)
    assert n == 2, f'snake 块内 cutter_hit_effect 出现 {n} 次（期望 2）'
    outside = raw[:s] + raw[e:]
    out_n_outside = outside.count(h_old)   # 块外保留数（其他武器共用）

    new_block = block.replace(h_old, h_new)
    out = raw[:s] + new_block + raw[e:]
    # 断言：块外字节完全不变
    assert out[:s] == raw[:s] and out[e + (len(new_block) - len(block)):] == raw[e:], '块外字节发生变化'
    assert out.count(h_old) == out_n_outside, '块外 cutter_hit_effect 数量变化'
    assert out.count(h_new) >= n, '改绑数量异常'

    open(BIN, 'wb').write(out)
    print(f'新 bin: {len(out)} 字节（{len(out)-old_size:+d}） SHA256={hashlib.sha256(out).hexdigest()[:8].upper()}')
    print(f'已改绑：hitImgLabel sub/cutter_hit_effect→sub/cut_effect ×{n}；块外 {out_n_outside} 处共用原样保留')

if __name__ == '__main__':
    sys.exit(main())
