# -*- coding: utf-8 -*-
"""关卡表全量解析 -> 关卡体系总览数据"""
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
    scenes = sorted({d.get("scene", "") for d in ds})
    print(f"\n== {pre}: {len(ds)} 关  index {ids[0]} ~ {ids[-1]}")
    print(f"   scene 取值({len(scenes)}): {scenes[:12]}{'...' if len(scenes) > 12 else ''}")

print("\n== 城市 属性取值:", sorted({d.get("城市", "") for d in levels if d.get("城市")}))
print("== boss 属性关卡数:", sum(1 for d in levels if d.get("boss")))
print("== 无 id 的 level:", sum(1 for d in levels if "id" not in d))

# 总表 CSV
fields = ["id", "index", "name", "scene", "城市", "boss", "_units", "_boss_unit", "_champion", "_super"]
with open(OUT / "关卡总表-247关.csv", "w", newline="", encoding="utf-8-sig") as f:
    w = csv.DictWriter(f, fieldnames=fields, extrasaction="ignore")
    w.writeheader()
    for d in levels:
        w.writerow(d)
print("\nCSV 已写出:", OUT / "关卡总表-247关.csv")
