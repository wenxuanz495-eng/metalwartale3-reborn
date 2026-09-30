#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""查关小工具 —— 关卡身份卡查询（关卡开发优化 · 2026-09-29）

用法（参数任意形态，自动识别）:
  查询关卡.bat 1-4-2            内部 id
  查询关卡.bat 第十章 3          显示编号（月球危机）
  查询关卡.bat 10-3             同上（战役号-关号简写）
  查询关卡.bat 序章 | 第12关    自由之心显示编号
  查询关卡.bat 炮王 | 声东击西   名称模糊搜索
  查询关卡.bat 精英副本 | 玩家副本 | 特殊副本 | 公会战   列出整个分类
  查询关卡.bat WeekExtraLevel | SpecialExtraLevel_6     按脚本类查
  查询关卡.bat  （无参数）       打印口径速览

数据源：decompiled\\embedded-xml-assets\\17_EmbedXml_xmlClass11（关卡表，实时解析，无缓存）
口径依据：更新总结\\关卡开发优化\\关卡体系总览-20260928.md / 副本关代码全解-20260929.md
"""
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
LEVEL_BIN = REPO / "decompiled" / "embedded-xml-assets" / "17_EmbedXml_xmlClass11_EmbedXml_xmlClass11.bin"

# ---- 口径常量（与 LevelGroup.chosenLevel / NewLevelData 逐行核对）----
P1_NORMAL_NUM = 31        # 1-1-0..1-1-30（含序章，1-1-999 除外）
P1_KNOWING_NUM = 12       # 1-2-0..1-1-11
P1_FLAT_END = 100         # 扁平序号 70..99 为死槽位
MOON_DISPLAY_CHAPTER = 10  # 月球危机整包显示"第十章"

CATEGORY_GLOSSARY = """口径速览（游戏内标签 ↔ 代码命名，二者不一致！引代码名必须附游戏内标签）:
  自由之心(p1) = 内部 1-1(32,含序章/999模板) + 1-2 先知章(12) + 1-3 幽灵章(27)；显示=序章/第N关
  月球危机(p2) = 内部 1-4(101)；显示=第十章 N(=x+1)；玩家口语"10-N"
  精英副本     = 2-1(45)  代码 extra / SpecialExtraLevel_11（空壳，纯数据波次）
  玩家副本     = 3-1(12)  代码 weekExtra / WeekExtraLevel（误导名！游戏内无"每周副本"称呼）
  特殊副本     = 4-1(11)  代码 specialExtra / SpecialExtraLevel_1..10
  竞技场       = 5-1(1)   代码 arena / ArenaLevel
  公会战       = 6-1(5)   代码 union / SpecialExtraLevel_11（五区域）
  VIP专属地图  = 1-1-999  代码 VipExtraLevel（不是玩家副本）
  扁平序号: 1-1-x→x, 1-2-x→31+x, 1-3-x→43+x, 1-4-x→100+x；70~99=死槽位
