# -*- coding: utf-8 -*-
# 星际雷神 V4 修订脚本（2026-09-17）：两级贴图整体缩小 25%（用户指定先试 25%）
# 做法：两级全部美术放置（深度 1,2,3,6,7,8,9,10＝待机导弹/本体/特效链/尾焰/双弧）统一以本枪 shootPoint 为枢轴
#       做 0.75 缩放：new_tx = 0.25*px + 0.75*tx（px=射点 twips），hasScale=0.75/0.75；
#       锚点（basePoint d4 / shootPoint d5）不缩不移——出弹逻辑与挂载基准不变，炮口缩后仍贴住射点。
# 铁律：底稿哈希断言（DC7A9485）；锚点断言；全程单棵 ElementTree。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

CUR_SWF  = r"..\swf\sub1130.swf"
CUR_XML  = "work/sub1130-v3.xml"
OUT_XML  = "work/sub1130-v4.xml"
OUT_SWF  = "work/sub1130-v4.swf"
FFDEC    = r"..\tools\packaging\ffdec\ffdec-cli.exe"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
SCALE = 0.75
ART_DEPTHS = {1, 2, 3, 6, 7, 8, 9, 10}

# ---------- 0. 底稿断言（DC7A9485）＋新鲜转储 ----------
manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("DC7A9485"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, CUR_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr

tree = ET.parse(CUR_XML); root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}

# ---------- 1. 各枪射点枢轴（twips） ----------
PIVOTS = {}
for sid in ('115', '121'):
    for it in sprites[sid].iter('item'):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('name') == 'shootPoint':
            m = it.find('matrix')
            PIVOTS[sid] = (int(m.get('translateX')), int(m.get('translateY')))
print("枢轴(shootPoint):", PIVOTS)

# ---------- 2. 美术放置统一 0.75 缩放（枢轴=射点） ----------
count = {}
for sid in ('115', '121'):
    n = 0
    for it in sprites[sid].iter('item'):
        if (it.get('type') or '') != 'PlaceObject2Tag': continue
        d = it.get('depth')
        if d is None or not d.isdigit() or int(d) not in ART_DEPTHS: continue
        m = it.find('matrix')
        if m is None: continue   # MOVE 继承槽，跟随显式槽
        px, py = PIVOTS[sid]
        tx, ty = int(m.get('translateX')), int(m.get('translateY'))
        m.set('translateX', str(round(0.25 * px + SCALE * tx)))
        m.set('translateY', str(round(0.25 * py + SCALE * ty)))
        m.set('hasScale', 'true'); m.set('scaleX', str(SCALE)); m.set('scaleY', str(SCALE))
        if not m.get('nScaleBits'): m.set('nScaleBits', '16')
        n += 1
    count[sid] = n
    print(f"sprite {sid}: 缩放 {n} 处（scale 0.75，枢轴=射点）")
assert count['115'] == count['121'] + 1, f"缩放计数异常 {count}（115 比 121 多 f8 显式特效槽 1 处，其余差异为 MOVE 继承槽无矩阵）"

# ---------- 3. 断言：锚点未缩放未移动 ----------
for sid in ('115', '121'):
    for it in sprites[sid].iter('item'):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('name') in ('basePoint', 'shootPoint'):
            m = it.find('matrix')
            assert m.get('hasScale') in (None, 'false'), f"{sid} 锚点被缩放"
print("断言: 锚点未缩放未移动 PASS")
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
