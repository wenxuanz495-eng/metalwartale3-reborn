package main

import (
	"bytes"
	"compress/flate"
	"compress/zlib"
	"encoding/binary"
	"encoding/json"
	"io"
	"math"
	"net/http"
	"net/http/httptest"
	"os"
	"path/filepath"
	"strings"
	"testing"
)

func deflatedAMFObject(t *testing.T) []byte {
	t.Helper()
	var amf bytes.Buffer
	amf.WriteByte(0x03)
	_ = binary.Write(&amf, binary.BigEndian, uint16(3))
	amf.WriteString("foo")
	amf.WriteByte(0x00)
	_ = binary.Write(&amf, binary.BigEndian, math.Float64bits(42))
	amf.Write([]byte{0, 0, 9})
	var compressed bytes.Buffer
	zw := zlib.NewWriter(&compressed)
	_, _ = zw.Write(amf.Bytes())
	_ = zw.Close()
	return compressed.Bytes()
}

func rawDeflatedAMF3Object(t *testing.T) []byte {
	t.Helper()
	amf3 := []byte{
		0x0A, 0x0B, 0x01, // dynamic anonymous object
		0x07, 'f', 'o', 'o',
		0x04, 0x2A,
		0x01, // empty dynamic key
	}
	var compressed bytes.Buffer
	fw, err := flate.NewWriter(&compressed, flate.DefaultCompression)
	if err != nil {
		t.Fatal(err)
	}
	_, _ = fw.Write(amf3)
	_ = fw.Close()
	return compressed.Bytes()
}

func TestParseGamePayload(t *testing.T) {
	value, _, err := parseGamePayload(deflatedAMFObject(t))
	if err != nil {
		t.Fatal(err)
	}
	obj := value.(map[string]any)
	if obj["foo"] != float64(42) {
		t.Fatalf("foo = %#v", obj["foo"])
	}
}

func TestParseRawDeflatedAMF3Payload(t *testing.T) {
	value, _, err := parseGamePayload(rawDeflatedAMF3Object(t))
	if err != nil {
		t.Fatal(err)
	}
	obj := value.(map[string]any)
	if obj["foo"] != 42 {
		t.Fatalf("foo = %#v", obj["foo"])
	}
}

func TestAMF3AssociativeArrayRegistersObjectBeforeChildren(t *testing.T) {
	// Array object #0 has one associative object (#1), followed by a dense
	// reference to object #1. Registering the array after its associative
	// values incorrectly makes that reference resolve to the array itself.
	r := newAMFReader([]byte{
		0x09, 0x03, // inline array, one dense value
		0x03, 'x', // associative key
		0x0A, 0x0B, 0x01, 0x01, // inline empty dynamic object
		0x01,       // end associative keys
		0x0A, 0x02, // dense value: object reference #1
	})
	value, err := r.readAMF3()
	if err != nil {
		t.Fatal(err)
	}
	assoc, ok := value.(map[string]any)
	if !ok {
		t.Fatalf("expected associative array map, got %T", value)
	}
	dense, ok := assoc["$dense"].([]any)
	if !ok || len(dense) != 1 {
		t.Fatalf("expected one dense value, got %#v", assoc["$dense"])
	}
	if _, ok := assoc["x"].(map[string]any); !ok {
		t.Fatalf("expected associative object, got %T", assoc["x"])
	}
	if _, ok := dense[0].(map[string]any); !ok {
		t.Fatalf("object reference resolved to %T instead of object #1", dense[0])
	}
}

func TestNormalizeCurrencyMirrors(t *testing.T) {
	data := map[string]any{"GCoin": 123, "GCoin2": 1, "MCoin": 456, "MCoin2": 2}
	root := map[string]any{"localSlots": []any{map[string]any{"data": data}}}
	normalizeCurrencyMirrors(root)
	if data["GCoin2"] != 123 || data["MCoin2"] != 456 {
		t.Fatalf("currency mirrors were not synchronized: %#v", data)
	}
}

func TestAMF3InvalidObjectReferenceReturnsError(t *testing.T) {
	r := newAMFReader([]byte{0x09, 0x00}) // array reference #0 with no objects registered
	if _, err := r.readAMF3(); err == nil {
		t.Fatal("expected invalid object reference error")
	}
}

