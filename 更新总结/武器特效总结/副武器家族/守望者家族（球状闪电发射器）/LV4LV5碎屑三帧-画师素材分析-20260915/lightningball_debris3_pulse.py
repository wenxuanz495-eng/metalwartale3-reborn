# -*- coding: utf-8 -*-
# 守望者 LV4/LV5 碎屑"全周期脉冲"修订脚本（2026-09-15 第二轮）
# 用户实机反馈：静态 3 帧观感远弱于 LV1~3；拍板"全套复刻 LV1"。
# 本轮：碎屑改为跨全周期放置（f1 占位 α0 → f12 隐），逐帧克隆 LV1 depth2 的
#       ColorTransform alpha 档 + ADD 混合 + GLOW 滤镜数值，三张画师图按强度档轮换：
#       f2=1@47% f3=1@80% f4=2@ADD f5=3@80% f6=3@47% f7=隐 f8=1@47% f9=2@80% f10=3@ADD f11=2@65% f12=隐
#       （f3=特效1 / f4=特效2 / f5=特效3 的用户核心对位保持；第二脉冲 f8~f10 复用三图）
# 复用已入库的 6 个精灵（2716/2719/2722、2725/2728/2731），零新增 ID。
# 铁律：底稿新鲜转储 + manifest 哈希断言；单棵 ElementTree。
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

TGT_SWF = "fresh_cur.swf"
OUT_XML = "sub1130-pulse.xml"
OUT_SWF = "sub1130-pulse.swf"
FFDEC = r"..\tools\packaging\ffdec\ffdec-cli.exe"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
LV1_SID = '1327'
BODY_SPRITES = {'1307', '1304'}

plan = {  # 级别 -> (本体精灵, [三精灵], translate)
    'LV4': ('1307', ['2716', '2719', '2722'], (0, 239)),
    'LV5': ('1304', ['2725', '2728', '2731'], (-14, 274)),
}
# 帧号 -> 该帧应显示的图（0/1/2 = 特效N-1 下标）；None = 沿用上一帧的图
FRAME_IMG = {1: 0, 2: 0, 3: 0, 4: 1, 5: 2, 6: 2, 7: 2, 8: 0, 9: 1, 10: 2, 11: 1, 12: 1}

# ---------- 0. 底稿断言 ----------
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(TGT_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper(), f"底稿 {actual[:8]} != manifest {manifest_line[:8]}"
print("底稿哈希断言 PASS:", actual[:8])

tree = ET.parse('fresh_cur.xml'); root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}

# ---------- 1. 提取 LV1 depth2 全套逐帧标签（CT/ADD/GLOW 的克隆源） ----------
lv1_frames = {}
frame = 1
for tag in sprites[LV1_SID].find('subTags'):
    t = tag.get('type') or ''
    if t == 'ShowFrameTag': frame += 1; continue
    if 'PlaceObject' in t and tag.get('depth') == '2':
        lv1_frames.setdefault(frame, tag)
assert set(lv1_frames) == set(range(1, 13)), sorted(lv1_frames)
print("LV1 depth2 逐帧标签已提取（f1~f12）")

# ---------- 2. 重建 LV4/LV5 的碎屑放置 ----------
DEBRIS_SPRITES = {s for _, ( _, ss, _) in plan.items() for s in ss}

def edit_body(sp, trio, pos):
    tx, ty = pos
    sub = sp.find('subTags')
    # 2.1 摘除旧静态版碎屑放置（f3/f4/f5 的 d2 PUT 与 f6 RemoveObject2）
    removed = 0
    for tag in list(sub):
        t = tag.get('type') or ''
        cid = tag.get('characterId')
        if 'PlaceObject' in t and tag.get('depth') == '2' and cid in DEBRIS_SPRITES:
            sub.remove(tag); removed += 1
        elif 'RemoveObject' in t and tag.get('depth') == '2':
            sub.remove(tag); removed += 1      # 第二轮的 f6 清场（f12 的 d4 清场不动）
    assert removed == 4, removed
    # 2.2 生成新序列：克隆 LV1 同帧标签，换角色/矩阵
    def clone_for(f, first):
        el = copy.deepcopy(lv1_frames[f])
        el.tag = 'item'
        img_idx = FRAME_IMG[f]
        if first:
            el.set('characterId', trio[img_idx])
            el.set('placeFlagHasCharacter', 'true')
            m = el.find('matrix')
            if m is None:
                m = ET.SubElement(el, 'matrix', {'type': 'MATRIX'})
            for k in ('hasScale', 'scaleX', 'scaleY', 'nScaleBits'):
                m.attrib.pop(k, None)
            m.set('hasRotate', 'false'); m.set('nRotateBits', '0')
            m.set('nTranslateBits', '10'); m.set('translateX', str(tx)); m.set('translateY', str(ty))
        else:
            if img_idx != FRAME_IMG[f - 1]:    # 图像轮换帧：带 characterId 的 move
                el.set('characterId', trio[img_idx])
                el.set('placeFlagHasCharacter', 'true')
            else:
                el.attrib.pop('characterId', None)
                el.set('placeFlagHasCharacter', 'false')
        el.set('depth', '2')
        el.set('placeFlagMove', 'true' if not first else 'false')
        return el
    new_tags = {f: clone_for(f, f == 1) for f in range(1, 13)}
    # 2.3 拼回时间轴（各帧内容末尾、ShowFrameTag 之前）
    out = []
    frame = 1
    for tag in list(sub):
        if (tag.get('type') or '') == 'ShowFrameTag':
            if frame in new_tags:
                out.append(new_tags.pop(frame))
            out.append(tag)
            frame += 1
        else:
            out.append(tag)
    assert not new_tags, new_tags.keys()
    sub[:] = out

for lv, (sid, trio, pos) in plan.items():
    edit_body(sprites[sid], trio, pos)
    print(f"{lv} 本体 {sid}: 碎屑全周期脉冲已重建（f1 占位 → f12 隐，三图轮换）")

# ---------- 3. 写出 ----------
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
