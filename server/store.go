package main

import (
	"database/sql"
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"sync"
	"time"

	_ "modernc.org/sqlite"
)

type saveStore struct {
	root        string
	saves       string
	primaryPath string
	backupPath  string
	jsonPath    string
	dbPath      string
	mu          sync.Mutex
}

func newSaveStore(root string) *saveStore {
	saves := filepath.Join(root, "saves")
	return &saveStore{
		root:        root,
		saves:       saves,
		primaryPath: filepath.Join(saves, "game_save.bin"),
		backupPath:  filepath.Join(saves, "game_save.last-good.bin"),
		jsonPath:    filepath.Join(saves, "yagao.json"),
		dbPath:      filepath.Join(saves, "saves.db"),
	}
}

func nowISO() string {
	return time.Now().Format(time.RFC3339)
}

func (s *saveStore) init() error {
	if err := os.MkdirAll(s.saves, 0o755); err != nil {
		return err
	}
	db, err := sql.Open("sqlite", s.dbPath)
	if err != nil {
		return err
	}
	defer db.Close()
	_, err = db.Exec(`
		CREATE TABLE IF NOT EXISTS saves (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			source TEXT,
			captured_at TEXT,
			sol_size INTEGER,
			sol_b64 TEXT,
			json_text TEXT
		)`)
	return err
}

func (s *saveStore) savePrimary(raw []byte, source string) (map[string]any, error) {
	if len(raw) == 0 {
		return nil, errors.New("empty save payload")
	}
	if len(raw) > 16*1024*1024 {
		return nil, errors.New("save payload is too large")
	}
	payload, _, err := parseGamePayload(raw)
	if err != nil {
		return nil, err
	}
	payload, stripped := stripGeneratedBlankSave(payload)
	if stripped {
		raw, err = encodeGamePayload(payload)
		if err != nil {
			return nil, err
		}
	}
	capturedAt := nowISO()
	doc := map[string]any{
		"exported_at":  capturedAt,
		"source":       source,
		"payload_size": len(raw),
		"game_data":    jsonSafe(payload, 0),
		"note":         "Go primary save: deflate(AMF(gameData)); Flash SOL is a compatibility mirror only",
	}
	pretty, err := json.MarshalIndent(doc, "", "  ")
	if err != nil {
		return nil, err
	}
	compact, err := json.Marshal(doc)
	if err != nil {
		return nil, err
	}

	s.mu.Lock()
	defer s.mu.Unlock()
	if err := s.init(); err != nil {
		return nil, err
	}
	if err := s.recoverPrimaryLocked(); err != nil {
		return nil, err
	}
	if currentRaw, readErr := os.ReadFile(s.primaryPath); readErr == nil {
		currentPayload, _, parseErr := parseGamePayload(currentRaw)
		if parseErr != nil {
			return nil, fmt.Errorf("current primary save is invalid: %w", parseErr)
		}
		if !strings.HasPrefix(source, "editor-restore:") {
			currentRoles := countCharacterSlots(currentPayload)
			incomingRoles := countCharacterSlots(payload)
			if currentRoles > 0 && incomingRoles < currentRoles {
				return nil, fmt.Errorf("refusing destructive save: character slots would decrease from %d to %d", currentRoles, incomingRoles)
			}
		}
	} else if !errors.Is(readErr, os.ErrNotExist) {
		return nil, readErr
	}
	tmp := s.primaryPath + ".tmp"
	if err := writeFileDurable(tmp, raw); err != nil {
		return nil, err
	}
	if _, _, err := parseGamePayload(raw); err != nil {
		_ = os.Remove(tmp)
		return nil, fmt.Errorf("temporary save verification failed: %w", err)
	}
	if err := s.replacePrimaryLocked(tmp); err != nil {
		return nil, err
	}
	if err := os.WriteFile(s.jsonPath, pretty, 0o644); err != nil {
		return nil, err
	}
	if err := s.insertHistory(source, capturedAt, raw, compact); err != nil {
		return nil, err
	}
	return map[string]any{
		"ok": true, "source": source, "size": len(raw),
		"primary": s.primaryPath, "json": s.jsonPath, "db": s.dbPath,
	}, nil
}

func writeFileDurable(path string, data []byte) error {
	file, err := os.OpenFile(path, os.O_CREATE|os.O_TRUNC|os.O_WRONLY, 0o644)
	if err != nil {
		return err
	}
	if _, err = file.Write(data); err == nil {
		err = file.Sync()
	}
	closeErr := file.Close()
	if err != nil {
		return err
	}
	return closeErr
}

func (s *saveStore) replacePrimaryLocked(tmp string) error {
	if _, err := os.Stat(s.primaryPath); errors.Is(err, os.ErrNotExist) {
		return os.Rename(tmp, s.primaryPath)
	} else if err != nil {
		return err
	}
	if err := os.Remove(s.backupPath); err != nil && !errors.Is(err, os.ErrNotExist) {
		return fmt.Errorf("cannot rotate last-good save: %w", err)
	}
	if err := os.Rename(s.primaryPath, s.backupPath); err != nil {
		return fmt.Errorf("cannot preserve current save: %w", err)
	}
	if err := os.Rename(tmp, s.primaryPath); err != nil {
		restoreErr := os.Rename(s.backupPath, s.primaryPath)
		if restoreErr != nil {
			return fmt.Errorf("cannot install new save: %v; automatic rollback also failed: %v; last-good path: %s", err, restoreErr, s.backupPath)
		}
		return fmt.Errorf("cannot install new save; previous save restored: %w", err)
	}
	return nil
}

