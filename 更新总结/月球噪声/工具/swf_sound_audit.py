#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SWF 声音接线审计(两遍解析) —— 登场噪声考 2026-10-05
审计面:
  1. DefineSound(14): 声音资产清单(cid, 采样数, 时长, 数据MD5)
  2. StartSound(15): 挂在哪个 sprite 的第几帧, 循环次数
  3. FrameLabel(43): sprite 内帧标签(stand/move/shoot1/fly/die...)及帧区间
  4. SoundStreamHead(18/45)+SoundStreamBlock(19): 流式音轨(逐帧音频,上会话未查)
  5. DefineSprite(39) 递归 + SymbolClass(76): 文档类/导出名 -> cid 映射
输出: 每个 swf 一份接线报告 + 可选导出 mp3
"""
import sys, zlib, hashlib, struct
from pathlib import Path

def read_swf(path):
    raw = Path(path).read_bytes()
    sig, ver = raw[:3], raw[3]
    flen = struct.unpack('<I', raw[4:8])[0]
    if sig == b'CWS':
        body = zlib.decompress(raw[8:])
    elif sig == b'ZWS':
        body = lzma_alone(raw[12:])
    elif sig == b'FWS':
        body = raw[8:]
    else:
        raise ValueError(f'{path}: 非SWF {sig}')
    return body  # 头之后已解压体(从FrameSize开始)

def lzma_alone(d):
    import lzma
    # SWF ZWS: 4字节压缩后长度 + 5字节LZMA属性 + 8字节解压后大小 + 数据 = LZMA ALONE 格式
    return lzma.decompress(d, format=lzma.FORMAT_ALONE)

def read_rect(b, p):
    nbits = b[p] >> 3
    total = 5 + nbits * 4
    return p + (total + 7) // 8

def parse_tags(body, p=0):
    """迭代 (code, payload)"""
    n = len(body)
    while p < n - 1:
        (h,) = struct.unpack_from('<H', body, p); p += 2
        code = h >> 6
        ln = h & 0x3F
        if ln == 0x3F:
            (ln,) = struct.unpack_from('<I', body, p); p += 4
        yield code, body[p:p+ln]
        p += ln
        if code == 0:
            break

RATES = {0:5512, 1:11025, 2:22050, 3:44100}

def parse_soundinfo(b, off):
    """StartSound 的 SoundInfo -> (loops, inPoint, outPoint, hasEnvelope)"""
    f = b[off]; off += 1
    hasIn = f & 1; hasOut = f & 2; hasLoop = f & 4; hasEnv = f & 8
    syncStop = (f >> 5) & 1; syncNoMulti = (f >> 6) & 1
    inP = outP = loops = 0
    if hasIn: (inP,) = struct.unpack_from('<I', b, off); off += 4
    if hasOut: (outP,) = struct.unpack_from('<I', b, off); off += 4
    if hasLoop: (loops,) = struct.unpack_from('<H', b, off); off += 2
    return dict(loops=loops, inPoint=inP, outPoint=outP,
                syncStop=syncStop, syncNoMultiple=syncNoMulti, hasEnvelope=bool(hasEnv))

def audit(path, export_dir=None):
    body = read_swf(path)
    p = read_rect(body, 0)
    p += 4  # frameRate u16 + frameCount u16
    # 第一遍: 收 DefineSound / SymbolClass
    sounds = {}   # cid -> dict(fmt, rate, sampleCount, md5, size)
    symbolclass = {}  # name -> cid
    for code, pl in parse_tags(body, p):
        if code == 14 and len(pl) >= 7:
            cid = struct.unpack_from('<H', pl, 0)[0]
            flags = pl[2]
            fmt = flags >> 4; rate = RATES[(flags >> 2) & 3]
            size16 = (flags >> 1) & 1
            (sc,) = struct.unpack_from('<I', pl, 3)
            data = pl[7:]
            if fmt == 2 and len(data) >= 2:
                data = data[2:]  # MP3 前有 u16 seek
            sounds[cid] = dict(fmt=fmt, rate=rate, sampleCount=sc,
                               bytes=len(data), md5=hashlib.md5(data).hexdigest()[:8])
            if export_dir and fmt == 2 and data[:2] != b'\xff\xfb' and data[:1] == b'\xff':
                pass
            if export_dir and fmt == 2:
                out = Path(export_dir) / f'{Path(path).stem}_cid{cid}_{sc}s_{hashlib.md5(data).hexdigest()[:8]}.mp3'
                out.write_bytes(data)
        elif code == 76:
            (cnt,) = struct.unpack_from('<H', pl, 0); q = 2
            for _ in range(cnt):
                (cid,) = struct.unpack_from('<H', pl, q); q += 2
                end = pl.index(b'\x00', q)
                name = pl[q:end].decode('utf-8', 'replace'); q = end + 1
                symbolclass[name] = cid
    # 第二遍: 递归 sprite, 记录帧标签/StartSound/流音轨
    report = dict(file=str(path), sounds=sounds, symbolclass=symbolclass,
                  sprites={}, streams=[])
    def walk(tags, prefix, sid):
        frame = 0
        labels = {}      # label -> frame
        starts = []      # (frame, soundCid, info)
        streams = []     # (frame, fmt, rate) 头
        nblocks = 0; nbytes = 0
        has_stream_head = False
        sfmt = srate = None
        for code, pl in tags:
            if code == 1:  # ShowFrame
                frame += 1
            elif code == 43:  # FrameLabel
                name = pl.rstrip(b'\x00').split(b'\x00')[0].decode('utf-8', 'replace')
                labels.setdefault(name, frame + 1)
            elif code == 15 and len(pl) >= 3:  # StartSound
                scid = struct.unpack_from('<H', pl, 0)[0]
                info = parse_soundinfo(pl, 2)
                starts.append(dict(frame=frame + 1, soundCid=scid, **info))
            elif code in (18, 45):  # SoundStreamHead
                flags = pl[0]
                sfmt = flags >> 4; srate = RATES[(flags >> 2) & 3]
                has_stream_head = True
                streams.append(dict(headAt=frame + 1, fmt=sfmt, rate=srate))
            elif code == 19:
                nblocks += 1
                nbytes += len(pl)
            elif code == 39:  # DefineSprite 递归
                scid = struct.unpack_from('<H', pl, 0)[0]
                sub = parse_tags(pl[4:], 0)
                walk(sub, f'{prefix}{sid}/', scid)
        if starts or streams:
            key = f'sprite{sid}'
            report['sprites'][prefix + key if prefix else key] = dict(
                labels=labels, startSounds=starts, streamHeads=streams,
                streamBlocks=nblocks, streamBytes=nbytes)
    walk(parse_tags(body, p), '', 0)
    return report

def fmt_report(r):
    L = [f"== {r['file']} =="]
    sc = r['symbolclass']
    if sc:
        L.append('  SymbolClass: ' + ', '.join(f'{k}->cid{v}' for k, v in sorted(sc.items(), key=lambda x: x[1])))
    L.append(f"  DefineSound: {len(r['sounds'])} 个")
    for cid, s in sorted(r['sounds'].items()):
        dur = s['sampleCount'] / s['rate'] if s['rate'] and s['sampleCount'] else 0
        L.append(f"    cid{cid}: fmt{s['fmt']} {s['rate']}Hz {s['sampleCount']}采样 ≈{dur:.2f}s md5={s['md5']} {s['bytes']}B")
    if r['sprites']:
        for sid, sp in sorted(r['sprites'].items()):
            labs = ' '.join(f'[{k}@f{v}]' for k, v in sorted(sp['labels'].items(), key=lambda x: x[1]))
            L.append(f"  {sid}: 标签 {labs if labs else '(无)'}")
            for st in sp['startSounds']:
                sd = r['sounds'].get(st['soundCid'], {})
                L.append(f"    ★StartSound 帧{st['frame']} -> cid{st['soundCid']} loops={st['loops']} "
                         f"(md5={sd.get('md5','?')} ≈{(sd.get('sampleCount',0)/sd.get('rate',1)) if sd.get('rate') else '?':.2f}s)")
            for sh in sp['streamHeads']:
                nb, nb2 = sp.get('streamBlocks', 0), sp.get('streamBytes', 0)
                tag = f"块{nblocks_str(nb)}块/{nb2}B" if False else f"{nb}块/{nb2}B"
                mark = '  ◆有数据' if nb2 > 0 else '(空,工具残留)'
                L.append(f"    ★流式音轨: 从帧{sh['headAt']}起 fmt{sh['fmt']} {sh['rate']}Hz {tag}{mark}")
    else:
        L.append('  (无 sprite 挂声/流音轨)')
    return '\n'.join(L)

if __name__ == '__main__':
    export = None
    args = sys.argv[1:]
    if args and args[0] == '--export':
        export = args[1]; args = args[2:]
        Path(export).mkdir(parents=True, exist_ok=True)
    for f in args:
        try:
            print(fmt_report(audit(f, export)))
        except Exception as e:
            print(f'== {f} == 解析失败: {type(e).__name__}: {e}')
        print()
