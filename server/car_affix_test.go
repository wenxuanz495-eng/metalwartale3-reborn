package main

import (
	"math"
	"math/rand"
	"testing"
)

func TestFixZeroCarAffixesRerollsOnlyZeroCars(t *testing.T) {
	rng := rand.New(rand.NewSource(1))
	payload := map[string]any{
		"localSaveVersion": 2,
		"localSlots": map[string]any{
			"2": map[string]any{
				"data": map[string]any{
					"carItems": map[string]any{
						"arr": []any{
							map[string]any{
								"cnName":     "坏车",
								"color":      "green",
								"affixLevel": 7,
								"extraObj": map[string]any{
									"allAdd":     0,
									"attackAdd":  0,
									"lifeAdd":    0,
									"life_value": 0,
								},
							},
							map[string]any{
								"cnName":     "好车",
								"color":      "blue",
								"affixLevel": 5,
								"extraObj": map[string]any{
									"allAdd":    0.12,
									"attackAdd": 0.08,
								},
							},
							map[string]any{
								"cnName":     "白板",
								"color":      "white",
								"affixLevel": 1,
								"extraObj":   map[string]any{},
							},
						},
					},
				},
			},
		},
	}
	out, fixed, details := fixZeroCarAffixesInPayload(payload, rng)
	if fixed != 1 {
		t.Fatalf("fixed=%d want 1 details=%v", fixed, details)
	}
	root := out.(map[string]any)
	slots := root["localSlots"].(map[string]any)
	role := slots["2"].(map[string]any)["data"].(map[string]any)
	arr := role["carItems"].(map[string]any)["arr"].([]any)
	bad := arr[0].(map[string]any)["extraObj"].(map[string]any)
	good := arr[1].(map[string]any)["extraObj"].(map[string]any)
	if allExtraValuesZero(bad) {
		t.Fatalf("bad car still zero: %#v", bad)
	}
	// reroll uses integer percent points
	for k, v := range bad {
		n := saveNumber(v)
		if k == "life_value" {
			if math.Abs(n-math.Round(n)) > 1e-9 {
				t.Fatalf("life_value not int: %v", n)
			}
			continue
		}
		// percent ratio should be n/100
		if math.Abs(n*100-math.Round(n*100)) > 1e-9 {
			t.Fatalf("percent not integer points: %s=%v", k, n)
		}
	}
	if good["allAdd"] != 0.12 {
		t.Fatalf("good car changed: %#v", good)
	}
}

func TestRoundLongDecimalCarAffixes(t *testing.T) {
	rng := rand.New(rand.NewSource(2))
	payload := map[string]any{
		"localSaveVersion": 2,
		"localSlots": map[string]any{
			"2": map[string]any{
				"data": map[string]any{
					"carItems": map[string]any{
						"arr": []any{
							map[string]any{
								"cnName":     "长小数车",
								"color":      "green",
								"affixLevel": 7,
								"extraObj": map[string]any{
									"allAdd":     0.0758,
									"attackAdd":  0.0377,
									"life_value": 4655.2,
								},
							},
						},
					},
				},
			},
		},
	}
	out, fixed, details := fixZeroCarAffixesInPayload(payload, rng)
	if fixed != 1 {
		t.Fatalf("fixed=%d want 1 details=%v", fixed, details)
	}
	root := out.(map[string]any)
	slots := root["localSlots"].(map[string]any)
	role := slots["2"].(map[string]any)["data"].(map[string]any)
	arr := role["carItems"].(map[string]any)["arr"].([]any)
	eo := arr[0].(map[string]any)["extraObj"].(map[string]any)
	// 0.0758 -> 0.08, 0.0377 -> 0.04, 4655.2 -> 4655
	if math.Abs(saveNumber(eo["allAdd"])-0.08) > 1e-9 {
		t.Fatalf("allAdd=%v want 0.08", eo["allAdd"])
	}
	if math.Abs(saveNumber(eo["attackAdd"])-0.04) > 1e-9 {
		t.Fatalf("attackAdd=%v want 0.04", eo["attackAdd"])
	}
	if math.Abs(saveNumber(eo["life_value"])-4655) > 1e-9 {
		t.Fatalf("life_value=%v want 4655", eo["life_value"])
	}
}

func TestValidateCarLevelLimits(t *testing.T) {
	payload := map[string]any{"localSlots": []any{map[string]any{"data": map[string]any{"carItems": map[string]any{
		"arr": []any{map[string]any{"cnName": "奥", "levelOverride": 210, "affixLevel": 210}},
	}}}}}
	if err := validateCarLevelLimits(payload); err != nil {
		t.Fatalf("valid level rejected: %v", err)
	}
	car := payload["localSlots"].([]any)[0].(map[string]any)["data"].(map[string]any)["carItems"].(map[string]any)["arr"].([]any)[0].(map[string]any)
	car["levelOverride"] = 211
	if err := validateCarLevelLimits(payload); err == nil {
		t.Fatal("levelOverride 211 should be rejected")
	}
	car["levelOverride"] = 210
	car["affixLevel"] = 210.5
	if err := validateCarLevelLimits(payload); err == nil {
		t.Fatal("fractional affixLevel should be rejected")
	}
}
