#!/usr/bin/env python3
# star_replay.py — 星爆家族(highEnergy)回迁重放：把 2026-09-11 被静默回退的 sub1130 改动
# 重新应用到当前基线（sub1130=3CEFC59F，含后续恶魔牙/守望者/黄金恶魔牙/高周波/星际雷神改动）。
# 逻辑沿用原 starburst_restore.py（已由 11/11 像素 0.00% 验证），改动：
#   1) 新 ID 从当前文件全局最大 ID+1 起动态分配（避免与后续家族占号冲突）；
#   2) 同内容音效去重时只导入一份（原脚本会重复插入同一 ID 的 DefineSoundTag）；
#   3) scale_matrices 修复：原函数在 hasScale=false 分支硬编码 1.15，改为使用传入 factor；
#   4) 2026-09-21 实测调整（用户口径）：lv1/lv2 子弹改为 b2 美术 ×0.8（加闪烁＋缩小体积）、
#      lv6/lv7 子弹由 b3×1.15 改为 b3×1.30。b1(#356) 不再使用，其独有形状不入闭包。
import re, hashlib

BASE = r"D:\superalloy\TMP\3.0.0特效复古任务-家族TMP\星爆家族"
TOKEN = re.compile(r'<item[^>]*?(/?)>|</item>')
REF_ATTRS = re.compile(r'((?:characterId|characterID|spriteId|shapeId|soundId|bitmapId|fontId)=")(\d+)(")')
MAXID_ATTRS = re.compile(r'(?:characterId|characterID|spriteId|shapeId|soundId|bitmapId|fontId|textId|buttonId|morphShapeId)="(\d+)"')

def load(p): return open(p, encoding="utf-8", errors="ignore").read()

def block_span(txt, pos):
    depth = 0
    start = pos
    for mt in TOKEN.finditer(txt, pos):
        t = mt.group(0)
        if t == '</item>':
            depth -= 1
            if depth == 0: return start, mt.end()
        elif not t.endswith('/>'): depth += 1
    raise RuntimeError("unbalanced")

def renumber(block, idmap):
    return REF_ATTRS.sub(lambda m: m.group(1) + (str(idmap[int(m.group(2))]) if int(m.group(2)) != 65535 and int(m.group(2)) in idmap else m.group(2)) + m.group(3), block)

def parse_definitions(txt):
    out = []
    pat = re.compile(r'<item type="(Define[A-Za-z0-9]+Tag)"([^>]*?)(/?)>')
    for m in pat.finditer(txt):
        kind, attrs, selfclose = m.group(1), m.group(2), m.group(3)
        if kind == "DefineSpriteTag": id_attr = "spriteId"
        elif kind == "DefineSoundTag": id_attr = "soundId"
        elif kind.startswith("DefineShape"): id_attr = "shapeId"
        elif kind.startswith("DefineBits"): id_attr = "characterID"
        else: id_attr = "characterId"
        am = re.search(id_attr + r'="(\d+)"', attrs)
        if not am: continue
        cid = int(am.group(1))
        if selfclose == '/':
            s, e, block = m.start(), m.end(), m.group(0)
        else:
            try: s, e = block_span(txt, m.start())
            except RuntimeError: continue
            block = txt[s:e]
        out.append({"kind": kind, "cid": cid, "start": s, "end": e, "block": block,
                    "refs": set(int(v) for _, v, _ in REF_ATTRS.findall(block))})
    return out

def closure_from(index, roots):
    seen = {}
    stack = list(roots)
    while stack:
        cid = stack.pop()
        if cid in seen or cid not in index: continue
        rec = index[cid]; seen[cid] = rec
        for r in rec["refs"]:
            if r not in seen: stack.append(r)
    return seen

def sound_hash(block):
    d = re.search(r'soundData="([0-9a-f]*)"', block)
    return hashlib.sha256(bytes.fromhex(d.group(1))).hexdigest() if d else None

