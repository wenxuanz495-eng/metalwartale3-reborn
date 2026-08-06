package main

import (
	"strings"
	"testing"
)

func TestEditorPageExposesSlotProtocol(t *testing.T) {
	required := []string{
		"const EDITOR_SLOT_INDEX=-1;",
		"function indexedValue(container,index)",
		"function selectedEditorData(root)",
		"function editorSavePayload(value)",
		"军衔与功勋",
		"function applyRankEditor(level,current)",
	}
	for _, marker := range required {
		if !strings.Contains(editorHTML, marker) {
			t.Fatalf("editor slot protocol marker missing: %s", marker)
		}
	}
}

func TestNormalizeEditorRootFlattensDenseSlots(t *testing.T) {
	root := map[string]any{
		"localSlots": map[string]any{
			"$dense": []any{},
			"0":      map[string]any{"data": map[string]any{"playerName": "A"}},
			"2":      map[string]any{"data": map[string]any{"playerName": "C"}},
		},
	}
	out := normalizeEditorRoot(root).(map[string]any)
	slots, ok := out["localSlots"].([]any)
	if !ok {
		t.Fatalf("localSlots not array: %T", out["localSlots"])
	}
	if len(slots) != 8 {
		t.Fatalf("want 8 slots, got %d", len(slots))
	}
	if slots[0].(map[string]any)["data"].(map[string]any)["playerName"] != "A" {
		t.Fatalf("slot0 missing")
	}
	if slots[1] != nil {
		t.Fatalf("slot1 should be nil")
	}
	if slots[2].(map[string]any)["data"].(map[string]any)["playerName"] != "C" {
		t.Fatalf("slot2 missing")
	}
}
