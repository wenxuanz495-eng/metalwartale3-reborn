# -*- coding: utf-8 -*-
# DoABC2 标签移植（2026-09-16）
# 手工拼 ABC 被 Flash 校验器拒绝(VerifyError#1107)，改用 mxmlc 正经编译 4 个存根类
# （goldflyBlade_lv3~lv6，dynamic MovieClip + basePoint/shootPoint 声明），把编译产物中的
# DoABC2 标签原样移植进 sub1130-lv36.swf（SWF 允许多 ABC 标签，编译器生成结构天然合法）。
# 插入位置：SymbolClass(tag 76) 之前。纯追加标签，不动任何现有标签。
import struct, sys, zlib, hashlib
sys.stdout.reconfigure(encoding='utf-8')

BASE = 'sub1130-lv36.swf'
OUT = 'sub1130-lv36-final.swf'
STUBS = ['probe/stub_lv3.swf', 'probe/stub_lv4.swf', 'probe/stub_lv5.swf', 'probe/stub_lv6.swf']

def parse_tags(body):
    tags = []
    pos = 0
    while pos < len(body):
        cl = struct.unpack('<H', body[pos:pos+2])[0]
        t = cl >> 6
        if cl & 0x3F == 0x3F:
            ln = struct.unpack('<I', body[pos+2:pos+6])[0]; hdr = 6
        else:
            ln = cl & 0x3F; hdr = 2
        if t == 0: break
        tags.append((t, body[pos+hdr:pos+hdr+ln]))
        pos += hdr + ln
    return tags

def tag_bytes(t, payload):
    if len(payload) < 0x3F:
        return struct.pack('<H', (t << 6) | len(payload)) + payload
    return struct.pack('<HI', (t << 6) | 0x3F, len(payload)) + payload

def swf_body(path):
    data = open(path, 'rb').read()
    sig = data[:3]
    if sig == b'CWS':
        return zlib.decompress(data[8:]), True
    return data[8:], False

def extract_doabc(path):
    body, _ = swf_body(path)
    nbits = body[0] >> 3
    pos = (5 + nbits*4 + 7)//8 + 4      # 跳过 RECT + framerate/framecount
    for t, payload in parse_tags(body[pos:]):
        if t == 82:
            return payload
    raise KeyError(path)

# ---------- 1. 收集 4 个 DoABC2 ----------
abc_tags = []
for s in STUBS:
    p = extract_doabc(s)
    abc_tags.append(p)
    print(f'{s}: DoABC2 {len(p)} 字节')

# ---------- 2. 解析主 SWF ----------
body, compressed = swf_body(BASE)
nbits = body[0] >> 3
rect_len = (5 + nbits*4 + 7)//8
head, rest = body[:rect_len+4], body[rect_len+4:]
tags = parse_tags(rest)
print(f'主 SWF: {len(tags)} 个标签, 压缩={compressed}')

# ---------- 3. 在 SymbolClass 前插入 ----------
out_tags = []
inserted = 0
for t, p in tags:
    if t == 76 and inserted == 0:
        for pabc in abc_tags:
            out_tags.append((82, pabc)); inserted += 1
    out_tags.append((t, p))
assert inserted == 4, inserted
print(f'插入 {inserted} 个 DoABC2，新标签数 {len(tags)} -> {len(out_tags)}')

# ---------- 4. 写出 ----------
newbody = head + b''.join(tag_bytes(t, p) for t, p in out_tags)
raw = bytearray(b'FWS' + b'\x00'*(0) )
sig_out = b'CWS' if compressed else b'FWS'
ver = open(BASE,'rb').read()[3]
if compressed:
    comp = zlib.compress(bytes(newbody))
    out = sig_out + bytes([ver]) + struct.pack('<I', 8 + len(comp)) + comp[0:0] + comp
    # 注意：CWS 的 filelength 是解压后总长
    out = sig_out + bytes([ver]) + struct.pack('<I', 8 + len(newbody)) + comp
else:
    out = sig_out + bytes([ver]) + struct.pack('<I', 8 + len(newbody)) + newbody
open(OUT, 'wb').write(out)
print('写出:', OUT, hashlib.sha256(open(OUT,'rb').read()).hexdigest().upper()[:8])
