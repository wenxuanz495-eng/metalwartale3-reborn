package main

import (
	"database/sql"
	"encoding/base64"
	"encoding/json"
	"errors"
	"os"
	"path/filepath"
	"sync"
	"time"

	_ "modernc.org/sqlite"
)

type saveStore struct {
	root        string
	saves       string
	primaryPath string
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
	tmp := s.primaryPath + ".tmp"
	if err := os.WriteFile(tmp, raw, 0o644); err != nil {
		return nil, err
	}
	_ = os.Remove(s.primaryPath)
	if err := os.Rename(tmp, s.primaryPath); err != nil {
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
