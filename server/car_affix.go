package main

import (
	"fmt"
	"math"
	"math/rand"
	"os"
	"path/filepath"
	"time"
)

// Property keys observed on car extraObj in offline saves.
var carAffixPercentKeys = []string{
	"allAdd", "attackAdd", "subAdd", "lifeAdd",
	"defence_mul", "defence_max", "life_max",
}

var carAffixValueKeys = []string{
	"life_value",
}

var carColorPropCount = map[string][2]int{
	"white":  {0, 0},
	"blue":   {2, 4},
	"yellow": {3, 5},
	"orange": {5, 7},
	"green":  {7, 7},
	"purple": {7, 7},
}

func isPercentKey(key string) bool {
	for _, k := range carAffixPercentKeys {
		if k == key {
			return true
		}
	}
	return false
}

func isNumericZero(v any) bool {
	switch n := v.(type) {
	case nil:
		return true
	case int:
		return n == 0
	case int32:
		return n == 0
	case int64:
		return n == 0
	case float32:
		return n == 0
	case float64:
		return n == 0
	default:
		return false
	}
}

func allExtraValuesZero(extra map[string]any) bool {
	if len(extra) == 0 {
		return true
	}
	for _, v := range extra {
		if !isNumericZero(v) {
			return false
		}
	}
	return true
}

func carColorName(car map[string]any) string {
	c, _ := car["color"].(string)
	if c == "" {
		return "white"
	}
	return c
}

func carAffixLevel(car map[string]any) int {
	if v, ok := car["affixLevel"]; ok {
		n := int(saveNumber(v))
		if n > 0 {
			return n
		}
	}
	if v, ok := car["upgradeNum"]; ok {
		n := int(saveNumber(v))
		if n >= 0 {
			lv := 1 + n*5
			if lv < 1 {
				lv = 1
			}
			return lv
		}
	}
	return 1
}

func expectedPropCount(color string) (int, int) {
	if r, ok := carColorPropCount[color]; ok {
		return r[0], r[1]
	}
	return 2, 4
}

// roundPercentRatio stores percent as n/100 so UI (value*100) shows integer percent.
// Example: 0.0758 -> 0.08 -> displays as 8%.
func roundPercentRatio(v float64) float64 {
	if v <= 0 {
		return 0
	}
	// Round to integer percentage points.
	pct := math.Round(v * 100)
	if pct < 1 && v > 0 {
		pct = 1
	}
	return pct / 100
}

func roundLifeValue(v float64) float64 {
	if v <= 0 {
		return 0
	}
	return math.Round(v)
}

func valueNeedsRounding(key string, v any) bool {
	n := saveNumber(v)
	if isPercentKey(key) {
		// Already integer percent points?
		rounded := roundPercentRatio(n)
		return math.Abs(n-rounded) > 1e-9
	}
	if key == "life_value" {
		return math.Abs(n-math.Round(n)) > 1e-9
	}
	// Unknown numeric key: round to 2 decimals if messy.
	rounded := math.Round(n*100) / 100
	return math.Abs(n-rounded) > 1e-9
}

func extraNeedsRounding(extra map[string]any) bool {
	if extra == nil || len(extra) == 0 {
		return false
	}
	for k, v := range extra {
		if valueNeedsRounding(k, v) {
			return true
		}
	}
	return false
}

func carNeedsZeroAffixFix(car map[string]any) bool {
	if car == nil {
		return false
	}
	color := carColorName(car)
	minCount, _ := expectedPropCount(color)
	extra, _ := car["extraObj"].(map[string]any)
	if extra == nil {
		return minCount > 0
	}
	if len(extra) == 0 {
		return minCount > 0
	}
	if allExtraValuesZero(extra) {
		return true
	}
	// Also clean previously repaired values that still contain long decimals.
	return extraNeedsRounding(extra)
}

func randomPercent(lv int, rng *rand.Rand) float64 {
	if lv < 1 {
		lv = 1
	}
	// Integer percent points, scaled by level roughly.
	minPct := 2 + lv/2
	maxPct := 8 + lv*2
	if maxPct > 55 {
		maxPct = 55
	}
	if maxPct < minPct {
		maxPct = minPct
	}
	pct := minPct
	if maxPct > minPct {
		pct = minPct + rng.Intn(maxPct-minPct+1)
	}
	return float64(pct) / 100
}

