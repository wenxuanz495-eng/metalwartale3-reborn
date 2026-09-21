#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
snake_body_merge.py — 纳米号家族（snake）本体时间轴整段回迁脚本（2026-09-10 第二批次）

用户批准范围：银蛇本体待机+开火+回落全段回 2.5；金蛇开火段与回落段同样回 2.5（用 3.4 金色换色模板，
其待机与当前版仅 3% 差随之归位）；开火音维持上一轮决策——银蛇=2422（2.5 音147 克隆，已存在）、金蛇=198（现保持）。
子弹/受击/属性字段不动。

  ① 银蛇 snake_lv1(591) 时间轴 ← 2.5 body 219 模板（挂点 110→104）
  ② 金蛇 snake_lv2(603) 时间轴 ← 3.4 body 228 模板（金色换色；挂点 110→104）
  ③ 模板内 StartSound(音147) 改绑：银蛇→2422，金蛇→198（均为 GH 包内已存在音，无需导入）
"""
import xml.etree.ElementTree as ET
import copy, os, sys

WORK = r"D:\superalloy\tmp-soya-family-test\snake-3ver-audit\work"
BASE_SWF = r"D:\superalloy	mp-soya-family-test\snake-3ver-audit\work\sub1130-snake.swf"  # 744837DA 中间态（本体回迁前）
BASE   = os.path.join(WORK, "sub1130-base.xml")     # 由当前仓库 sub1130 现导出
SRC25  = os.path.join(WORK, "sub37-25.xml")
SRC34  = os.path.join(WORK, "sub52-34.xml")
OUT    = os.path.join(WORK, "sub1130-snakebody-merged.xml")

MOUNT25, MOUNT_GH = 110, 104
TEMPLATES = [
    # (源xml, 源body id, 目标GH body id, StartSound 音id)
    (SRC25, 219, "591", "2422"),   # 银蛇 ← 2.5（音=上一轮克隆的 2.5 音）
    (SRC34, 228, "603", "198"),    # 金蛇 ← 3.4 金色换色模板（音=保留当前新音）
]

def tag_type(el): return el.get('type') or ''

def build_def_index(root):
    idx = {}
    for it in root.iter('item'):
        t = tag_type(it)
        if not t.startswith('Define'): continue
        for attr in ('characterID', 'shapeId', 'spriteId'):
            v = it.get(attr)
            if v is not None:
                idx.setdefault(int(v), it); break
    return idx

def collect_refs(el, acc):
    for e in el.iter():
        for attr in ('characterId', 'bitmapId'):
            v = e.get(attr)
            if v is not None and v.isdigit():
                acc.add(int(v))

def closure(defs, root_id):
    seen = set(); stack = [root_id]
    while stack:
        cid = stack.pop()
        if cid in seen or cid == MOUNT25: continue
        seen.add(cid)
        el = defs.get(cid)
        if el is None:
            print(f'  ⚠ 源中无定义 id={cid}'); continue
        refs = set(); collect_refs(el, refs)
        for r in refs:
            if r in defs and r not in seen: stack.append(r)
    return seen

def max_char_id(root):
    """最大已占用 ID。⚠ 必须把 soundId 一并计入：SWF 字典为单一命名空间，
    角色 ID 与音效 ID 不得撞号——第一版漏算 soundId，导致焰形填充位图 2421/2442
    与上轮克隆的开火音 2421/2422 撞号，Flash 渲染红方块（红块=缺位图填充）。"""
    m = 0
    for it in root.iter('item'):
        if not (tag_type(it)).startswith('Define'): continue
        for attr in ('characterID', 'shapeId', 'spriteId', 'soundId'):
            v = it.get(attr)
            if v is not None: m = max(m, int(v)); break
    return m

def main():
    # 0) 基准：从当前仓库 sub1130 现导出
    if not os.path.exists(BASE):
        import subprocess
        ff = r"D:\superalloy\归档\开发资料\tools\ffdec\ffdec-cli.exe"
        r = subprocess.run([ff, '-swf2xml', BASE_SWF, BASE], capture_output=True)
        assert r.returncode == 0, '基准 xml 导出失败'
    rgh = ET.parse(BASE).getroot()
    tags = rgh.find('tags')
    next_id = max_char_id(rgh) + 1
    print(f'基准 sub1130（当前仓库）最大 ID = {next_id-1}，新 ID 从 {next_id} 起')

    gh_sprites = {it.get('spriteId'): it for it in rgh.iter('item') if tag_type(it)=='DefineSpriteTag'}

    for src_path, src_body, gh_body, sound_id in TEMPLATES:
        rsrc = ET.parse(src_path).getroot()
        defs = build_def_index(rsrc)
        clo = closure(defs, src_body)
        import_ids = sorted(clo - {src_body, MOUNT25})
        remap = {MOUNT25: MOUNT_GH}
        for cid in import_ids:
            remap[cid] = next_id; next_id += 1
        print(f'-- 模板 {src_body} → GH {gh_body}：导入闭包 {len(import_ids)} 项（{min(remap[c] for c in import_ids)}~{next_id-1}）')

        last_def = max(i for i, it in enumerate(list(tags)) if tag_type(it).startswith('Define'))
        at = last_def + 1
        for cid in import_ids:
            ne = copy.deepcopy(defs[cid])
            for attr in ('characterID', 'shapeId', 'spriteId'):
                if ne.get(attr) is not None:
                    ne.set(attr, str(remap[cid])); break
            for e in ne.iter():
                for attr in ('characterId', 'bitmapId'):
                    v = e.get(attr)
                    if v is not None and v.isdigit() and int(v) in remap:
                        e.set(attr, str(remap[int(v)]))
            tags.insert(at, ne); at += 1

        # 时间轴整段替换
        src = defs[src_body]
        dst = gh_sprites[gh_body]
        fc = src.get('frameCount'); assert fc == '25', fc
        src_sub, dst_sub = src.find('subTags'), dst.find('subTags')
        # 模板原生 StartSound（音147）不搬，改用指定音挂同一帧（f6）
        orig_ss = next((ch for ch in src_sub if tag_type(ch)=='StartSoundTag'), None)
        assert orig_ss is not None
        orig_frame = 1; fpos = None
        for ch in src_sub:
            if tag_type(ch)=='ShowFrameTag': orig_frame += 1
            elif tag_type(ch)=='StartSoundTag': fpos = orig_frame
        assert fpos == 6, f'模板开火音挂帧 {fpos}（期望6）'
        for ch in list(dst_sub): dst_sub.remove(ch)
        frame = 1
        for ch in copy.deepcopy(list(src_sub)):
            t = tag_type(ch)
            if t == 'StartSoundTag': continue
            for e in ([ch] + list(ch.iter())):
                for attr in ('characterId', 'bitmapId'):
                    v = e.get(attr)
                    if v is not None and v.isdigit() and int(v) in remap:
                        e.set(attr, str(remap[int(v)]))
            dst_sub.append(ch)
            if t == 'ShowFrameTag':
                frame += 1
                if frame == fpos:   # 同帧位挂指定音（银蛇=2422 / 金蛇=198）
                    ss = copy.deepcopy(orig_ss); ss.set('soundId', sound_id)
                    dst_sub.insert(list(dst_sub).index(ch) + 1, ss)
        dst.set('frameCount', fc)
        print(f'   GH {gh_body} 时间轴已整段替换（音 {sound_id} @f{fpos}）')

    ET.ElementTree(rgh).write(OUT, encoding='utf-8', xml_declaration=True)
    print(f'输出：{OUT}')
    print('完成。下一步：xml2swf＋回读断言＋渲染验证。')

if __name__ == '__main__':
    sys.exit(main())
