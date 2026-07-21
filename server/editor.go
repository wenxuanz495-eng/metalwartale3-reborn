package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"math"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"time"
)

type editorSaveRequest struct {
	GameData json.RawMessage `json:"game_data"`
}

type editorRestoreRequest struct {
	Name string `json:"name"`
}

type editorBackup struct {
	Name      string `json:"name"`
	Size      int64  `json:"size"`
	CreatedAt string `json:"created_at"`
}

func (a *app) serveEditor(w http.ResponseWriter, r *http.Request, path string) bool {
	if path == "/editor" || path == "/editor/" {
		if r.Method != http.MethodGet {
			http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
			return true
		}
		a.sendBytes(w, []byte(editorHTML), "text/html; charset=utf-8", http.StatusOK)
		return true
	}
	if !strings.HasPrefix(path, "/api/editor/") {
		return false
	}
	if !sameOriginEditorRequest(r) {
		a.sendJSON(w, map[string]any{"ok": false, "error": "cross-origin editor request rejected"}, http.StatusForbidden)
		return true
	}
	switch {
	case path == "/api/editor/data" && r.Method == http.MethodGet:
		a.editorData(w)
	case path == "/api/editor/save" && r.Method == http.MethodPost:
		a.editorSave(w, r)
	case path == "/api/editor/backups" && r.Method == http.MethodGet:
		a.editorBackups(w)
	case path == "/api/editor/fix-zero-car-affix" && r.Method == http.MethodPost:
		result, err := a.store.fixZeroCarAffixes("editor-fix-zero-car-affix")
		a.sendResult(w, result, err)
		return true
	case path == "/api/editor/restore" && r.Method == http.MethodPost:
		a.editorRestore(w, r)
	default:
		http.NotFound(w, r)
	}
	return true
}

func sameOriginEditorRequest(r *http.Request) bool {
	origin := r.Header.Get("Origin")
	if origin == "" {
		return true
	}
	parsed, err := url.Parse(origin)
	if err != nil {
		return false
	}
	return parsed.Scheme == "http" && parsed.Host == r.Host
}

func (a *app) editorData(w http.ResponseWriter) {
	raw, err := a.store.getPrimary()
	if errors.Is(err, os.ErrNotExist) {
		a.sendJSON(w, map[string]any{"ok": false, "error": "没有存档，请先启动游戏创建角色"}, http.StatusNotFound)
		return
	}
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
		return
	}
	value, _, err := parseGamePayload(raw)
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
		return
	}
	a.sendJSON(w, map[string]any{
		"ok":        true,
		"game_data": jsonSafe(value, 0),
		"size":      len(raw),
		"updated_at": func() string {
			if info, statErr := os.Stat(a.store.primaryPath); statErr == nil {
				return info.ModTime().Format(time.RFC3339)
			}
			return ""
		}(),
	}, http.StatusOK)
}

func (a *app) editorSave(w http.ResponseWriter, r *http.Request) {
	var request editorSaveRequest
	if err := decodeEditorJSON(w, r, &request); err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
		return
	}
	if len(request.GameData) == 0 {
		a.sendJSON(w, map[string]any{"ok": false, "error": "game_data is required"}, http.StatusBadRequest)
		return
	}
	currentRaw, err := a.store.getPrimary()
	if err != nil {
		code := http.StatusInternalServerError
		if errors.Is(err, os.ErrNotExist) {
			code = http.StatusNotFound
		}
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, code)
		return
	}
	current, _, err := parseGamePayload(currentRaw)
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
		return
	}
	decoder := json.NewDecoder(bytes.NewReader(request.GameData))
	decoder.UseNumber()
	var edited any
	if err := decoder.Decode(&edited); err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": "无效 JSON: " + err.Error()}, http.StatusBadRequest)
		return
	}
	normalized, err := normalizeEditedValue(current, edited, 0)
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
		return
	}
	if _, ok := normalized.(map[string]any); !ok {
		a.sendJSON(w, map[string]any{"ok": false, "error": "存档根节点必须是对象"}, http.StatusBadRequest)
		return
	}
	if err := validateEditorValue(normalized, 0); err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
		return
	}
	encoded, err := encodeGamePayload(normalized)
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
		return
	}
	roundTrip, _, err := parseGamePayload(encoded)
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": "写入前自检失败: " + err.Error()}, http.StatusInternalServerError)
		return
	}
	backup, err := a.store.createEditorBackup(currentRaw, "before-edit")
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": "备份失败: " + err.Error()}, http.StatusInternalServerError)
		return
	}
	result, err := a.store.savePrimary(encoded, "editor")
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
		return
	}
	result["backup"] = backup
	result["game_data"] = jsonSafe(roundTrip, 0)
	a.sendJSON(w, result, http.StatusOK)
}

func (a *app) editorBackups(w http.ResponseWriter) {
	backups, err := a.store.listEditorBackups()
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
		return
	}
	a.sendJSON(w, map[string]any{"ok": true, "backups": backups}, http.StatusOK)
}

func (a *app) editorRestore(w http.ResponseWriter, r *http.Request) {
	var request editorRestoreRequest
	if err := decodeEditorJSON(w, r, &request); err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
		return
	}
	raw, err := a.store.readEditorBackup(request.Name)
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
		return
	}
	current, err := a.store.getPrimary()
	if err == nil {
		if _, backupErr := a.store.createEditorBackup(current, "before-restore"); backupErr != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": backupErr.Error()}, http.StatusInternalServerError)
			return
		}
	}
	result, err := a.store.savePrimary(raw, "editor-restore:"+request.Name)
	a.sendResult(w, result, err)
}

func decodeEditorJSON(w http.ResponseWriter, r *http.Request, target any) error {
	body := http.MaxBytesReader(w, r.Body, 16*1024*1024)
	decoder := json.NewDecoder(body)
	decoder.DisallowUnknownFields()
	return decoder.Decode(target)
}