func (s *saveStore) recoverPrimaryLocked() error {
	if raw, err := os.ReadFile(s.primaryPath); err == nil {
		if _, _, parseErr := parseGamePayload(raw); parseErr == nil {
			return nil
		} else {
			for _, candidate := range []string{s.backupPath, s.primaryPath + ".tmp"} {
				candidateRaw, candidateErr := os.ReadFile(candidate)
				if candidateErr != nil {
					continue
				}
				if _, _, candidateParseErr := parseGamePayload(candidateRaw); candidateParseErr != nil {
					continue
				}
				corruptPath := s.primaryPath + ".corrupt-" + time.Now().Format("20060102-150405.000000000")
				if err := os.Rename(s.primaryPath, corruptPath); err != nil {
					return fmt.Errorf("preserve corrupt primary save: %w", err)
				}
				if err := os.Rename(candidate, s.primaryPath); err != nil {
					_ = os.Rename(corruptPath, s.primaryPath)
					return fmt.Errorf("restore valid save over corrupt primary: %w", err)
				}
				return nil
			}
			return fmt.Errorf("primary save is invalid and no valid recovery copy exists: %w", parseErr)
		}
	} else if !errors.Is(err, os.ErrNotExist) {
		return err
	}
	if raw, err := os.ReadFile(s.backupPath); err == nil {
		if _, _, parseErr := parseGamePayload(raw); parseErr != nil {
			return fmt.Errorf("last-good save is invalid: %w", parseErr)
		}
		if err := os.Rename(s.backupPath, s.primaryPath); err != nil {
			return fmt.Errorf("restore last-good save: %w", err)
		}
		return nil
	} else if !errors.Is(err, os.ErrNotExist) {
		return err
	}
	tmp := s.primaryPath + ".tmp"
	if raw, err := os.ReadFile(tmp); err == nil {
		if _, _, parseErr := parseGamePayload(raw); parseErr != nil {
			return fmt.Errorf("orphan temporary save is invalid: %w", parseErr)
		}
		if err := os.Rename(tmp, s.primaryPath); err != nil {
			return fmt.Errorf("recover temporary save: %w", err)
		}
	} else if !errors.Is(err, os.ErrNotExist) {
		return err
	}
	return nil
}

func countCharacterSlots(payload any) int {
	root, ok := payload.(map[string]any)
	if !ok || root == nil {
		return 0
	}
	if slots, exists := root["localSlots"]; exists {
		return countCharactersInSlots(slots)
	}
	if looksLikeCharacterRole(root) {
		return 1
	}
	return 0
}

func countCharactersInSlots(slots any) int {
	count := 0
	seen := map[string]bool{}
	countSlot := func(key string, slot any) {
		if seen[key] {
			return
		}
		seen[key] = true
		entry, ok := slot.(map[string]any)
		if !ok || entry == nil {
			return
		}
		role, ok := entry["data"].(map[string]any)
		if ok && looksLikeCharacterRole(role) && !isGeneratedBlankRole(role) {
			count++
		}
	}
	switch value := slots.(type) {
	case []any:
		for index, slot := range value {
			countSlot(strconv.Itoa(index), slot)
		}
	case map[string]any:
		if dense, ok := value["$dense"].([]any); ok {
			for index, slot := range dense {
				countSlot(strconv.Itoa(index), slot)
			}
		}
		for key, slot := range value {
			if key != "$dense" {
				countSlot(key, slot)
			}
		}
	}
	return count
}

func looksLikeCharacterRole(role map[string]any) bool {
	_, hasPlayer := role["playerName"]
	_, hasArms := role["armsItems"]
	_, hasSubs := role["subItems"]
	_, hasCars := role["carItems"]
	return hasPlayer || hasArms || hasSubs || hasCars
}

func stripGeneratedBlankSave(payload any) (any, bool) {
	root, ok := payload.(map[string]any)
	if !ok {
		return payload, false
	}
	if slots, exists := root["localSlots"]; exists {
		cleaned, stripped := stripGeneratedBlankSlots(slots)
		if stripped {
			root["localSlots"] = cleaned
			return root, true
		}
		return root, false
	}
	if isGeneratedBlankRole(root) {
		return map[string]any{
			"localSaveVersion": 2,
			"localSlots":       make([]any, 8),
		}, true
	}
	return root, false
}