func TestNormalizeAMFSparseArrayMap(t *testing.T) {
	value := map[string]any{
		"$dense": []any{"zero"},
		"2":      "two",
		"5":      map[string]any{"$dense": []any{1, 2}},
	}
	normalized, ok := normalizeAMFArrayMaps(value, 0).([]any)
	if !ok || len(normalized) != 6 {
		t.Fatalf("expected six-element sparse array, got %#v", normalized)
	}
	if normalized[0] != "zero" || normalized[2] != "two" {
		t.Fatalf("sparse values were not preserved: %#v", normalized)
	}
	if nested, ok := normalized[5].([]any); !ok || len(nested) != 2 {
		t.Fatalf("nested AMF array was not normalized: %#v", normalized[5])
	}
}

func TestPrepareLivenessForSlot(t *testing.T) {
	liveness := map[string]any{"value": 40, "taskNumArr": []any{1}, "giftGetB": []any{true}}
	root := map[string]any{"localSlots": []any{nil, nil, map[string]any{"data": map[string]any{"livenessData": liveness}}}}
	if err := prepareLivenessForSlot(root, 2); err != nil {
		t.Fatal(err)
	}
	if liveness["value"] != 100 {
		t.Fatalf("expected 100 liveness, got %#v", liveness["value"])
	}
	if tasks, ok := liveness["taskNumArr"].([]any); !ok || len(tasks) != 7 {
		t.Fatalf("expected seven completed tasks, got %#v", liveness["taskNumArr"])
	}
	if gifts, ok := liveness["giftGetB"].([]any); !ok || len(gifts) != 5 {
		t.Fatalf("expected five unclaimed gifts, got %#v", liveness["giftGetB"])
	} else {
		for _, gift := range gifts {
			if gift != false {
				t.Fatalf("expected all gifts unclaimed, got %#v", gifts)
			}
		}
	}
}

func TestAMF0StrictArrayRejectsImpossibleLengthBeforeAllocating(t *testing.T) {
	// AMF3 objects and AMF0 strict arrays both use marker 0x0a. Probing an
	// AMF3 payload as AMF0 must reject its trait bytes as an impossible array
	// length before calling make with a multi-gigabyte capacity.
	r := newAMFReader([]byte{0x0a, 0xa0, 0x00, 0x00, 0x00, 0x01})
	if _, err := r.readValue(); err == nil {
		t.Fatal("impossible AMF0 strict-array length must be rejected")
	}
}

func TestAMF3EncodeRoundTrip(t *testing.T) {
	input := map[string]any{
		"name":  "小战士",
		"level": 42,
		"large": float64(9999999999),
		"rate":  0.125,
		"ok":    true,
		"empty": nil,
		"items": []any{
			map[string]any{"name": "green_chip", "nowNum": 999},
			"tail",
		},
	}
	raw, err := encodeGamePayload(input)
	if err != nil {
		t.Fatal(err)
	}
	value, _, err := parseGamePayload(raw)
	if err != nil {
		t.Fatal(err)
	}
	got := value.(map[string]any)
	if got["name"] != "小战士" || got["level"] != 42 || got["large"] != float64(9999999999) {
		t.Fatalf("round trip mismatch: %#v", got)
	}
	items := got["items"].([]any)
	if items[0].(map[string]any)["nowNum"] != 999 {
		t.Fatalf("items mismatch: %#v", items)
	}
}

func TestRealSaveAMF3RoundTripWhenFixtureExists(t *testing.T) {
	path := filepath.Join("..", "offline", "saves", "game_save.bin")
	raw, err := os.ReadFile(path)
	if os.IsNotExist(err) {
		t.Skip("real save fixture is not present")
	}
	if err != nil {
		t.Fatal(err)
	}
	value, _, err := parseGamePayload(raw)
	if err != nil {
		t.Fatal(err)
	}
	encoded, err := encodeGamePayload(value)
	if err != nil {
		t.Fatal(err)
	}
	roundTrip, _, err := parseGamePayload(encoded)
	if err != nil {
		t.Fatal(err)
	}
	before, _ := json.Marshal(jsonSafe(value, 0))
	after, _ := json.Marshal(jsonSafe(roundTrip, 0))
	if !bytes.Equal(before, after) {
		t.Fatal("real save changed after AMF3 round trip")
	}
}

