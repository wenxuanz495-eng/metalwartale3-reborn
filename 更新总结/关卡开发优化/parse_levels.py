# -*- coding: utf-8 -*-
"""关卡表全量解析 v2 -> 关卡体系总览数据
v2 修正：<name>/<specialClass>/<father> 是 <level> 的【子元素】而非属性
（v1 只读属性导致副本关名字/类接线全部漏采，见 副本关代码全解-20260929 勘误）"""
import csv, re
from collections import OrderedDict
from pathlib import Path

REPO = Path(r"D:\superalloy\metalwartale3-reborn.git")
OUT = Path(__file__).parent
LX = (REPO / "decompiled/embedded-xml-assets/17_EmbedXml_xmlClass11_EmbedXml_xmlClass11.bin").read_text(encoding="utf-8-sig")

levels = []
opens = list(re.finditer(r'<level\b([^>]*)>', LX))
for i, m in enumerate(opens):
    attrs = m.group(1)
    body_end = opens[i + 1].start() if i + 1 < len(opens) else LX.find("</data>", m.end())
    chunk = LX[m.end():body_end]
    chunk = chunk[:chunk.find("</level>")] if "</level>" in chunk else chunk
    d = dict(re.findall(r'(\w+)="([^"]*)"', attrs))
    units = re.findall(r'<unit([^>]*)>([^<]*)</unit>', chunk)
    types = []
    for a, _n in units:
        t = re.search(r'type="([^"]*)"', a)
        types.append(t.group(1) if t else "")
    # 子元素才是正身
    cname = re.search(r'<name>([^<]*)</name>', chunk)
    csc = re.search(r'<specialClass>([^<]*)</specialClass>', chunk)
    cfa = re.search(r'<father>([^<]*)</father>', chunk)
    d["_child_name"] = cname.group(1).strip() if cname else ""
    d["_specialClass"] = csc.group(1).strip().split(".")[-1] if csc else ""
    d["_father"] = cfa.group(1).strip() if cfa else ""
    d["_units"] = len(units)
    d["_boss_unit"] = sum(1 for t in types if t == "boss")
    d["_champion"] = sum(1 for t in types if t == "champion")
    d["_super"] = sum(1 for t in types if t == "super")
    levels.append(d)

print("level 总数:", len(levels))
groups = OrderedDict()
for d in levels:
    pre = d.get("id", "?").rsplit("-", 1)[0]
    groups.setdefault(pre, []).append(d)
for pre, ds in groups.items():
    ids = [d.get("id", "?") for d in ds]
    cls = sorted({d["_specialClass"] for d in ds if d["_specialClass"]})
    print(f"{pre}: {len(ds)} 关 ({ids[0]} ~ {ids[-1]}) 脚本类: {cls if cls else '-'}")

fields = ["id", "index", "name", "_child_name", "_specialClass", "_father", "scene", "城市", "boss",
          "_units", "_boss_unit", "_champion", "_super"]
with open(OUT / "关卡总表-v2-246关.csv", "w", newline="", encoding="utf-8-sig") as f:
    w = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
    w.writeheader()
    for d in levels:
        w.writerow(d)
n_cls = sum(1 for d in levels if d["_specialClass"])
print(f"CSV 已写出: 关卡总表-v2-246关.csv（带脚本类 {n_cls} 关）")