func stripGeneratedBlankSlots(slots any) (any, bool) {
	switch value := slots.(type) {
	case []any:
		stripped := false
		out := make([]any, len(value))
		copy(out, value)
		for i, slot := range out {
			if saveSlotContainsGeneratedBlank(slot) {
				out[i] = nil
				stripped = true
			}
		}
		return out, stripped
	case map[string]any:
		stripped := false
		out := make(map[string]any, len(value))
		for key, slot := range value {
			if key == "$dense" {
				cleaned, changed := stripGeneratedBlankSlots(slot)
				out[key] = cleaned
				if changed {
					stripped = true
				}
				continue
			}
			if saveSlotContainsGeneratedBlank(slot) {
				stripped = true
				continue
			}
			out[key] = slot
		}
		return out, stripped
	default:
		return slots, false
	}
}

func saveSlotContainsGeneratedBlank(slot any) bool {
	entry, ok := slot.(map[string]any)
	if !ok || entry == nil {
		return false
	}
	data, exists := entry["data"]
	if !exists {
		return false
	}
	role, ok := data.(map[string]any)
	return ok && isGeneratedBlankRole(role)
}

func isGeneratedBlankRole(role map[string]any) bool {
	if saveNumber(role["level"]) > 1 {
		return false
	}
	// Only treat maps that look like character GameData. Name is ignored so
	// renamed void slots are still removed, but generic objects are left alone.
	_, hasPlayer := role["playerName"]
	_, hasArms := role["armsItems"]
	_, hasSubs := role["subItems"]
	_, hasCars := role["carItems"]
	if !hasPlayer && !hasArms && !hasSubs && !hasCars {
		return false
	}
	return !saveCollectionHasItems(role["armsItems"]) &&
		!saveCollectionHasItems(role["subItems"]) &&
		!saveCollectionHasItems(role["carItems"])
}

func saveCollectionHasItems(collection any) bool {
	if collection == nil {
		return false
	}
	container, ok := collection.(map[string]any)
	if !ok {
		return true
	}
	items, exists := container["arr"]
	if !exists || items == nil {
		return false
	}
	switch value := items.(type) {
	case []any:
		return len(value) > 0
	case map[string]any:
		for key, item := range value {
			if key == "$dense" {
				if dense, ok := item.([]any); ok && len(dense) > 0 {
					return true
				}
				continue
			}
			if item != nil {
				return true
			}
		}
		return false
	default:
		return true
	}
}

func saveNumber(value any) float64 {
	switch number := value.(type) {
	case int:
		return float64(number)
	case int32:
		return float64(number)
	case int64:
		return float64(number)
	case uint:
		return float64(number)
	case uint32:
		return float64(number)
	case uint64:
		return float64(number)
	case float32:
		return float64(number)
	case float64:
		return number
	default:
		return 0
	}
}

func (s *saveStore) insertHistory(source, capturedAt string, raw, jsonText []byte) error {
	db, err := sql.Open("sqlite", s.dbPath)
	if err != nil {
		return err
	}
	defer db.Close()
	tx, err := db.Begin()
	if err != nil {
		return err
	}
	if _, err = tx.Exec(
		"INSERT INTO saves(source, captured_at, sol_size, sol_b64, json_text) VALUES (?,?,?,?,?)",
		source, capturedAt, len(raw), base64.StdEncoding.EncodeToString(raw), string(jsonText),
	); err != nil {
		_ = tx.Rollback()
		return err
	}
	if _, err = tx.Exec("DELETE FROM saves WHERE id NOT IN (SELECT id FROM saves ORDER BY id DESC LIMIT 50)"); err != nil {
		_ = tx.Rollback()
		return err
	}
	return tx.Commit()
}

func (s *saveStore) getPrimary() ([]byte, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	if err := os.MkdirAll(s.saves, 0o755); err != nil {
		return nil, err
	}
	if err := s.recoverPrimaryLocked(); err != nil {
		return nil, err
	}
	return os.ReadFile(s.primaryPath)
}

func (s *saveStore) exportSOL(force bool) (map[string]any, error) {
	raw, err := s.getPrimary()
	if errors.Is(err, os.ErrNotExist) {
		return map[string]any{
			"ok": false, "error": "no server save found",
		}, nil
	}
	if err != nil {
		return nil, err
	}
	return map[string]any{
		"ok": true, "source": "server-primary", "size": len(raw),
		"primary": s.primaryPath,
		"json":    s.jsonPath, "db": s.dbPath,
		"note": "Flash SOL import is disabled; saves/game_save.bin is authoritative",
	}, nil
}

func (s *saveStore) list() (map[string]any, error) {
	if err := s.init(); err != nil {
		return nil, err
	}
	db, err := sql.Open("sqlite", s.dbPath)
	if err != nil {
		return nil, err
	}
	defer db.Close()
	rows, err := db.Query("SELECT id, source, captured_at, sol_size FROM saves ORDER BY id DESC LIMIT 20")
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	history := []map[string]any{}
	for rows.Next() {
		var id, size int64
		var source, capturedAt string
		if err := rows.Scan(&id, &source, &capturedAt, &size); err != nil {
			return nil, err
		}
		history = append(history, map[string]any{
			"id": id, "source": source, "captured_at": capturedAt, "sol_size": size,
		})
	}
	return map[string]any{"sol_files": []string{}, "history": history}, rows.Err()
}
