package main

import (
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
	if good["allAdd"] != 0.12 {
		t.Fatalf("good car changed: %#v", good)
	}
}