func randomLifeValue(lv int, rng *rand.Rand) float64 {
	if lv < 1 {
		lv = 1
	}
	minV := 80 * lv
	maxV := 900 * lv
	if maxV < minV {
		maxV = minV
	}
	v := minV
	if maxV > minV {
		v = minV + rng.Intn(maxV-minV+1)
	}
	return float64(v)
}

func pickPropCount(color string, rng *rand.Rand) int {
	minC, maxC := expectedPropCount(color)
	if maxC <= minC {
		return minC
	}
	return minC + rng.Intn(maxC-minC+1)
}

func roundExistingAffixes(car map[string]any) (map[string]any, bool) {
	extra, _ := car["extraObj"].(map[string]any)
	if extra == nil || len(extra) == 0 {
		return extra, false
	}
	changed := false
	out := make(map[string]any, len(extra))
	for k, v := range extra {
		n := saveNumber(v)
		var nv float64
		if isPercentKey(k) {
			nv = roundPercentRatio(n)
		} else if k == "life_value" {
			nv = roundLifeValue(n)
		} else {
			nv = math.Round(n*100) / 100
		}
		if math.Abs(n-nv) > 1e-9 {
			changed = true
		}
		// Keep integers as int-like floats is fine for AMF/JSON.
		out[k] = nv
	}
	if changed {
		car["extraObj"] = out
	}
	return out, changed
}

func rerollCarAffixes(car map[string]any, rng *rand.Rand) map[string]any {
	color := carColorName(car)
	lv := carAffixLevel(car)
	if lv < 1 {
		lv = 1
	}
	car["affixLevel"] = lv
	if color == "" {
		color = "blue"
		car["color"] = color
	}

	extra, _ := car["extraObj"].(map[string]any)
	keys := make([]string, 0)
	if extra != nil {
		for k := range extra {
			keys = append(keys, k)
		}
	}
	if len(keys) == 0 {
		count := pickPropCount(color, rng)
		pool := append([]string{}, carAffixPercentKeys...)
		pool = append(pool, carAffixValueKeys...)
		rng.Shuffle(len(pool), func(i, j int) { pool[i], pool[j] = pool[j], pool[i] })
		if count > len(pool) {
			count = len(pool)
		}
		keys = pool[:count]
	}

	out := map[string]any{}
	for _, k := range keys {
		if k == "life_value" {
			out[k] = randomLifeValue(lv, rng)
		} else {
			out[k] = randomPercent(lv, rng)
		}
	}
	car["extraObj"] = out
	return out
}

func iterCarMaps(group any, visit func(map[string]any)) {
	g, ok := group.(map[string]any)
	if !ok || g == nil {
		return
	}
	for _, key := range []string{"arr", "equArr"} {
		switch arr := g[key].(type) {
		case []any:
			for _, item := range arr {
				if m, ok := item.(map[string]any); ok && m != nil {
					visit(m)
				}
			}
		case map[string]any:
			for k, item := range arr {
				if k == "$dense" {
					if dense, ok := item.([]any); ok {
						for _, d := range dense {
							if m, ok := d.(map[string]any); ok && m != nil {
								visit(m)
							}
						}
					}
					continue
				}
				if m, ok := item.(map[string]any); ok && m != nil {
					visit(m)
				}
			}
		}
	}
}

func carDisplayName(car map[string]any) string {
	name, _ := car["cnName"].(string)
	if name == "" {
		name, _ = car["name"].(string)
	}
	if name == "" {
		name, _ = car["baseLabel"].(string)
	}
	if name == "" {
		name = "?"
	}
	return name
}

