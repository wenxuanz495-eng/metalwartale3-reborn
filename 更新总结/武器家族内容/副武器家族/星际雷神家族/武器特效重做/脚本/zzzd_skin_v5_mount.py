# -*- coding: utf-8 -*-
# 星际雷神 V5 修订脚本（2026-09-17）：挂点回归枪体
# 用户实机反馈：V4 以炮口（shootPoint）为枢轴缩小 25% 后，枪尾从挂点上缩回，挂点 hardware 与枪体脱开。
# 修法（两步）：
#   ① 重定枢轴＝改以 basePoint（挂点）为 0.75 缩放枢轴——枪尾钉在挂点上往炮口方向缩。
#      对 V4 现状而言等价于全体美术放置平移 0.25*(basePoint-shootPoint)（纯平移，缩放系数不变）：
#      lv2: 0.25*(287-2041, 640-425)=(-439,+54)tw；lv1: 0.25*(280-2071, 710-425)=(-448,+71)tw。
#   ② shootPoint 挪到缩小后的新炮口位置＝basePoint+0.75*(旧shootPoint-basePoint)：
#      lv2 →(1603,479)tw=(80.15,23.95)px；lv1 →(1623,496)tw=(81.15,24.8)px。
#      （子弹出膛点跟随新炮口，同磁轨炮/恶魔牙射点调整先例；basePoint 本身不动＝挂点钉死。）
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

CUR_SWF  = r"..\swf\sub1130.swf"
CUR_XML  = "work/sub1130-v4.xml"
OUT_XML  = "work/sub1130-v5.xml"
OUT_SWF  = "work/sub1130-v5.swf"
FFDEC    = r"..\tools\packaging\ffdec\ffdec-cli.exe"
MANIFEST = r"..\config\build\current-resource-manifest.sha256"
ART_DEPTHS = {1, 2, 3, 6, 7, 8, 9, 10}
SHIFT  = {'115': (-439, 54), '121': (-448, 71)}      # 0.25*(base-shoot) 取整
NEW_SP = {'115': (1603, 479), '121': (1623, 496)}    # 新炮口=base+0.75*(shoot-base)
OLD_SP = {'115': (2041, 425), '121': (2071, 425)}

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("D0F0E703"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, CUR_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(CUR_XML); root = tree.getroot()
sprites = {it.get('spriteId'): it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}

for sid in ('115', '121'):
    sp = sprites[sid]
    dx, dy = SHIFT[sid]
    n = 0
    for it in sp.iter('item'):
        if (it.get('type') or '') != 'PlaceObject2Tag': continue
        d = it.get('depth')
        if d is None or not d.isdigit() or int(d) not in ART_DEPTHS: continue
        m = it.find('matrix')
        if m is None: continue
        m.set('translateX', str(int(m.get('translateX')) + dx))
        m.set('translateY', str(int(m.get('translateY')) + dy))
        n += 1
    # shootPoint 移到新炮口
    for it in sp.iter('item'):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('name') == 'shootPoint':
            m = it.find('matrix')
            assert (int(m.get('translateX')), int(m.get('translateY'))) == OLD_SP[sid], f"{sid} 射点现状异常"
            m.set('translateX', str(NEW_SP[sid][0])); m.set('translateY', str(NEW_SP[sid][1]))
    print(f"sprite {sid}: 美术平移 {n} 处（{dx},{dy}），shootPoint → {NEW_SP[sid]}")

# 断言：basePoint 原位；shootPoint 新位；缩放保留
for sid in ('115', '121'):
    for it in sprites[sid].iter('item'):
        if (it.get('type') or '') == 'PlaceObject2Tag' and it.get('name') in ('basePoint', 'shootPoint'):
            m = it.find('matrix')
            nm = it.get('name')
            if nm == 'basePoint':
                assert (int(m.get('translateX')), int(m.get('translateY'))) in ((287, 640), (280, 710)), f"{sid} basePoint 被动"
            else:
                assert (int(m.get('translateX')), int(m.get('translateY'))) == tuple(NEW_SP[sid]), f"{sid} shootPoint 未到位"
print("断言: basePoint 原位 / shootPoint=新炮口 PASS")
ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
print("写出:", OUT_SWF, hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()[:8])
