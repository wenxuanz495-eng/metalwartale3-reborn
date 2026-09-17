# -*- coding: utf-8 -*-
# V16（重写版）：①发射帧 f4→f2（删起飞帧；配合 attackDelay=0＝真子弹与贴图弹消失严格同帧）
#               ②层序纠正：弧 2931/2933→d1/d2 最底层，尾焰 2925/2927/2929→d3/d4（V13 装反纠正）
#               ③补火焰清除标签：f5 加 RO d3/d4——修复 V9 起火焰末帧永久残留（"枪口火焰没变化"的真正根因）
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS=chr(92)
sys.stdout.reconfigure(encoding='utf-8')
CUR_SWF=r".."+BS+"swf"+BS+"sub1130.swf"
CUR_XML="work"+BS+"sub1130-v15.xml"
OUT_XML="work"+BS+"sub1130-v16.xml"
OUT_SWF="work"+BS+"sub1130-v16.swf"
FFDEC=r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"
MANIFEST=r".."+BS+"config"+BS+"build"+BS+"current-resource-manifest.sha256"
manifest_line=[l for l in open(MANIFEST,encoding='utf-8') if 'sub1130' in l][0].split()[0]
actual=hashlib.sha256(open(CUR_SWF,'rb').read()).hexdigest().upper()
assert actual==manifest_line.upper() and actual.startswith("1FA98271"), actual[:8]
print("底稿哈希断言 PASS:", actual[:8])
r=subprocess.run([FFDEC,"-swf2xml",CUR_SWF,CUR_XML],capture_output=True,text=True); assert r.returncode==0
tree=ET.parse(CUR_XML); root=tree.getroot()
sprites={it.get('spriteId'):it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '')}

FLAMES={2925,2927,2929}
def is_flame(it): return int(it.get('characterId') or 0) in FLAMES
def depth_of(it): return it.get('depth')

for sid,fx1 in (('115','2915'),('121','2907')):
    sp=sprites[sid]; sub=sp.find('subTags')
    heads=[e for e in list(sub) if (e.get('type') or '').startswith('SoundStreamHead')]
    frames={}; fr=1; cur=[]
    for it in list(sub):
        if it in heads: continue
        cur.append(it)
        if (it.get('type') or '')=='ShowFrameTag': frames[fr]=list(cur); fr+=1; cur=[]
    assert len(frames)==16, len(frames)
    # 层序纠正（就地）：弧 d3/d4→d1/d2；焰 d1/d2→d3/d4
    for f in range(1,17):
        for it in frames.get(f,[]):
            cid=int(it.get('characterId') or 0)
            if cid==2931 and depth_of(it)=='3': it.set('depth','1')
            elif cid==2933 and depth_of(it)=='4': it.set('depth','2')
            elif cid in FLAMES and depth_of(it)=='1': it.set('depth','3')
            elif cid in FLAMES and depth_of(it)=='2': it.set('depth','4')
    # 帧重排映射（新←旧），并过滤：新 f2 去起飞弹；新 f3 去起飞清除 RO d5/d6
    def take(f, drop_fly=False, drop_ro56=False):
        out=[]
        for it in frames.get(f,[]):
            t=it.get('type') or ''; cid=it.get('characterId'); d=depth_of(it)
            if drop_fly and cid=='2905' and d in ('5','6'): continue
            if drop_ro56 and t=='RemoveObject2Tag' and d in ('5','6'): continue
            out.append(it)
        return out
    nf={}
    nf[1]=take(1)
    nf[2]=take(4, drop_fly=True)          # 发射帧（含音/RO 撤弹/焰/特效1）
    nf[3]=take(5, drop_ro56=True)         # 焰2+特效2（去起飞清除）
    nf[4]=take(6)                          # 焰3+特效3
    nf[5]=take(7)                          # 特效4 ＋ 新增焰清除（下面补）
    nf[6]=take(8)                          # lv2 特效5
    nf[7]=[]; nf[8]=[]                     # 暴露态
    nf[9]=take(11); nf[10]=take(12); nf[11]=take(13)   # 装填滑动
    nf[12]=take(14); nf[13]=take(15); nf[14]=take(16); nf[15]=[]; nf[16]=[]
    # 新增：f5 尾焰清除 RO d3/d4
    nf[5].append(ET.Element('item',{'type':'RemoveObject2Tag','depth':'3','forceWriteAsLong':'false'}))
    nf[5].append(ET.Element('item',{'type':'RemoveObject2Tag','depth':'4','forceWriteAsLong':'false'}))
    # 断言
    def has(tags,pred): return any(pred(it) for it in tags)
    f2=nf[2]
    ok1=has(f2,lambda it:(it.get('type') or '')=='StartSoundTag')
    ok2=has(f2,lambda it:(it.get('type') or '')=='RemoveObject2Tag' and depth_of(it) in ('5','6'))
    ok3=has(f2,lambda it:it.get('characterId')=='2925' and depth_of(it)=='3')
    ok4=has(f2,lambda it:it.get('characterId')=='2925' and depth_of(it)=='4')
    ok5=has(f2,lambda it:it.get('characterId')==fx1)
    ok6=not has(f2,lambda it:it.get('characterId')=='2905')
    print(f"  debug fx1={fx1!r} ok5={ok5} cids={[(it.get('characterId'),depth_of(it)) for it in f2]}")
    assert ok1 and ok2 and ok3 and ok4 and ok5 and ok6, f"{sid} f2: snd={ok1} ro={ok2} 焰上={ok3}/{ok4} 特效={ok5} 无起飞={ok6}"
    f1=nf[1]
    assert has(f1,lambda it:it.get('characterId')=='2931' and depth_of(it)=='1')
    assert has(f1,lambda it:it.get('characterId')=='2933' and depth_of(it)=='2')
    assert has(nf[5],lambda it:(it.get('type') or '')=='RemoveObject2Tag' and depth_of(it)=='3')
    assert has(nf[5],lambda it:(it.get('type') or '')=='RemoveObject2Tag' and depth_of(it)=='4')
    assert sum(1 for f in range(1,17) for it in nf[f] if it.get('characterId')=='2905' and depth_of(it) in ('5','6'))==8, "待机/滑动弹总量异常"
    print(f"sprite {sid}: f2 发射帧（音/撤弹/焰双筒/特效 同帧）＋弧 d1/d2 底层＋焰 d3/d4＋焰清除补齐 — 断言 PASS")
    # 重建
    for e in list(sub): sub.remove(e)
    for e in heads: sub.append(e)
    for f in range(1,17):
        for it in nf[f]: sub.append(it)
        sub.append(ET.Element('item',{'type':'ShowFrameTag','forceWriteAsLong':'false'}))
    sp.set('frameCount','16')
ET.indent(tree); tree.write(OUT_XML,encoding='utf-8',xml_declaration=True)
r=subprocess.run([FFDEC,"-xml2swf",OUT_XML,OUT_SWF],capture_output=True,text=True); assert r.returncode==0, r.stdout+r.stderr
print("写出:",OUT_SWF,hashlib.sha256(open(OUT_SWF,'rb').read()).hexdigest().upper()[:8])