func TestSavePrimaryWritesBinaryJSONAndSQLite(t *testing.T) {
	root := t.TempDir()
	store := newSaveStore(root)
	raw := deflatedAMFObject(t)
	if _, err := store.savePrimary(raw, "test"); err != nil {
		t.Fatal(err)
	}
	got, err := os.ReadFile(store.primaryPath)
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(got, raw) {
		t.Fatal("primary payload changed")
	}
	jsonData, err := os.ReadFile(store.jsonPath)
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Contains(jsonData, []byte(`"foo": 42`)) {
		t.Fatalf("unexpected JSON: %s", jsonData)
	}
	if _, err := os.Stat(store.dbPath); err != nil {
		t.Fatal(err)
	}
}

func testCharacterSave(t *testing.T, name string) []byte {
	t.Helper()
	raw, err := encodeGamePayload(map[string]any{
		"localSaveVersion": 2,
		"localSlots": []any{
			nil,
			nil,
			map[string]any{
				"index": 2,
				"data": map[string]any{
					"playerName": name,
					"level":      50,
					"armsItems":  map[string]any{"arr": []any{map[string]any{"name": "soya_lv1"}}},
					"subItems":   map[string]any{"arr": []any{}},
					"carItems":   map[string]any{"arr": []any{}},
				},
			},
		},
	})
	if err != nil {
		t.Fatal(err)
	}
	return raw
}

func TestSavePrimaryRejectsCharacterSlotLoss(t *testing.T) {
	store := newSaveStore(t.TempDir())
	original := testCharacterSave(t, "survivor")
	if _, err := store.savePrimary(original, "fixture"); err != nil {
		t.Fatal(err)
	}
	empty, err := encodeGamePayload(map[string]any{
		"localSaveVersion": 2,
		"localSlots":       make([]any, 8),
	})
	if err != nil {
		t.Fatal(err)
	}
	if _, err := store.savePrimary(empty, "go-primary"); err == nil {
		t.Fatal("destructive empty save was accepted")
	}
	got, err := store.getPrimary()
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(got, original) {
		t.Fatal("primary changed after rejected destructive save")
	}
}

func TestGetPrimaryRecoversInterruptedReplacement(t *testing.T) {
	store := newSaveStore(t.TempDir())
	original := testCharacterSave(t, "recover-me")
	if _, err := store.savePrimary(original, "fixture"); err != nil {
		t.Fatal(err)
	}
	if err := os.Rename(store.primaryPath, store.backupPath); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(store.primaryPath+".tmp", testCharacterSave(t, "newer-but-uncommitted"), 0o644); err != nil {
		t.Fatal(err)
	}
	got, err := store.getPrimary()
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(got, original) {
		t.Fatal("last-good save was not restored")
	}
}

func TestGetPrimaryRecoversCorruptPrimaryFromLastGood(t *testing.T) {
	store := newSaveStore(t.TempDir())
	good := testCharacterSave(t, "last-good")
	if err := os.MkdirAll(store.saves, 0o755); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(store.primaryPath, []byte("truncated"), 0o644); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(store.backupPath, good, 0o644); err != nil {
		t.Fatal(err)
	}
	got, err := store.getPrimary()
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(got, good) {
		t.Fatal("corrupt primary was not recovered from last-good")
	}
	matches, err := filepath.Glob(store.primaryPath + ".corrupt-*")
	if err != nil || len(matches) != 1 {
		t.Fatalf("corrupt primary was not preserved: matches=%v err=%v", matches, err)
	}
}

func TestSavePrimaryKeepsPreviousLastGoodCopy(t *testing.T) {
	store := newSaveStore(t.TempDir())
	first := testCharacterSave(t, "first")
	second := testCharacterSave(t, "second")
	if _, err := store.savePrimary(first, "fixture"); err != nil {
		t.Fatal(err)
	}
	if _, err := store.savePrimary(second, "go-primary"); err != nil {
		t.Fatal(err)
	}
	backup, err := os.ReadFile(store.backupPath)
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(backup, first) {
		t.Fatal("last-good copy does not contain previous primary")
	}
}

