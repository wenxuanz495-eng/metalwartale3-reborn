# -*- coding: utf-8 -*-
# V18：lv2 特效链换用 星际雷神特效1~4（用户裁定：新特效1~5 球/闪电分离观感不佳）
import xml.etree.ElementTree as ET
import copy, hashlib, subprocess, sys, zlib
from PIL import Image
BS=chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF=r".."+BS+"swf"+BS+"sub1130.swf"
CUR_XML="work"+BS+"sub1130-v17.xml"
OUT_XML="work"+BS+"sub1130-v18.xml"
OUT_SWF="work"+BS+"sub1130-v18.swf"
FFDEC=r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST=r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
IN='input/'
manifest_line=[l for l in open(MANIFEST,encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual=hashlib.sha256(open(CUR_SWF,'rb').read()).hexdigest().upper()
assert actual==manifest_line.upper() and actual.startswith("CF9BAC86"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r=subprocess.run([FFDEC,"-swf2xml",CUR_SWF,CUR_XML],capture_output=True,text=True); assert r.returncode==0
tree=ET.parse(CUR_XML); root=tree.getroot()
sprites={it.get('spriteId'):it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
used=set()
for it in root.iter('item'):
    for k in ('characterID','shapeId','spriteId','soundId','fontId'):
        v=it.get(k)
        if v and v.isdigit() and int(v)!=65535: used.add(int(v))
nid=max(used)+1
assert max(used)==2935, f"最大 ID {max(used)}"
print("新 ID 从",nid,"起")
donor=None
for it in root.iter('item'):
    if it.get('shapeId')=='30' and it.get('type')=='DefineShapeTag': donor=it; break
assert donor is not None
def make_bitmap(cid,path):
    img=Image.open(path).convert('RGBA'); w,h=img.size
    raw=bytearray()
    for r_,g_,b_,a_ in img.getdata(): raw+=bytes((a_,r_*a_//255,g_*a_//255,b_*a_//255))
    return ET.Element('item',{'type':'DefineBitsLossless2Tag','forceWriteAsLong':'true','characterID':str(cid),
        'bitmapFormat':'5','bitmapWidth':str(w),'bitmapHeight':str(h),'zlibBitmapData':zlib.compress(bytes(raw),9).hex()}),w,h
def make_shape(sid,bid,w,h):
    el=copy.deepcopy(donor); el.set('shapeId',str(sid))
    W,H=w*20,h*20; b=el.find('shapeBounds')
    for k,v in (('Xmin',0),('Ymin',0),('Xmax',W),('Ymax',H),('nbits',13)): b.set(k,str(v))
    fills=[f for f in el.iter('item') if f.get('type')=='FILLSTYLE']; assert len(fills)==2
    fills[1].set('bitmapId',str(bid)); bm=fills[1].find('bitmapMatrix')
    bm.set('translateX','0'); bm.set('translateY','0'); bm.set('nTranslateBits','1')
    recs=el.find('.//shapeRecords'); items=list(recs)
    items[0].set('moveBits','13'); items[0].set('moveDeltaX',str(W)); items[0].set('moveDeltaY',str(H))
    e1,e2,e3,e4=items[1:5]
    for e,attr,val,vert in ((e1,'deltaX',-W,'false'),(e2,'deltaY',-H,'true'),(e3,'deltaX',W,'false'),(e4,'deltaY',H,'true')):
        e.set(attr,str(val)); e.set('numBits','13'); e.set('vertLineFlag',vert)
    return el
new_elems=[]; new_shapes=[]
for i in (1,2,3,4):
    bid=nid; nid+=1; shp=nid; nid+=1
    b_el,w,h=make_bitmap(bid,IN+f"星际雷神特效{i}.png")
    s_el=make_shape(shp,bid,w,h)
    new_elems+=[b_el,s_el]; new_shapes.append((shp,w,h))
    print(f"星际雷神特效{i}: 位图={bid} 形状={shp} ({w}x{h})")
sp=sprites['115']; sub=sp.find('subTags')
fm={}; fr=1; cur=[]
for it in list(sub):
    cur.append(it)
    if (it.get('type') or '')=='ShowFrameTag': fm[fr]=list(cur); fr+=1; cur=[]
remap={'2915':new_shapes[0][0],'2917':new_shapes[1][0],'2919':new_shapes[2][0],'2921':new_shapes[3][0]}
n=0
for fno in (2,3,4,5):
    for it in fm[fno]:
        cid=it.get('characterId')
        if cid in remap and it.get('depth')=='10':
            it.set('characterId',str(remap[cid])); n+=1
assert n==4, f"特效改指 {n} != 4"
del6=[it for it in fm[6] if it.get('characterId')=='2923']
for it in del6: sub.remove(it)
print(f"lv2: f2~f5 特效改指 4 处；f6 旧特效5 放置删除 {len(del6)} 处")
assert not any(it.get('characterId') in ('2915','2917','2919','2921','2923') and it.get('depth')=='10' for it in sp.iter('item')), "旧特效引用残留"
sp100=sprites['100']; ap=sp100.find('subTags')
ins=0
for e in new_elems: ap.insert(ins,e); ins+=1
print("新定义插入完成（sprite100 之前）")
ET.indent(tree); tree.write(OUT_XML,encoding='utf-8',xml_declaration=True)
r=subprocess.run([FFDEC,"-xml2swf",OUT_XML,OUT_SWF],capture_output=True,text=True); assert r.returncode==0, r.stdout+r.stderr
print("写出:",OUT_SWF,hashlib.sha256(open(OUT_SWF,'rb').read()).hexdigest().upper()[:8])
