# -*- coding: utf-8 -*-
# 星际雷神 V47 修订（2026-09-19，仅 lv2/MK2；下弹整链上移 1px——用户 directive）：
# 需求：下面那颗待机子弹上移 1px（上面不动）；下弹弹道（真弹出膛线）跟随；枪口火焰保持同一水平线（已核，零改动）。
# 改动（全部 sprite115，lv1 零动）：
#   1) d6 下弹全链 ty 807→787（-20tw=上移1px）：f1 放置 + f118/f126/f134/f142/f150/f158/f166 装填滑动轨道共 8 条目；
#   2) d9 shootPoint 锚（name="shootPoint"，真弹出膛基准）ty 662→652（上移0.5px）；
#   3) 配置侧（另行走 binary-patches 通道）：lv2 bulletTranslation 12.05→11.55。
# 数学：真弹线=shootPoint.y±tran：33.1±12.05=21.05/45.15 → 32.6±11.55=21.05/44.15
#       上线 21.05 不动、下线 -1px；与纹理弹中心 21.15/43.85 的既存偏差 0.1/0.3px 原样保留。
# 火焰核验：上下焰内容中心相对各自筒口环 -0.37/-0.38px 完全对称=同一水平线成立，零改动。
# 验证：d6 计数断言(8)/d5 不动断言/d9 唯一性断言/全元素 diff/回读逐条目 FOUND。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = ".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v47-src.xml"
OUT_XML  = "work"+BS+"sub1130-v47.xml"
OUT_SWF  = "work"+BS+"sub1130-v47.swf"
RB_XML   = "work"+BS+"sub1130-v47-readback.xml"
FFDEC    = ".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = ".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("3C04BE68"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()
sp = [it for it in root.iter('item')
      if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
subs = sp.find('subTags')

# 1) d6 下弹全链 807→787；d5 上弹必须全链 333 不动
d6_idx, d5_ty, d6_ty = [], [], []
for i, it in enumerate(subs):
    t = it.get('type') or ''
    if 'PlaceObject' not in t or it.get('depth') != '6':
        continue
    m = it.find('matrix')
    if m.get('translateY') != '807':
        raise SystemExit('d6 出现异常 ty=%s' % m.get('translateY'))
    d6_ty.append(m.get('translateY'))
    d6_idx.append((i, m))
for i, it in enumerate(subs):
    t = it.get('type') or ''
    if 'PlaceObject' in t and it.get('depth') == '5':
        d5_ty.append(it.find('matrix').get('translateY'))
assert len(d6_idx) == 8, f"d6 条目数 {len(d6_idx)} 应为 8"
assert set(d5_ty) == {'333'}, f"d5 上弹被波及: {d5_ty}"
for _, m in d6_idx:
    m.set('translateY', '787')
print("矩阵修改 PASS：d6 下弹 8 条目（f1 放置+装填轨道 7）ty 807→787；d5 上弹 8 条目 ty=333 未动")

# 2) d9 shootPoint 锚 662→652（唯一性断言 + 名字断言）
d9 = [(i, it) for i, it in enumerate(subs)
      if 'PlaceObject' in (it.get('type') or '') and it.get('depth') == '9']
assert len(d9) == 1, f"d9 条目数 {len(d9)}"
it = d9[0][1]
assert it.get('name') == 'shootPoint', it.get('name')
m = it.find('matrix')
assert (m.get('translateX'), m.get('translateY')) == ('1683', '662'), (m.get('translateX'), m.get('translateY'))
m.set('translateY', '652')
print("矩阵修改 PASS：d9 shootPoint 锚 (1683,662)→(1683,652)（上移 0.5px）")

# 3) 全元素级 diff：恰 9 叶子（8 d6 + 1 d9）+1 容器
ftree = ET.parse(SRC_XML)
a = [ET.tostring(x, encoding='unicode') for x in ftree.iter('item')]
b = [ET.tostring(x, encoding='unicode') for x in tree.iter('item')]
assert len(a) == len(b)
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 9 and len(cont) == 1, f"diff 叶子{len(leaf)} 容器{len(cont)}"
assert all('115' in a[i][:120] for i in cont)
print("全元素级 diff 断言 PASS：叶子 9 处＋容器 sprite115，其余零改动")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()

# 回读
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
sp2 = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
got_d6, got_d5, got_d9 = [], [], []
for it in sp2.find('subTags'):
    t = it.get('type') or ''
    if 'PlaceObject' not in t:
        continue
    d = it.get('depth')
    mm = it.find('matrix')
    if d == '6':
        got_d6.append((mm.get('translateX'), mm.get('translateY')))
    elif d == '5':
        got_d5.append((mm.get('translateX'), mm.get('translateY')))
    elif d == '9':
        got_d9.append((it.get('name'), mm.get('translateX'), mm.get('translateY')))
assert len(got_d6) == 8 and set(got_d6) == {('926', '787'), ('840', '787'), ('920', '787'), ('940', '787'), ('960', '787'), ('980', '787'), ('1000', '787'), ('1037', '787')}, got_d6
assert len(got_d5) == 8 and set(ty for _, ty in got_d5) == {'333'}, got_d5
assert got_d9 == [('shootPoint', '1683', '652')], got_d9
print("回读 FOUND：d6 全链 787 / d5 全链 333 未动 / d9 shootPoint 652 全部命中")
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
