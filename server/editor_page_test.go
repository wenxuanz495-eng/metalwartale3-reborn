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
	}
	for _, marker := range required {
		if !strings.Contains(editorHTML, marker) {
			t.Fatalf("editor slot protocol marker missing: %s", marker)
		}
	}
}