def scale_matrices(fragment, factor):
    out = []
    pos = 0
    pat = re.compile(r'<matrix type="MATRIX"([^>]*)/>')
    for m in pat.finditer(fragment):
        attrs = m.group(1)
        hs = re.search(r'hasScale="true"', attrs)
        if hs:
            sx = float(re.search(r'scaleX="([-\d.eE]+)"', attrs).group(1))
            sy = float(re.search(r'scaleY="([-\d.eE]+)"', attrs).group(1))
            new_attrs = re.sub(r'scaleX="[-\d.eE]+"', f'scaleX="{sx*factor}"', attrs)
            new_attrs = re.sub(r'scaleY="[-\d.eE]+"', f'scaleY="{sy*factor}"', new_attrs)
            out.append(fragment[pos:m.start()] + f'<matrix type="MATRIX"{new_attrs}/>')
        else:
            new_attrs = attrs.replace('hasScale="false"', 'hasScale="true"')
            if 'nScaleBits' not in new_attrs:
                new_attrs = new_attrs.replace('hasRotate', 'hasScale="true" nRotateBits="0" nRotateBits', 1) if 'nRotateBits' in new_attrs else new_attrs + ' nScaleBits="16"'
            new_attrs = re.sub(r'nScaleBits="\d+"', 'nScaleBits="16"', new_attrs)
            if 'scaleX' not in new_attrs:
                new_attrs = re.sub(r'hasScale="true"', f'hasScale="true" scaleX="{factor}" scaleY="{factor}"', new_attrs)
            else:
                new_attrs = re.sub(r'scaleX="[-\d.eE]+"', f'scaleX="{factor}"', new_attrs)
                new_attrs = re.sub(r'scaleY="[-\d.eE]+"', f'scaleY="{factor}"', new_attrs)
            out.append(fragment[pos:m.start()] + f'<matrix type="MATRIX"{new_attrs}/>')
        pos = m.end()
    out.append(fragment[pos:])
    return "".join(out)

