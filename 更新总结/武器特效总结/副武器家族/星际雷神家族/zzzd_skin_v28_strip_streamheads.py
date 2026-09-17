# -*- coding: utf-8 -*-
# 星际雷神 V28 修订（2026-09-18）：删除 sprite121/115 帧首的 SoundStreamHead2×2
# （V9 重建时间轴时复制残留，原版各 1 个；精灵内流声音头使 Flash 走流同步路径，
#   无音块时的"播放头能走、画面不刷"是嫌疑根因之一——V29 探明真正根因为替换型放置
#   不渲染后，本清理作为无害净化保留）。StartSound（开火音 108）保留。
# 运行方式：在 tmp-zzzd-skin-20260917\ 下执行，输入 work\sub1130-v27.xml，输出 work\sub1130-v28.swf。
import xml.etree.ElementTree as ET
import hashlib, subprocess, sys
BS = chr(92)
sys.stdout.reconfigure(encoding='utf-8')
IN_XML  = "work"+BS+"sub1130-v27.xml"
OUT_XML = "work"+BS+"sub1130-v28.xml"
OUT_SWF = "work"+BS+"sub1130-v28.swf"
RB_XML  = "work"+BS+"sub1130-v28-readback.xml"
FFDEC   = r".."+BS+"tools"+BS+"packaging"+BS+"ffdec"+BS+"ffdec-cli.exe"

tree = ET.parse(IN_XML)
root = tree.getroot()
for sid in ('121', '115'):
    sp = [it for it in root.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]
    heads = [it for it in sp.find('subTags') if (it.get('type') or '') == 'SoundStreamHead2Tag']
    assert len(heads) == 2, f"sprite{sid} 流头数={len(heads)}"
    for h in heads:
        sp.find('subTags').remove(h)
    starts = [it for it in sp.find('subTags') if (it.get('type') or '') == 'StartSoundTag']
    assert len(starts) == 1, f"sprite{sid} StartSound 应保留 1 个"
    frames = len([it for it in sp.find('subTags') if (it.get('type') or '') == 'ShowFrameTag'])
    assert frames == 16, f"sprite{sid} 帧数={frames}"
    print(f"sprite{sid}: 移除流头×2，StartSound 保留，16帧完整")

ET.indent(tree)
tree.write(OUT_XML, encoding='utf-8', xml_declaration=True)
r = subprocess.run([FFDEC, "-xml2swf", OUT_XML, OUT_SWF], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
h = hashlib.sha256(open(OUT_SWF, 'rb').read()).hexdigest().upper()
r = subprocess.run([FFDEC, "-swf2xml", OUT_SWF, RB_XML], capture_output=True, text=True)
assert r.returncode == 0, r.stdout + r.stderr
rb = ET.parse(RB_XML).getroot()
for sid in ('121', '115'):
    sp = [it for it in rb.iter('item') if 'DefineSprite' in (it.get('type') or '') and it.get('spriteId') == sid][0]
    heads = len([it for it in sp.find('subTags') if (it.get('type') or '') == 'SoundStreamHead2Tag'])
    assert heads == 0, f"回读 sprite{sid} 仍有流头"
print("回读 PASS：两精灵流头清零")
print("FULL:", h)
