# -*- coding: utf-8 -*-
# V11：三组子弹统一同一 Y 行线——待机弹(d3/d4)、飞出导弹(d11/d12)、真子弹(shootPoint±tran)。
# 行线基准=双弧中心；子弹按可见 alpha 质心(26.18,6.34)对行；飞出导弹 x=弹头贴炮口起步 f4→f5+25px→f6+55px。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
import numpy as np
from PIL import Image
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF=r"..\swf\sub1130.swf"
FFDEC=r"..\tools\packaging\ffdec\ffdec-cli.exe"
MANIFEST=r"..\config\build\current-resource-manifest.sha256"
CUR_XML="work\sub1130-v10.xml"
OUT_XML="work\sub1130-v11.xml"
OUT_SWF="work\sub1130-v11.swf"
manifest_line=[l for l in open(MANIFEST,encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual=hashlib.sha256(open(CUR_SWF,'rb').read()).hexdigest().upper()
assert actual==manifest_line.upper() and actual.startswith("646CD57A"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
arr=np.array(Image.open('input/子弹.png').convert('RGBA'))
al=arr[...,3].astype(float); ys,xs=np.mgrid[0:arr.shape[0],0:arr.shape[1]]
cy=float((ys*al).sum()/al.sum()); cx=float((xs*al).sum()/al.sum())
print(f"子弹可见质心=({cx:.2f},{cy:.2f})")
r=subprocess.run([FFDEC,"-swf2xml",CUR_SWF,CUR_XML],capture_output=True,text=True); assert r.returncode==0
tree=ET.parse(CUR_XML); root=tree.getroot()
sprites={it.get('spriteId'):it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}
def frames_map(sub):
    out={}; fr=1; cur=[]
    for it in list(sub):
        cur.append(it)
        if (it.get('type') or '')=='ShowFrameTag': out[fr]=cur; fr+=1; cur=[]
    if cur: out[fr]=cur
    return out
for sid in ('115','121'):
    sp=sprites[sid]; sub=sp.find('subTags')
    arc={}
    for it in sp.iter('item'):
        if (it.get('type') or '')=='PlaceObject2Tag' and it.get('characterId') in ('2931','2933'):
            m=it.find('matrix'); sc=float(m.get('scaleX') or 1)
            h=(24 if it.get('characterId')=='2931' else 23)*sc/2
            arc['U' if it.get('characterId')=='2931' else 'L']=(int(m.get('translateX'))/20, int(m.get('translateY'))/20+h)
    rowU,rowL=arc['U'][1],arc['L'][1]
    for it in sp.iter('item'):
        if (it.get('type') or '')=='PlaceObject2Tag' and it.get('name')=='shootPoint':
            muzzle_x=int(it.find('matrix').get('translateX'))/20
    fixed=0
    for it in sp.iter('item'):
        if (it.get('type') or '')=='PlaceObject2Tag' and it.get('characterId')=='2905' and it.get('depth') in ('3','4'):
            m=it.find('matrix'); row=rowU if it.get('depth')=='3' else rowL
            m.set('translateY',str(round((row-0.75*cy)*20))); fixed+=1
    fm=frames_map(sub); fixed2=0
    for no in (4,5,6):
        for it in fm[no]:
            if (it.get('type') or '')=='PlaceObject2Tag' and it.get('depth') in ('11','12') and it.get('characterId')=='2905':
                m=it.find('matrix'); row=rowU if it.get('depth')=='11' else rowL
                tx0=muzzle_x-0.75*(52-cx)+(0 if no==4 else (25 if no==5 else 55))
                m.set('translateX',str(round(tx0*20)))
                m.set('translateY',str(round((row-0.75*cy)*20))); fixed2+=1
    print(f"sprite {sid}: 行U={rowU:.2f} 行L={rowL:.2f} 炮口x={muzzle_x:.1f} | 待机弹对行 {fixed} 处、飞出弹 {fixed2} 处")
    assert fixed==8 and fixed2==6
ET.indent(tree); tree.write(OUT_XML,encoding='utf-8',xml_declaration=True)
r=subprocess.run([FFDEC,"-xml2swf",OUT_XML,OUT_SWF],capture_output=True,text=True); assert r.returncode==0, r.stdout+r.stderr
print("写出:",OUT_SWF,hashlib.sha256(open(OUT_SWF,'rb').read()).hexdigest().upper()[:8])
