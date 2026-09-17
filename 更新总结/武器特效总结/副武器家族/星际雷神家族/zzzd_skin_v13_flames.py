# -*- coding: utf-8 -*-
# V13：枪口火焰在部件2之上、三类子弹之下——深度重排：
#   旧→新：d9/d10 尾焰→d1/d2｜d1/d2 弧→d3/d4｜d3/d4 待机弹 与 d11/d12 飞出弹→d5/d6｜d5 本体→d7｜d6/d7 锚点→d8/d9｜d8 特效→d10
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS=chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF=r".."+BS+"swf"+BS+"sub1130.swf"
CUR_XML="work"+BS+"sub1130-v12.xml"
OUT_XML="work"+BS+"sub1130-v13.xml"
OUT_SWF="work"+BS+"sub1130-v13.swf"
FFDEC=r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST=r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
manifest_line=[l for l in open(MANIFEST,encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual=hashlib.sha256(open(CUR_SWF,'rb').read()).hexdigest().upper()
assert actual==manifest_line.upper() and actual.startswith("F8A0E566"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r=subprocess.run([FFDEC,"-swf2xml",CUR_SWF,CUR_XML],capture_output=True,text=True); assert r.returncode==0
tree=ET.parse(CUR_XML); root=tree.getroot()
sprites={it.get('spriteId'):it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
REMAP={9:1,10:2,1:3,2:4,3:5,4:6,11:5,12:6,5:7,6:8,7:9,8:10}
for sid in ('115','121'):
    sp=sprites[sid]; n=0
    for it in sp.iter('item'):
        t=it.get('type') or ''
        if t in ('PlaceObject2Tag','RemoveObject2Tag'):
            d=it.get('depth')
            if d is not None and d.isdigit() and int(d) in REMAP:
                it.set('depth',str(REMAP[int(d)])); n+=1
    print(f"sprite {sid}: 深度重排 {n} 处")
# 断言：f4 幀（发射帧）各深度语义
for sid,body,fx1 in (('115','2935','2915'),('121','2901','2907')):
    sp=sprites[sid]
    f4={}; fr=1
    for it in sp.find('subTags'):
        t=it.get('type') or ''
        if t=='PlaceObject2Tag':
            f4.setdefault((it.get('depth'),it.get('characterId')),0)
            f4[(it.get('depth'),it.get('characterId'))]+=1
        elif t=='ShowFrameTag':
            if fr==4: break
            fr+=1
    assert (str(1),'2925') in f4 and (str(2),'2925') in f4, f"{sid} d1/d2 非尾焰"
    assert (str(3),'2931') in f4 and (str(4),'2933') in f4, f"{sid} d3/d4 非部件2"
    assert (str(5),'2905') in f4 and (str(6),'2905') in f4, f"{sid} d5/d6 非飞出导弹"
    assert (str(7),body) in f4, f"{sid} d7 非本体"
    assert (str(10),fx1) in f4, f"{sid} d10 非特效"
    anch=[(it.get('name'),it.get('depth')) for it in sp.iter('item') if (it.get('type') or '')=='PlaceObject2Tag' and it.get('name') in ('basePoint','shootPoint')]
    assert sorted(anch)==[('basePoint','8'),('shootPoint','9')], f"{sid} 锚点异常 {anch}"
    print(f"sprite {sid}: 断言 PASS（d1/d2 尾焰 > d3/d4 部件2 底层之上；d5/d6 飞出弹；d7 本体；d10 特效顶层；锚点 d8/d9）")
ET.indent(tree); tree.write(OUT_XML,encoding='utf-8',xml_declaration=True)
r=subprocess.run([FFDEC,"-xml2swf",OUT_XML,OUT_SWF],capture_output=True,text=True); assert r.returncode==0, r.stdout+r.stderr
print("写出:",OUT_SWF,hashlib.sha256(open(OUT_SWF,'rb').read()).hexdigest().upper()[:8])