"""


def category_of(lid):
    """返回 (游戏内分类标签, 代码state)"""
    if lid == "1-1-999":
        return "VIP专属地图", "normal(999)"
    a, b, c = (lid.split("-") + ["", ""])[:3]
    if a == "1":
        if b == "1":
            return "自由之心·主章", "normal"
        if b == "2":
            return "自由之心·先知章", "normal"
        if b == "3":
            return "自由之心·幽灵章", "normal"
        if b == "4":
            return "月球危机", "normal"
    if a == "2":
        return "精英副本", "extra"
    if a == "3":
        return "玩家副本（代码误名weekExtra）", "weekExtra"
    if a == "4":
        return "特殊副本", "specialExtra"
    if a == "5":
        return "竞技场", "arena"
    if a == "6":
        return "公会战", "union"
    return "未知", "?"


def family_class(lid):
    a, b = lid.split("-")[0], lid.split("-")[1] if "-" in lid else ""
    if a == "1":
        return "GhostLevel" if b == "3" else "Levels"
    if a == "2":
        return "ExtraLevel"
    if a == "3":
        return "WeekExtraLevel"
    if a == "4":
        return "Levels"
    if a == "5":
        return "ArenaLevel"
    return "（无兜底！须specialClass）"


def flat_index(lid):
    if lid == "1-1-999":
        return "≥999（模板/VIP入口）"
    a, b, c = lid.split("-")
    if a != "1":
        return "—"
    b, c = int(b), int(c)
    if b == 1:
        return str(c)
    if b == 2:
        return str(P1_NORMAL_NUM + c)
    if b == 3:
        return str(P1_NORMAL_NUM + P1_KNOWING_NUM + c)
    if b == 4:
        return str(P1_FLAT_END + c) + ("（⚠>199 溢出，chosenLevel 取模 %d）" % (c % 100) if c >= 100 else "")
    return "—"


def display_label(lid):
    if lid == "1-1-999":
        return "（无显示编号，specialClass 入口）"
    a, b, c = lid.split("-")
    if a == "1" and b == "4":
        return "第十章 %d" % (int(c) + 1)
    if a == "1" and b == "1":
        return "序章" if int(c) == 0 else "第%d关" % int(c)
    return "（副本页签内序号，见卡内分类）"


def load_levels():
    data = LEVEL_BIN.read_text(encoding="utf-8-sig")
    levels = []
    opens = list(re.finditer(r"<level\b([^>]*)>", data))
    for i, m in enumerate(opens):
        end = opens[i + 1].start() if i + 1 < len(opens) else data.find("</data>", m.end())
        chunk = data[m.end():end]
        cut = chunk.find("</level>")
        chunk = chunk[:cut] if cut >= 0 else chunk
        d = dict(re.findall(r'(\w+)="([^"]*)"', m.group(1)))
        lid = d.get("id", "")
        if not lid:
            continue
        cname = re.search(r"<name>([^<]*)</name>", chunk)
        csc = re.search(r"<specialClass>([^<]*)</specialClass>", chunk)
        cfa = re.search(r"<father>([^<]*)</father>", chunk)
        units = re.findall(r'<unit([^>]*)>([^<]*)</unit>', chunk)
        tb = tc = ts = 0
        for ua, _n in units:
            t = re.search(r'type="([^"]*)"', ua)
            t = t.group(1) if t else ""
            tb += t == "boss"
            tc += t == "champion"
            ts += t == "super"
        levels.append({
            "id": lid,
            "name": (cname.group(1).strip() if cname else "") or d.get("name", ""),
            "cls": csc.group(1).strip().split(".")[-1] if csc else "",
            "father": cfa.group(1).strip() if cfa else "",
            "scene": d.get("scene", ""),
            "boss": d.get("boss", ""),
            "units": len(units), "ub": tb, "uc": tc, "us": ts,
        })
    return levels


def card(lv):
    cat, state = category_of(lv["id"])
    eff = lv["cls"] or family_class(lv["id"])
    overridden = "（覆盖家族兜底 %s）" % family_class(lv["id"]) if lv["cls"] else "（家族兜底）"
    lines = [
        "【%s】%s" % (lv["id"], lv["name"] or "（无名）"),
        "  分类    : %s（代码 state=%s）" % (cat, state),
        "  显示编号 : %s" % display_label(lv["id"]),
        "  扁平序号 : %s" % flat_index(lv["id"]),
        "  脚本类   : %s %s" % (eff, overridden),
    ]
    scene = " / ".join(x for x in (lv["scene"], lv["father"]) if x) or "（空）"
    lines.append("  场景     : %s" % scene)
    marks = ["level@boss=%s" % lv["boss"] if lv["boss"] else "level@boss 无"]
    marks.append("unit: boss×%d champion×%d super×%d 普通×%d" % (
        lv["ub"], lv["uc"], lv["us"], lv["units"] - lv["ub"] - lv["uc"] - lv["us"]))
    lines.append("  Boss标记 : " + "｜".join(marks))
    return "\n".join(lines)


def parse_query(q):
    q = q.strip()
    if re.fullmatch(r"\d+-\d+-\d+", q):
        return ("id", q)
    m = re.fullmatch(r"第?10章\s*(\d+)\s*关?", q) or re.fullmatch(r"10[-.](\d+)", q)
    if m:
        n = int(m.group(1))
        if 1 <= n <= 101:
            return ("id", "1-4-%d" % (n - 1))
    if q == "序章":
        return ("id", "1-1-0")
    m = re.fullmatch(r"第(\d+)关", q)
    if m:
        return ("flat", int(m.group(1)))
    return ("fuzzy", q)


def flat_to_id(n):
    if n < P1_NORMAL_NUM:
        return "1-1-%d" % n
    if n < P1_NORMAL_NUM + P1_KNOWING_NUM:
        return "1-2-%d" % (n - P1_NORMAL_NUM)
    if n < P1_FLAT_END:
        return "1-3-%d" % (n - P1_NORMAL_NUM - P1_KNOWING_NUM)
    if 100 <= n <= 200:
        return "1-4-%d" % (n - P1_FLAT_END)
    return None


def main():
    argv = [a for a in sys.argv[1:] if a.strip()]
    try:
        levels = load_levels()
    except FileNotFoundError:
        print("找不到关卡表：%s" % LEVEL_BIN)
        return 2
    by_id = {lv["id"]: lv for lv in levels}

    if not argv:
        print(CATEGORY_GLOSSARY)
        counts = {}
        for lv in levels:
            cat, _ = category_of(lv["id"])
            counts[cat] = counts.get(cat, 0) + 1
        print("当前关卡表：%d 关" % len(levels))
        for cat, n in sorted(counts.items(), key=lambda x: -x[1]):
            print("  %-22s %d 关" % (cat, n))
        print("\n用法示例: 查询关卡 1-4-2 | 第十章 3 | 10-3 | 序章 | 炮王 | 精英副本 | WeekExtraLevel")
        return 0

    q = "".join(argv)
    kind, val = parse_query(q)
    hits = []
    if kind == "id":
        lv = by_id.get(val)
        if lv:
            hits = [lv]
        elif val.startswith("1-3-") and int(val.split("-")[2]) >= 27:
            print("未找到 %s（幽灵章只有 0~26）" % val)
        else:
            print("未找到 %s" % val)
    elif kind == "flat":
        lid = flat_to_id(val)
        if lid and lid in by_id:
            hits = [by_id[lid]]
        elif 70 <= val < 100:
            print("扁平序号 %d 是死槽位（70~99 无对应关卡）" % val)
        else:
            print("扁平序号 %d 无对应关卡" % val)
    else:
        ql = val.lower()
        cats = {cat for lv in levels for cat, _ in [category_of(lv["id"])]}
        cat_hit = [c for c in cats if ql in c.lower() or ql in c]
        for lv in levels:
            cat, _ = category_of(lv["id"])
            if any(c == cat for c in cat_hit):
                hits.append(lv)
        if not hits:
            hits = [lv for lv in levels
                    if ql in lv["name"].lower()
                    or ql in lv["id"].lower()
                    or (lv["cls"] and ql.lower() in lv["cls"].lower())
                    or ql.lower() in family_class(lv["id"]).lower()]
        if not hits:
            print("没有匹配 %r 的关卡（可试：id / 第十章 N / 10-N / 名称 / 分类名 / 脚本类名）" % val)
            return 1
        hits = hits[:30]

    print("匹配 %d 关：\n" % len(hits))
    for lv in hits:
        print(card(lv))
        print("-" * 56)
    return 0


if __name__ == "__main__":
    sys.exit(main())