func normalizeEditedValue(template, edited any, depth int) (any, error) {
	if depth > 64 {
		return nil, errors.New("JSON nesting is too deep")
	}
	switch value := edited.(type) {
	case json.Number:
		if _, ok := template.(float64); ok {
			number, err := value.Float64()
			return number, err
		}
		if integer, err := value.Int64(); err == nil {
			return integer, nil
		}
		number, err := value.Float64()
		return number, err
	case []any:
		result := make([]any, len(value))
		templateArray, _ := template.([]any)
		for i, item := range value {
			var itemTemplate any
			if i < len(templateArray) {
				itemTemplate = templateArray[i]
			}
			normalized, err := normalizeEditedValue(itemTemplate, item, depth+1)
			if err != nil {
				return nil, fmt.Errorf("[%d]: %w", i, err)
			}
			result[i] = normalized
		}
		return result, nil
	case map[string]any:
		result := make(map[string]any, len(value))
		templateMap, _ := template.(map[string]any)
		for key, item := range value {
			normalized, err := normalizeEditedValue(templateMap[key], item, depth+1)
			if err != nil {
				return nil, fmt.Errorf("%s: %w", key, err)
			}
			result[key] = normalized
		}
		return result, nil
	case nil, bool, string:
		return value, nil
	default:
		return nil, fmt.Errorf("unsupported JSON value %T", edited)
	}
}

func validateEditorValue(value any, depth int) error {
	if depth > 64 {
		return errors.New("存档嵌套超过 64 层")
	}
	switch v := value.(type) {
	case nil, bool:
		return nil
	case string:
		if len(v) > 1024*1024 {
			return errors.New("单个字符串超过 1 MB")
		}
	case int:
		return nil
	case int64:
		if v > 9007199254740991 || v < -9007199254740991 {
			return errors.New("整数超过 JavaScript 安全范围")
		}
	case float64:
		if math.IsNaN(v) || math.IsInf(v, 0) {
			return errors.New("数值不能是 NaN 或 Infinity")
		}
		if math.Abs(v) > 9007199254740991 {
			return errors.New("数值过大，可能导致存档精度损失")
		}
	case []any:
		if len(v) > 1_000_000 {
			return errors.New("数组过大")
		}
		for _, item := range v {
			if err := validateEditorValue(item, depth+1); err != nil {
				return err
			}
		}
	case map[string]any:
		if len(v) > 100_000 {
			return errors.New("对象字段过多")
		}
		for key, item := range v {
			if len(key) > 4096 {
				return errors.New("字段名过长")
			}
			if err := validateEditorValue(item, depth+1); err != nil {
				return fmt.Errorf("%s: %w", key, err)
			}
		}
	default:
		return fmt.Errorf("不支持的数据类型 %T", value)
	}
	return nil
}

func (s *saveStore) editorBackupDir() string {
	return filepath.Join(s.saves, "backups")
}

func (s *saveStore) createEditorBackup(raw []byte, reason string) (string, error) {
	if len(raw) == 0 {
		return "", errors.New("empty backup")
	}
	dir := s.editorBackupDir()
	if err := os.MkdirAll(dir, 0o755); err != nil {
		return "", err
	}
	reason = sanitizeBackupPart(reason)
	name := time.Now().Format("20060102-150405.000000000") + "-" + reason + ".bin"
	path := filepath.Join(dir, name)
	if err := os.WriteFile(path, raw, 0o644); err != nil {
		return "", err
	}
	if err := s.trimEditorBackups(20); err != nil {
		return "", err
	}
	return name, nil
}

func sanitizeBackupPart(value string) string {
	var builder strings.Builder
	for _, char := range value {
		if char >= 'a' && char <= 'z' || char >= 'A' && char <= 'Z' || char >= '0' && char <= '9' || char == '-' || char == '_' {
			builder.WriteRune(char)
		}
	}
	if builder.Len() == 0 {
		return "backup"
	}
	return builder.String()
}

func (s *saveStore) listEditorBackups() ([]editorBackup, error) {
	dir := s.editorBackupDir()
	entries, err := os.ReadDir(dir)
	if errors.Is(err, os.ErrNotExist) {
		return []editorBackup{}, nil
	}
	if err != nil {
		return nil, err
	}
	backups := make([]editorBackup, 0, len(entries))
	for _, entry := range entries {
		if entry.IsDir() || !strings.HasSuffix(strings.ToLower(entry.Name()), ".bin") {
			continue
		}
		info, err := entry.Info()
		if err != nil {
			continue
		}
		backups = append(backups, editorBackup{
			Name: entry.Name(), Size: info.Size(), CreatedAt: info.ModTime().Format(time.RFC3339),
		})
	}
	sort.Slice(backups, func(i, j int) bool { return backups[i].Name > backups[j].Name })
	return backups, nil
}

func (s *saveStore) trimEditorBackups(limit int) error {
	backups, err := s.listEditorBackups()
	if err != nil {
		return err
	}
	if len(backups) <= limit {
		return nil
	}
	for _, backup := range backups[limit:] {
		if err := os.Remove(filepath.Join(s.editorBackupDir(), backup.Name)); err != nil {
			return err
		}
	}
	return nil
}

func (s *saveStore) readEditorBackup(name string) ([]byte, error) {
	if filepath.Base(name) != name || !strings.HasSuffix(strings.ToLower(name), ".bin") {
		return nil, errors.New("invalid backup name")
	}
	path := filepath.Join(s.editorBackupDir(), name)
	raw, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}
	if _, _, err := parseGamePayload(raw); err != nil {
		return nil, errors.New("backup is not a valid game save")
	}
	return raw, nil
}