def main():
    log = []
    def P(s): print(s, flush=True); log.append(s)

    cur = load("sub1130-now.xml")
    d25 = parse_definitions(load("sub37-25.xml"))
    d34 = parse_definitions(load("sub52-34.xml"))
    idx25 = {r["cid"]: r for r in d25}
    idx34 = {r["cid"]: r for r in d34}

    # 动态 ID 起点
    vals = [int(x) for x in MAXID_ATTRS.findall(cur) if int(x) < 60000]
    next_id = max(vals) + 1
    P(f"[alloc] 当前文件全局最大 ID {next_id-1}，新 ID 从 {next_id} 起")

    clos25 = closure_from(idx25, [376, 373, 370, 349, 341])
    clos34 = closure_from(idx34, [618, 585])
    P(f"[closure] 2.5 闭包 {len(clos25)} 项；3.4 闭包 {len(clos34)} 项")

    idmap25, idmap34 = {}, {}
    sound_by_hash = {}
    import_recs = []  # (order_key, rec_new_block_holder)
    for ns, clos, idmap in [("25", clos25, idmap25), ("34", clos34, idmap34)]:
        for rec in sorted(clos.values(), key=lambda r: r["start"]):
            if rec["kind"] == "DefineSoundTag":
                h = sound_hash(rec["block"])
                if h and h in sound_by_hash:
                    idmap[rec["cid"]] = sound_by_hash[h]
                    P(f"[dedupe] {ns} 音 #{rec['cid']} 与已分配音同内容 -> 复用新 ID {sound_by_hash[h]}（不重复导入）")
                    continue
                idmap[rec["cid"]] = next_id
                sound_by_hash[h] = next_id
                import_recs.append((ns, rec))
                P(f"[alloc] {ns} 音 #{rec['cid']} -> {next_id}")
                next_id += 1
                continue
            idmap[rec["cid"]] = next_id
            import_recs.append((ns, rec))
            next_id += 1
    P(f"[alloc] 新 ID 区间 {min(idmap25.values())}..{next_id-1}")

    for rec in clos25.values():
        rec["new_block"] = renumber(rec["block"], idmap25)
    for rec in clos34.values():
        rec["new_block"] = renumber(rec["block"], idmap34)

    fire_new = idmap25[361]
    P(f"[alloc] 开火音(2.5#361=3.4#359 同内容) -> {fire_new}")

    imports25 = [rec["new_block"] for ns, rec in import_recs if ns == "25"]
    imports34 = [rec["new_block"] for ns, rec in import_recs if ns == "34"]
    P(f"[imports] 2.5 {len(imports25)} 项 + 3.4 {len(imports34)} 项（去重后）")

    body_map = {785: ("34", 618), 782: ("34", 585), 776: ("25", 376), 773: ("25", 373), 770: ("25", 370)}
    # (来源, 缩放)：lv1/lv2 = b2 美术 ×0.8（实测口径：加闪烁＋缩小体积）；lv3/lv4 = b2 原大小；lv5 = b3 原大小
    bullet_map = {750: ("25", 349, 0.8), 748: ("25", 349, 0.8), 746: ("25", 349, 1.0), 744: ("25", 349, 1.0), 742: ("25", 341, 1.0)}

    dcur = parse_definitions(cur)
    cur_sprites = {r["cid"]: r for r in dcur if r["kind"] == "DefineSpriteTag"}
    edits = []
    first_target = None

    for tid, (ns, src) in body_map.items():
        rec = (clos34 if ns == "34" else clos25)[src]
        fc = re.search(r'frameCount="(\d+)"', rec["new_block"][:300]).group(1)
        tgt = cur_sprites[tid]
        open_tag = re.sub(r'frameCount="\d+"', f'frameCount="{fc}"', re.match(r'<item type="DefineSpriteTag"[^>]*>', tgt["block"]).group(0))
        d_open = re.match(r'<item type="DefineSpriteTag"[^>]*>', rec["new_block"]).group(0)
        d_inner = rec["new_block"][len(d_open):-len("</item>")]
        edits.append((tgt["start"], tgt["end"], open_tag + d_inner + "</item>"))
        first_target = min(first_target, tgt["start"]) if first_target else tgt["start"]
        P(f"[body] {tid} <- {ns} #{src} (fc={fc})")

    for tid, (ns, src, fac) in bullet_map.items():
        rec = clos25[src] if ns == "25" else clos34[src]
        fc = re.search(r'frameCount="(\d+)"', rec["new_block"][:300]).group(1)
        donor = scale_matrices(rec["new_block"], fac) if fac != 1.0 else rec["new_block"]
        tgt = cur_sprites[tid]
        open_tag = re.sub(r'frameCount="\d+"', f'frameCount="{fc}"', re.match(r'<item type="DefineSpriteTag"[^>]*>', tgt["block"]).group(0))
        d_open = re.match(r'<item type="DefineSpriteTag"[^>]*>', donor).group(0)
        d_inner = donor[len(d_open):-len("</item>")]
        edits.append((tgt["start"], tgt["end"], open_tag + d_inner + "</item>"))
        first_target = min(first_target, tgt["start"]) if first_target else tgt["start"]
        P(f"[bullet] {tid} <- {ns} #{src} (fc={fc}, scale={fac})")

    # lv6/lv7 子弹：b3 ×1.30（2026-09-21 实测口径"略微大一些"，由 ×1.15 上调）
    b3rec = clos25[341]
    fc3 = re.search(r'frameCount="(\d+)"', b3rec["new_block"][:300]).group(1)
    scaled = scale_matrices(b3rec["new_block"], 1.30)
    for tid in (740, 739):
        tgt = cur_sprites[tid]
        open_tag = re.sub(r'frameCount="\d+"', f'frameCount="{fc3}"', re.match(r'<item type="DefineSpriteTag"[^>]*>', tgt["block"]).group(0))
        d_open = re.match(r'<item type="DefineSpriteTag"[^>]*>', scaled).group(0)
        d_inner = scaled[len(d_open):-len("</item>")]
        edits.append((tgt["start"], tgt["end"], open_tag + d_inner + "</item>"))
        first_target = min(first_target, tgt["start"])
        P(f"[bullet-scaled] {tid} <- 2.5 #341 x1.30 (fc={fc3})")

    # lv6/lv7 本体分层手术
    for tid, own_body in ((767, 766), (764, 752)):
        own_rec = cur_sprites[tid]
        own_open = re.match(r'<item type="DefineSpriteTag"[^>]*>', own_rec["block"]).group(0)
        own_inner = own_rec["block"][len(own_open):-len("</item>")]
        first_seg = re.split(r'(<item type="ShowFrameTag"[^>]*/>)', own_inner)[0]
        own_f1 = []
        for m in re.finditer(r'<item type="PlaceObject[23]Tag"[^>]*>(?:\s*<matrix[^>]*/>)?\s*</item>|<item type="PlaceObject[23]Tag"[^>]*/>', first_seg):
            own_f1.append(m.group(0))
        rec370 = clos25[370]
        tl = rec370["new_block"]
        tl_open = re.match(r'<item type="DefineSpriteTag"[^>]*>', tl).group(0)
        tl_inner = tl[len(tl_open):-len("</item>")]
        body_new = idmap25[358]; anch_new = idmap25[110]
        depth_remap = {"3": "6", "5": "8", "2": "2"}
        parts = re.split(r'(<item type="ShowFrameTag"[^>]*/>)', tl_inner)
        kept = []
        for seg in parts:
            if seg.startswith("<item type=\"ShowFrameTag\""):
                kept.append(seg); continue
            out_pos = 0; buf = ""
            for m in re.finditer(r'<item type="(PlaceObject[23]|RemoveObject)Tag"([^>]*?)(/?)>', seg):
                kind, attrs = m.group(1), m.group(2)
                if m.group(0).rstrip().endswith('/>'):
                    s_i, e_i = m.start(), m.end()
                else:
                    s_i = m.start()
                    depth2 = 1
                    e_i = m.end()
                    for mt in TOKEN.finditer(seg, m.end()):
                        t2 = mt.group(0)
                        if t2 == '</item>':
                            depth2 -= 1
                            if depth2 == 0: e_i = mt.end(); break
                        elif not t2.endswith('/>'): depth2 += 1
                cid = re.search(r'characterId="(\d+)"', attrs)
                dep = re.search(r'depth="(\d+)"', attrs)
                drop = False
                new_dep = dep.group(1) if dep else None
                if cid and int(cid.group(1)) in (body_new, anch_new):
                    drop = True
                elif kind == "RemoveObject" and new_dep == "1":
                    drop = True
                elif dep and new_dep in depth_remap and kind.startswith("PlaceObject"):
                    new_dep = depth_remap[new_dep]
                elif dep and new_dep in depth_remap and kind == "RemoveObject":
                    new_dep = depth_remap[new_dep]
                el = seg[s_i:e_i]
                if not drop and new_dep:
                    el = re.sub(r'depth="\d+"', f'depth="{new_dep}"', el)
                if drop:
                    buf += seg[out_pos:m.start()]
                else:
                    buf += seg[out_pos:m.start()] + el
                out_pos = e_i
            buf += seg[out_pos:]
            kept.append(buf)
        tl_stripped = "".join(kept)
        m_st = re.search(r'<subTags>', tl_stripped)
        m_se = re.search(r'</subTags>\s*$', tl_stripped)
        inner_content = tl_stripped[m_st.end(): m_se.start()] if (m_st and m_se) else tl_stripped
        new_inner = "<subTags>\n" + "\n".join(own_f1) + "\n" + inner_content + "\n</subTags>"
        open_tag = re.sub(r'frameCount="\d+"', 'frameCount="30"', re.match(r'<item type="DefineSpriteTag"[^>]*>', own_rec["block"]).group(0))
        edits.append((own_rec["start"], own_rec["end"], open_tag + new_inner + "</item>"))
        first_target = min(first_target, own_rec["start"])
        P(f"[surgery] {tid}: 保留本体 {own_body}+锚点，插入 2.5 lv3 特效层(depth 2/6/8)")

    edits.sort(key=lambda x: (x[0], x[1]), reverse=True)
    for s, e, rep in edits:
        cur = cur[:s] + rep + cur[e:]
    P(f"[apply] {len(edits)} 处替换完成")

    all_imports = "\n".join(imports25 + imports34)
    cur = cur[:first_target] + all_imports + "\n" + cur[first_target:]
    P(f"[imports] 插入 {len(imports25)+len(imports34)} 项闭包")

    open(BASE + "\\sub1130-merged.xml", "w", encoding="utf-8", newline="\n").write(cur)
    P("[done] sub1130-merged.xml written")
    open(BASE + "\\replay_log.txt", "w", encoding="utf-8").write("\n".join(log))

if __name__ == "__main__":
    main()