func TestSavePrimaryStripsGeneratedBlankRoleRegardlessOfName(t *testing.T) {
	root := t.TempDir()
	store := newSaveStore(root)
	payload := map[string]any{
		"localSaveVersion": 2,
		"localSlots": map[string]any{
			"$dense": []any{},
			"2": map[string]any{
				"data": map[string]any{
					"playerName": "玩家自定义名字",
					"level":      1,
					"armsItems":  map[string]any{"arr": []any{}},
					"subItems":   map[string]any{"arr": []any{}},
					"carItems":   map[string]any{"arr": []any{}},
				},
			},
			"3": map[string]any{
				"data": map[string]any{
					"playerName": "秋实",
					"level":      50,
					"armsItems":  map[string]any{"arr": []any{map[string]any{"id": "gun"}}},
					"subItems":   map[string]any{"arr": []any{}},
					"carItems":   map[string]any{"arr": []any{map[string]any{"id": "car"}}},
				},
			},
		},
	}
	raw, err := encodeGamePayload(payload)
	if err != nil {
		t.Fatal(err)
	}
	if _, err := store.savePrimary(raw, "test"); err != nil {
		t.Fatalf("save with blank slot failed: %v", err)
	}
	saved, err := os.ReadFile(store.primaryPath)
	if err != nil {
		t.Fatal(err)
	}
	value, _, err := parseGamePayload(saved)
	if err != nil {
		t.Fatal(err)
	}
	game, ok := value.(map[string]any)
	if !ok {
		t.Fatalf("unexpected saved payload type: %T", value)
	}
	slots, ok := game["localSlots"].(map[string]any)
	if !ok {
		t.Fatalf("unexpected slots type: %T", game["localSlots"])
	}
	if _, exists := slots["2"]; exists {
		t.Fatal("blank role slot was not stripped")
	}
	if _, exists := slots["3"]; !exists {
		t.Fatal("valid role slot was stripped")
	}
}

func TestSavePrimaryAllowsDefaultNameWhenRoleHasRealProgress(t *testing.T) {
	root := t.TempDir()
	store := newSaveStore(root)
	payload := map[string]any{
		"localSaveVersion": 2,
		"localSlots": map[string]any{
			"$dense": []any{},
			"2": map[string]any{
				"data": map[string]any{
					"playerName": "4399小战士",
					"level":      88,
					"armsItems":  map[string]any{"arr": []any{}},
					"subItems":   map[string]any{"arr": []any{}},
					"carItems":   map[string]any{"arr": []any{}},
				},
			},
		},
	}
	raw, err := encodeGamePayload(payload)
	if err != nil {
		t.Fatal(err)
	}
	if _, err := store.savePrimary(raw, "test"); err != nil {
		t.Fatalf("valid default-name role was rejected: %v", err)
	}
}

func TestSavePrimaryAllowsNewRoleWithStarterEquipment(t *testing.T) {
	root := t.TempDir()
	store := newSaveStore(root)
	payload := map[string]any{
		"playerName": "4399小战士",
		"level":      0,
		"armsItems":  map[string]any{"arr": []any{map[string]any{"id": "starter"}}},
		"subItems":   map[string]any{"arr": []any{}},
		"carItems":   map[string]any{"arr": []any{map[string]any{"id": "starter-car"}}},
	}
	raw, err := encodeGamePayload(payload)
	if err != nil {
		t.Fatal(err)
	}
	if _, err := store.savePrimary(raw, "test"); err != nil {
		t.Fatalf("initialized new role was rejected: %v", err)
	}
}

func TestGetPrimaryDoesNotConsultGlobalFlashSOL(t *testing.T) {
	root := t.TempDir()
	appData := t.TempDir()
	t.Setenv("APPDATA", appData)
	legacyDir := filepath.Join(appData, "Macromedia", "Flash Player", "#SharedObjects", "legacy")
	if err := os.MkdirAll(legacyDir, 0o755); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(filepath.Join(legacyDir, "yagao.sol"), []byte("legacy-sol"), 0o644); err != nil {
		t.Fatal(err)
	}
	store := newSaveStore(root)
	_, err := store.getPrimary()
	if !os.IsNotExist(err) {
		t.Fatalf("empty server store should return os.ErrNotExist, got %v", err)
	}
	if _, err := os.Stat(store.primaryPath); !os.IsNotExist(err) {
		t.Fatalf("global Flash SOL created primary save: %v", err)
	}
}

