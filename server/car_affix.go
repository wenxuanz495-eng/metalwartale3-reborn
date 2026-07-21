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
	// purple uses same count as green in CarDataCreator colorNumArr index 5
	"purple": {7, 7},
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
	// fallback: try upgrade-based estimate from common fields
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

func carNeedsZeroAffixFix(car map[string]any) bool {
	if car == nil {
		return false
	}
	color := carColorName(car)
	minCount, _ := expectedPropCount(color)
	extra, _ := car["extraObj"].(map[string]any)
	if extra == nil {
		// Non-white cars should have random affixes; empty is broken.
		return minCount > 0
	}
	if len(extra) == 0 {
		return minCount > 0
	}
	// Has keys but every value is 0 => the FFDec getRandomValue bug.
	return allExtraValuesZero(extra)
}

func randomPercent(lv int, rng *rand.Rand) float64 {
	if lv < 1 {
		lv = 1
	}
	minV := 0.01 + float64(lv)*0.003
	maxV := 0.06 + float64(lv)*0.012
	if maxV > 0.55 {
		maxV = 0.55
	}
	if maxV < minV {
		maxV = minV
	}
	v := minV + rng.Float64()*(maxV-minV)
	// 4 decimals, similar to game percent display
	return math.Round(v*10000) / 10000
}

func randomLifeValue(lv int, rng *rand.Rand) float64 {
	if lv < 1 {
		lv = 1
	}
	minV := float64(80 * lv)
	maxV := float64(900 * lv)
	v := minV + rng.Float64()*(maxV-minV)
	return math.Round(v)
}

func pickPropCount(color string, rng *rand.Rand) int {
	minC, maxC := expectedPropCount(color)
	if maxC <= minC {
		return minC
	}
	return minC + rng.Intn(maxC-minC+1)
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

	// Prefer reusing existing keys if present (keeps original rolled property types).
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
			// AMF dense-like map
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
			beforeKeys := 0
			if eo, ok := car["extraObj"].(map[string]any); ok {
				beforeKeys = len(eo)
			}
			out := rerollCarAffixes(car, rng)
			fixed++
			name, _ := car["cnName"].(string)
			if name == "" {
				name, _ = car["name"].(string)
			}
			if name == "" {
				name, _ = car["baseLabel"].(string)
			}
			details = append(details, fmt.Sprintf("%s car=%s color=%v affix=%v keys %d->%d",
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

	// top-level role payload
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
			"message": "没有发现属性全为0的战车，无需修复。",
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
	result["message"] = fmt.Sprintf("已重roll %d 辆属性为0的战车。", count)
	return result, nil
}

func runFixZeroCarAffixOnce(root string) error {
	store := newSaveStore(root)
	if err := store.init(); err != nil {
		return err
	}
	flagPath := filepath.Join(store.saves, "zero_car_affix_fixed.flag")
	if _, err := os.Stat(flagPath); err == nil {
		return fmt.Errorf("一键修复只能使用一次。如需再次修复，请打开修改器使用“重roll属性为0的战车”。")
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
	// mark one-time used even when fixed=0, to keep "only once" semantics for the bat tool
	_ = os.WriteFile(flagPath, []byte(nowISO()+"\n"), 0o644)
	fmt.Println("已标记一键修复已使用：", flagPath)
	return nil
}