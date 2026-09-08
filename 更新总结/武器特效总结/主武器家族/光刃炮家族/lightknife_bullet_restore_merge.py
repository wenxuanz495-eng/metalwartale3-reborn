# -*- coding: utf-8 -*-
"""
金色琉璃（lightKnife）子弹 2.5 回迁合并脚本
来源: 2.5 arms_34.swf  char62 (DefineShape, lightKnife_lv1_bullet 内层)
      2.5 arms_34.swf  char61 (DefineBitsLossless2, 148x33 位图填充)
目标: GitHub arms1100.swf  char838 (DefineShape, 仅被 sprite839 引用一次)
策略: 原位替换 char838 内容(保留 Character ID 838 与 tag 顺序),
      位图 char61 以新 ID 导入并重写 Shape 的 bitmapId 引用。
遵循纪律: 全程只修改同一个 ElementTree 对象, 直接写出 merged.xml。
"""
import xml.etree.ElementTree as ET
import hashlib, sys

GH_XML = 'work/arms1100-gh.xml'
S25_XML = 'work/arms34-25.xml'
OUT_XML = 'work/arms1100-merged.xml'

ET.register_namespace('', 'http://www.jpexs.com/xml')

gh = ET.parse(GH_XML)
tree_gh = gh.getroot()
tree_25 = ET.parse(S25_XML).getroot()

def char_elements(root):
    """yield (element, defining-id) for all character-defining tags"""
    attrs = ('shapeId', 'spriteId', 'characterID', 'soundId',
             'buttonId', 'fontId', 'textId', 'editTextId')
    for el in root.iter('item'):
        t = el.get('type') or ''
        if t.startswith('Define'):
            for a in attrs:
                v = el.get(a)
                if v is not None:
                    yield el, int(v)
                    break

# 1) 目标 SWF 现有最大 Character ID
used = [i for _, i in char_elements(tree_gh)]
max_id = max(used)
new_bitmap_id = max_id + 1
print(f'[1] GitHub arms1100 max character id = {max_id}, new bitmap id = {new_bitmap_id}')

# 2) 目标 char838 元素定位与唯一性校验
shape838 = [el for el, i in char_elements(tree_gh) if i == 838]
assert len(shape838) == 1, f'char838 count={len(shape838)}'
shape838 = shape838[0]
assert shape838.get('type') == 'DefineShapeTag', shape838.get('type')

# 3) 来源 char62 / char61 提取
src62 = [el for el, i in char_elements(tree_25) if i == 62]
src61 = [el for el, i in char_elements(tree_25) if i == 61]
assert len(src62) == 1 and len(src61) == 1
src62, src61 = src62[0], src61[0]
assert src62.get('type') == 'DefineShapeTag'
assert src61.get('type') == 'DefineBitsLossless2Tag'

# 4) 构造新元素(深拷贝): bitmap 新 ID, shape 换 ID=838 且重写 bitmapId
import copy
new_bitmap = copy.deepcopy(src61)
new_bitmap.set('characterID', str(new_bitmap_id))
new_shape = copy.deepcopy(src62)
new_shape.set('shapeId', '838')
fills = new_shape.findall('.//fillStyles/item')
bitmap_ids = set()
for f in fills:
    bid = f.get('bitmapId')
    if bid is not None:
        bitmap_ids.add(bid)
print(f'[2] 2.5 char62 fill bitmapIds = {sorted(bitmap_ids)} (61=真填充, 65535=占位)')
for f in fills:
    if f.get('bitmapId') == '61':
        f.set('bitmapId', str(new_bitmap_id))

# 5) 原位替换: bitmap 插到 shape 之前, shape 顶替 char838
parent = None
idx = None
for p in tree_gh.iter('item'):
    pass
# 找父容器: 遍历所有含子 item 的节点
def find_parent_and_index(root, target):
    for p in root.iter():
        kids = list(p)
        for i, k in enumerate(kids):
            if k is target:
                return p, i
    return None, None

parent, idx = find_parent_and_index(tree_gh, shape838)
assert parent is not None, 'parent not found'
parent.remove(shape838)
parent.insert(idx, new_shape)
parent.insert(idx, new_bitmap)   # bitmap 在 shape 之前
print(f'[3] char838 replaced in place, bitmap {new_bitmap_id} inserted before it')

# 6) 写盘(同一个对象, 不得重读原始 XML)
gh.write(OUT_XML, encoding='utf-8', xml_declaration=True)
print(f'[4] wrote {OUT_XML}')