func TestHTTPNoSaveReturns404WithoutImportingGlobalFlashSOL(t *testing.T) {
	root := t.TempDir()
	appData := t.TempDir()
	t.Setenv("APPDATA", appData)
	legacyDir := filepath.Join(appData, "Macromedia", "Flash Player", "#SharedObjects", "legacy")
	if err := os.MkdirAll(legacyDir, 0o755); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(filepath.Join(legacyDir, "yagao.sol"), []byte("legacy-sol"), 0o644); err != nil {
		t.Fatal(err)
	}
	store := newSaveStore(root)
	server := httptest.NewServer((&app{root: root, store: store}).routes())
	defer server.Close()

	response, err := http.Get(server.URL + "/api/game-save")
	if err != nil {
		t.Fatal(err)
	}
	defer response.Body.Close()
	if response.StatusCode != http.StatusNotFound {
		body, _ := io.ReadAll(response.Body)
		t.Fatalf("status=%d body=%s", response.StatusCode, body)
	}
	if _, err := os.Stat(store.primaryPath); !os.IsNotExist(err) {
		t.Fatalf("HTTP read imported global Flash SOL: %v", err)
	}
}

func TestEditorSaveCreatesBackupAndPreservesTypes(t *testing.T) {
	root := t.TempDir()
	if err := os.WriteFile(filepath.Join(root, "game.swf"), []byte("FWS-test"), 0o644); err != nil {
		t.Fatal(err)
	}
	store := newSaveStore(root)
	original := map[string]any{
		"level": 4,
		"MCoin": 0,
		"vv":    3.123,
		"name":  "old",
		"items": []any{map[string]any{"nowNum": 1}},
	}
	raw, err := encodeGamePayload(original)
	if err != nil {
		t.Fatal(err)
	}
	if _, err := store.savePrimary(raw, "fixture"); err != nil {
		t.Fatal(err)
	}
	server := httptest.NewServer((&app{root: root, store: store}).routes())
	defer server.Close()

	body := bytes.NewBufferString(`{"game_data":{"level":9,"MCoin":123456,"vv":0.5,"name":"new","items":[{"nowNum":999}]}}`)
	request, _ := http.NewRequest(http.MethodPost, server.URL+"/api/editor/save", body)
	request.Header.Set("Content-Type", "application/json")
	request.Header.Set("Origin", server.URL)
	response, err := http.DefaultClient.Do(request)
	if err != nil {
		t.Fatal(err)
	}
	defer response.Body.Close()
	if response.StatusCode != http.StatusOK {
		data, _ := io.ReadAll(response.Body)
		t.Fatalf("status=%d body=%s", response.StatusCode, data)
	}
	savedRaw, err := store.getPrimary()
	if err != nil {
		t.Fatal(err)
	}
	value, _, err := parseGamePayload(savedRaw)
	if err != nil {
		t.Fatal(err)
	}
	saved := value.(map[string]any)
	if saved["level"] != 9 || saved["MCoin"] != 123456 || saved["vv"] != float64(0.5) {
		t.Fatalf("saved values or types mismatch: %#v", saved)
	}
	backups, err := store.listEditorBackups()
	if err != nil {
		t.Fatal(err)
	}
	if len(backups) != 1 {
		t.Fatalf("backups=%#v", backups)
	}
	backupRaw, err := store.readEditorBackup(backups[0].Name)
	if err != nil {
		t.Fatal(err)
	}
	backupValue, _, _ := parseGamePayload(backupRaw)
	if backupValue.(map[string]any)["level"] != 4 {
		t.Fatalf("backup does not contain original save: %#v", backupValue)
	}
}

