# -*- coding: utf-8 -*-
# V21：彻底删除序列特效层（d10 全部放置＋f12 残段清除 RO）——焰/弧/弹/本体层不动
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS=chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF=r".."+BS+"swf"+BS+"sub1130.swf"
CUR_XML="work"+BS+"sub1130-v20.xml"
OUT_XML="work"+BS+"sub1130-v21.xml"
OUT_SWF="work"+BS+"sub1130-v21.swf"
FFDEC=r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST=r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
manifest_line=[l for l in open(MANIFEST,encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual=hashlib.sha256(open(CUR_SWF,'rb').read()).hexdigest().upper()
assert actual==manifest_line.upper() and actual.startswith("FDB0B139"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r=subprocess.run([FFDEC,"-swf2xml",CUR_SWF,CUR_XML],capture_output=True,text=True); assert r.returncode==0
tree=ET.parse(CUR_XML); root=tree.getroot()
sprites={it.get('spriteId'):it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
for sid in ('115','121'):
    sp=sprites[sid]; sub=sp.find('subTags')
    removed=0
    for it in list(sub):
        t=it.get('type') or ''
        if it.get('depth')=='10' and t in ('PlaceObject2Tag','RemoveObject2Tag'):
            sub.remove(it); removed+=1
    print(f"sprite {sid}: d10 删除 {removed} 处")
    depths=sorted(set(int(it.get('depth')) for it in sp.iter('item') if (it.get('type') or '') in ('PlaceObject2Tag','RemoveObject2Tag') and it.get('depth')))
    assert 10 not in depths, f"{sid} d10 残留"
    anch=sorted(set((it.get('name'),it.get('depth')) for it in sp.iter('item')
        if (it.get('type') or '')=='PlaceObject2Tag' and it.get('name') in ('basePoint','shootPoint')))
    assert anch==[('basePoint','8'),('shootPoint','9')], anch
    print(f"sprite {sid}: 现存深度={depths}（特效层已彻底移除）｜锚点 PASS")
ET.indent(tree); tree.write(OUT_XML,encoding='utf-8',xml_declaration=True)
r=subprocess.run([FFDEC,"-xml2swf",OUT_XML,OUT_SWF],capture_output=True,text=True); assert r.returncode==0, r.stdout+r.stderr
print("写出:",OUT_SWF,hashlib.sha256(open(OUT_SWF,'rb').read()).hexdigest().upper()[:8])