func fixZeroCarAffixesInPayload(payload any, rng *rand.Rand) (any, int, []string) {
	if rng == nil {
		rng = rand.New(rand.NewSource(time.Now().UnixNano()))
	}
	fixed := 0
	details := []string{}
	root, ok := payload.(map[string]any)
	if !ok {
		return payload, 0, details
	}

	fixRole := func(role map[string]any, label string) {
		if role == nil {
			return
		}
		cars, _ := role["carItems"]
		iterCarMaps(cars, func(car map[string]any) {
			if !carNeedsZeroAffixFix(car) {
				return
			}
			extra, _ := car["extraObj"].(map[string]any)
			beforeKeys := 0
			if extra != nil {
				beforeKeys = len(extra)
			}
			name := carDisplayName(car)

			// Non-zero but messy decimals: round only, keep property set.
			if extra != nil && len(extra) > 0 && !allExtraValuesZero(extra) && extraNeedsRounding(extra) {
				out, changed := roundExistingAffixes(car)
				if changed {
					fixed++
					details = append(details, fmt.Sprintf("%s car=%s color=%v affix=%v rounded keys=%d",
						label, name, car["color"], car["affixLevel"], len(out)))
				}
				return
			}

			// Zero / empty affix: re-roll clean integer-friendly values.
			out := rerollCarAffixes(car, rng)
			fixed++
			details = append(details, fmt.Sprintf("%s car=%s color=%v affix=%v reroll keys %d->%d",
				label, name, car["color"], car["affixLevel"], beforeKeys, len(out)))
		})
	}

	if slots, ok := root["localSlots"]; ok {
		switch s := slots.(type) {
		case []any:
			for i, slot := range s {
				entry, _ := slot.(map[string]any)
				if entry == nil {
					continue
				}
				role, _ := entry["data"].(map[string]any)
				fixRole(role, fmt.Sprintf("slot[%d]", i))
			}
		case map[string]any:
			for k, slot := range s {
				if k == "$dense" {
					if dense, ok := slot.([]any); ok {
						for i, d := range dense {
							entry, _ := d.(map[string]any)
							if entry == nil {
								continue
							}
							role, _ := entry["data"].(map[string]any)
							fixRole(role, fmt.Sprintf("slot[%d]", i))
						}
					}
					continue
				}
				entry, _ := slot.(map[string]any)
				if entry == nil {
					continue
				}
				role, _ := entry["data"].(map[string]any)
				fixRole(role, fmt.Sprintf("slot[%s]", k))
			}
		}
		return root, fixed, details
	}

	fixRole(root, "root")
	return root, fixed, details
}

func (s *saveStore) fixZeroCarAffixes(source string) (map[string]any, error) {
	raw, err := s.getPrimary()
	if err != nil {
		return nil, err
	}
	payload, _, err := parseGamePayload(raw)
	if err != nil {
		return nil, err
	}
	rng := rand.New(rand.NewSource(time.Now().UnixNano()))
	fixedPayload, count, details := fixZeroCarAffixesInPayload(payload, rng)
	if count == 0 {
		return map[string]any{
			"ok":      true,
			"fixed":   0,
			"message": "没有发现需要处理的战车（全0或长小数）。",
			"details": details,
		}, nil
	}
	encoded, err := encodeGamePayload(fixedPayload)
	if err != nil {
		return nil, err
	}
	result, err := s.savePrimary(encoded, source)
	if err != nil {
		return nil, err
	}
	result["fixed"] = count
	result["details"] = details
	result["message"] = fmt.Sprintf("已处理 %d 辆战车：全0属性重roll为整数百分比，长小数四舍五入清理。", count)
	return result, nil
}

func runFixZeroCarAffixOnce(root string) error {
	store := newSaveStore(root)
	if err := store.init(); err != nil {
		return err
	}
	flagPath := filepath.Join(store.saves, "zero_car_affix_fixed.flag")
	if _, err := os.Stat(flagPath); err == nil {
		return fmt.Errorf("一键修复只能使用一次。如需再次修复/四舍五入清理，请打开修改器使用“重roll属性为0的战车”。")
	}
	result, err := store.fixZeroCarAffixes("fix-zero-car-affix-once")
	if err != nil {
		return err
	}
	fmt.Println(result["message"])
	if details, ok := result["details"].([]string); ok {
		for _, d := range details {
			fmt.Println(" -", d)
		}
	}
	_ = os.WriteFile(flagPath, []byte(nowISO()+"\n"), 0o644)
	fmt.Println("已标记一键修复已使用：", flagPath)
	return nil
}