func TestEditorManualBackup(t *testing.T) {
	store := newSaveStore(t.TempDir())
	raw, err := encodeGamePayload(map[string]any{"level": 7})
	if err != nil {
		t.Fatal(err)
	}
	if _, err := store.savePrimary(raw, "test"); err != nil {
		t.Fatal(err)
	}
	application := &app{store: store}
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		application.editorBackupNow(w)
	}))
	defer server.Close()
	request, _ := http.NewRequest(http.MethodPost, server.URL+"/api/editor/backup", nil)
	response, err := http.DefaultClient.Do(request)
	if err != nil {
		t.Fatal(err)
	}
	defer response.Body.Close()
	if response.StatusCode != http.StatusOK {
		t.Fatalf("status=%d", response.StatusCode)
	}
	backups, err := store.listEditorBackups()
	if err != nil {
		t.Fatal(err)
	}
	if len(backups) != 1 || !strings.Contains(backups[0].Name, "manual") {
		t.Fatalf("backups=%#v", backups)
	}
}

func TestEditorRejectsCrossOriginMutation(t *testing.T) {
	root := t.TempDir()
	store := newSaveStore(root)
	raw, _ := encodeGamePayload(map[string]any{"level": 1})
	if _, err := store.savePrimary(raw, "fixture"); err != nil {
		t.Fatal(err)
	}
	server := httptest.NewServer((&app{root: root, store: store}).routes())
	defer server.Close()
	request, _ := http.NewRequest(http.MethodPost, server.URL+"/api/editor/save", bytes.NewBufferString(`{"game_data":{"level":2}}`))
	request.Header.Set("Content-Type", "application/json")
	request.Header.Set("Origin", "https://evil.example")
	response, err := http.DefaultClient.Do(request)
	if err != nil {
		t.Fatal(err)
	}
	defer response.Body.Close()
	if response.StatusCode != http.StatusForbidden {
		t.Fatalf("status=%d", response.StatusCode)
	}
}

func TestHTTPCompatibility(t *testing.T) {
	root := t.TempDir()
	if err := os.WriteFile(filepath.Join(root, "game.swf"), []byte("FWS-test"), 0o644); err != nil {
		t.Fatal(err)
	}
	store := newSaveStore(root)
	if _, err := store.savePrimary(deflatedAMFObject(t), "test"); err != nil {
		t.Fatal(err)
	}
	server := httptest.NewServer((&app{root: root, store: store}).routes())
	defer server.Close()

	response, err := http.Get(server.URL + "/api/status")
	if err != nil {
		t.Fatal(err)
	}
	defer response.Body.Close()
	var status map[string]any
	if err := json.NewDecoder(response.Body).Decode(&status); err != nil {
		t.Fatal(err)
	}
	if status["backend"] != "go" {
		t.Fatalf("status = %#v", status)
	}

	request, _ := http.NewRequest(http.MethodGet, server.URL+"/game.swf", nil)
	request.Header.Set("If-Modified-Since", "Wed, 21 Oct 2015 07:28:00 GMT")
	staticResponse, err := http.DefaultClient.Do(request)
	if err != nil {
		t.Fatal(err)
	}
	defer staticResponse.Body.Close()
	if staticResponse.StatusCode != http.StatusOK {
		t.Fatalf("static status = %d", staticResponse.StatusCode)
	}

	saveResponse, err := http.Get(server.URL + "/api/game-save")
	if err != nil {
		t.Fatal(err)
	}
	defer saveResponse.Body.Close()
	body, _ := io.ReadAll(saveResponse.Body)
	if !bytes.Equal(body, deflatedAMFObject(t)) {
		t.Fatal("GET /api/game-save returned different payload")
	}

	newRaw := deflatedAMFObject(t)
	postResponse, err := http.Post(server.URL+"/api/game-save", "application/octet-stream", bytes.NewReader(newRaw))
	if err != nil {
		t.Fatal(err)
	}
	defer postResponse.Body.Close()
	if postResponse.StatusCode != http.StatusOK {
		postBody, _ := io.ReadAll(postResponse.Body)
		t.Fatalf("POST /api/game-save status=%d body=%s", postResponse.StatusCode, postBody)
	}
	stored, err := os.ReadFile(store.primaryPath)
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(stored, newRaw) {
		t.Fatal("POST /api/game-save did not update primary payload")
	}
}
