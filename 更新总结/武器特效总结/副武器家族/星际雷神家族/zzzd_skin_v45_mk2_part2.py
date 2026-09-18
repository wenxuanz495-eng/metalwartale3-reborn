# -*- coding: utf-8 -*-
# 星际雷神 V45 修订（2026-09-19，仅 lv2/MK2；部件2 筒口环错位修复——参考图正向推导，用户批准执行）：
# 目标坐标差：部件2 条带左上角 相对 部件1 左上角 = (+133,+14) 素材px
#   （依据 相关素材\星际雷神\雷神mk2\完整参考子弹发射后.png，正向合成逐像素吻合 99.9%，覆盖区仅 7 噪声像素）。
# SWF 换算：sprite115 放置缩放恒 0.75（15tw/素材px）；位图已核 2934=部件1.png、2930/2932=部件2.png 第0~23/24~46行
#   （47=24+23，条带第24行竖切）。当前两弧条带原点 (132.53,10.53)/(131.53,16.0) 互相错位 (1.0,5.47)px=错位根源。
# 修复（整数twips零舍入）：2931 (1534,268)→(1541,320)（+7,+52tw=右0.47px 下3.47px）；
#   2933 (1519,710)→(1541,680)（+22,-30tw=右1.47px 上2.0px）。修复后两片条带原点统一 (133,14)、tx 对齐 1541。
# 其余零改动。验证：全元素级 diff 断言 2 叶子+1 容器(sprite115)、xml2swf 回读 FOUND。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF  = ".."+BS+"swf"+BS+"sub1130.swf"
SRC_XML  = "work"+BS+"sub1130-v45-src.xml"
OUT_XML  = "work"+BS+"sub1130-v45.xml"
OUT_SWF  = "work"+BS+"sub1130-v45.swf"
RB_XML   = "work"+BS+"sub1130-v45-readback.xml"
FFDEC    = ".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST = ".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"

manifest_line = [l for l in open(MANIFEST, encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual = hashlib.sha256(open(CUR_SWF, 'rb').read()).hexdigest().upper()
assert actual == manifest_line.upper() and actual.startswith("E36DF35E"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])

r = subprocess.run([FFDEC, "-swf2xml", CUR_SWF, SRC_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
tree = ET.parse(SRC_XML)
root = tree.getroot()

sp115 = [it for it in root.iter('item')
         if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
expect = {}
seen = []
for it in sp115.find('subTags'):
    if (it.get('type') or '') != 'PlaceObject2Tag':
        continue
    d, cid = it.get('depth'), it.get('characterId')
    if cid in ('2931', '2933'):
        m = it.find('matrix')
        tx, ty = m.get('translateX'), m.get('translateY')
        want = {'2931': ('1534', '268'), '2933': ('1519', '710')}[cid]
        assert (tx, ty) == want, f"当前态异常 {cid}@d{d}: ({tx},{ty}) 应为 {want}"
        new = {'2931': ('1541', '320'), '2933': ('1541', '680')}[cid]
        m.set('translateX', new[0]); m.set('translateY', new[1])
        expect[cid] = (d, new[0], new[1])
        seen.append(cid)
assert sorted(seen) == ['2931', '2933'] and len(expect) == 2, "部件2 放置未找齐"
print("矩阵修改 PASS：2931 (1534,268)→(1541,320)；2933 (1519,710)→(1541,680)")

ftree = ET.parse(SRC_XML)
a = [ET.tostring(it, encoding='unicode') for it in ftree.iter('item')]
b = [ET.tostring(it, encoding='unicode') for it in tree.iter('item')]
assert len(a) == len(b), "元素数不一致"
diff = [i for i, (x, y) in enumerate(zip(a, b)) if x != y]
leaf = [i for i in diff if 'DefineSpriteTag' not in a[i]]
cont = [i for i in diff if 'DefineSpriteTag' in a[i]]
assert len(leaf) == 2 and len(cont) == 1, f"diff 叶子{len(leaf)} 容器{len(cont)}"
assert all('115' in a[i][:120] for i in cont), "容器差异不在 sprite115"
print("全元素级 diff 断言 PASS：叶子 2 处＋容器 sprite115 随之差异，其余零改动")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
new_hash = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
sp = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == '115'][0]
got = {}
for it in sp.find('subTags'):
    t = it.get('type') or ''
    if t == 'PlaceObject2Tag' and it.get('characterId') in ('2931', '2933'):
        m = it.find('matrix')
        got[it.get('characterId')] = (it.get('depth'), m.get('translateX'), m.get('translateY'))
assert got == expect, "回读不一致 " + str(got)
print("回读 FOUND：部件2 两片矩阵全部命中", got)
print("新 swf:", OUT_SWF, new_hash[:8])
print("FULL:", new_hash)
