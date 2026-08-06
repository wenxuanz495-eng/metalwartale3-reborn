package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"mime"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"
)

type app struct {
	root     string
	store    *saveStore
	instance string
	bgm      *bgmPlayer
}

func (a *app) routes() http.Handler {
	return http.HandlerFunc(a.serveHTTP)
}

func (a *app) serveHTTP(w http.ResponseWriter, r *http.Request) {
	isEditorAPI := strings.HasPrefix(r.URL.Path, "/api/editor/")
	if !isEditorAPI {
		w.Header().Set("Access-Control-Allow-Origin", "*")
	}
	w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
	w.Header().Set("Access-Control-Allow-Headers", "*")
	w.Header().Set("Cache-Control", "no-cache")
	if r.Method == http.MethodOptions {
		w.WriteHeader(http.StatusNoContent)
		return
	}
	path, err := url.PathUnescape(r.URL.Path)
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": "invalid path"}, http.StatusBadRequest)
		return
	}
	if a.serveEditor(w, r, path) {
		return
	}
	switch {
	case r.Method == http.MethodGet && path == "/api/bgm/status":
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case r.Method == http.MethodGet && path == "/api/bgm/catalog":
		a.sendJSON(w, a.bgm.catalogStatus(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/catalog/rescan":
		a.sendJSON(w, a.bgm.rescanCatalog(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/player-library/open":
		if err := a.bgm.openPlayerLibrary(); err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
			return
		}
		a.sendJSON(w, map[string]any{"ok": true}, http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/playlist/start":
		ids := strings.Split(r.URL.Query().Get("tracks"), ",")
		forceSwitch := r.URL.Query().Get("force") == "1"
		seq, err := bgmCommandSequence(r)
		if err == nil {
			_, err = a.bgm.startPlaylist(r.URL.Query().Get("context"), r.URL.Query().Get("mode"), ids, forceSwitch, seq)
		}
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/playlist/update":
		ids := strings.Split(r.URL.Query().Get("tracks"), ",")
		if err := a.bgm.updatePlaylist(r.URL.Query().Get("context"), r.URL.Query().Get("mode"), ids); err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/play":
		label := r.URL.Query().Get("label")
		seq, err := bgmCommandSequence(r)
		if err == nil {
			_, err = a.bgm.play(label, seq)
		}
		if os.IsNotExist(err) {
			a.sendJSON(w, map[string]any{"ok": false, "fallback": true, "error": "BGM track not found"}, http.StatusNotFound)
			return
		}
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "fallback": true, "error": err.Error()}, http.StatusServiceUnavailable)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/track/play":
		seq, err := bgmCommandSequence(r)
		if err == nil {
			_, err = a.bgm.playTrack(r.URL.Query().Get("id"), seq)
		}
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/seek":
		seconds, err := strconv.ParseFloat(r.URL.Query().Get("seconds"), 64)
		if err == nil {
			err = a.bgm.seek(seconds)
		}
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/pause":
		if err := a.bgm.pause(); err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/resume":
		if err := a.bgm.resume(); err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/previous":
		if err := a.bgm.changePlaylistTrack(-1); err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/next":
		if err := a.bgm.changePlaylistTrack(1); err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/stop":
		seq, err := bgmCommandSequence(r)
		if err == nil {
			_, err = a.bgm.stop(seq)
		}
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusServiceUnavailable)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case (r.Method == http.MethodGet || r.Method == http.MethodPost) && path == "/api/bgm/volume":
		value, err := strconv.ParseFloat(r.URL.Query().Get("value"), 64)
		if err == nil {
			err = a.bgm.setVolume(value)
		}
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, a.bgm.status(), http.StatusOK)
	case r.Method == http.MethodGet && (path == "/" || path == "/index.html"):
		a.sendBytes(w, []byte(indexHTML), "text/html; charset=utf-8", http.StatusOK)
	case r.Method == http.MethodGet && path == "/crossdomain.xml":
		a.sendBytes(w, []byte(crossDomain), "text/xml; charset=utf-8", http.StatusOK)
	case r.Method == http.MethodGet && path == "/api/client-logs":
		a.clientLogList(w, r)
	case r.Method == http.MethodGet && path == "/api/status":
		a.sendJSON(w, map[string]any{
			"ok": true, "backend": "go", "game": "/game.swf",
			"time": nowISO(), "saves_dir": a.store.saves, "instance": a.instance,
		}, http.StatusOK)
	case r.Method == http.MethodGet && path == "/api/saves/export":
		result, err := a.store.exportSOL(true)
		a.sendResult(w, result, err)
	case r.Method == http.MethodPost && path == "/api/saves/export":
		result, err := a.store.exportSOL(true)
		a.sendResult(w, result, err)
	case r.Method == http.MethodGet && path == "/api/saves/list":
		result, err := a.store.list()
		a.sendResult(w, result, err)
	case r.Method == http.MethodGet && path == "/api/saves/latest.json":
		data, err := os.ReadFile(a.store.jsonPath)
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": "no export yet"}, http.StatusNotFound)
			return
		}
		a.sendBytes(w, data, "application/json; charset=utf-8", http.StatusOK)
	case r.Method == http.MethodGet && path == "/api/game-save":
		data, err := a.store.getPrimary()
		if err != nil {
			code := http.StatusInternalServerError
			if os.IsNotExist(err) {
				code = http.StatusNotFound
			}
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, code)
			return
		}
		a.sendBytes(w, data, "application/octet-stream", http.StatusOK)
	case r.Method == http.MethodPost && path == "/api/game-save":
		body, err := io.ReadAll(http.MaxBytesReader(w, r.Body, 16*1024*1024+1))
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		result, err := a.store.savePrimary(body, "go-primary")
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
			return
		}
		a.sendJSON(w, result, http.StatusOK)
	case r.Method == http.MethodPost && path == "/api/game-save/backup":
		raw, err := a.store.getPrimary()
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusNotFound)
			return
		}
		if _, _, err := parseGamePayload(raw); err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": "invalid game save: " + err.Error()}, http.StatusBadRequest)
			return
		}
		backup, err := a.store.createEditorBackup(raw, "in-game")
		if err != nil {
			a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
			return
		}
		a.sendJSON(w, map[string]any{"ok": true, "backup": backup}, http.StatusOK)
	case r.Method == http.MethodPost && path == "/api/client-log":
		a.clientLog(w, r)
	case strings.HasPrefix(path, "/api/4399/") || strings.Contains(path, "save.api"):
		a.mock4399(w, r, path)
	case r.Method == http.MethodGet || r.Method == http.MethodHead:
		a.serveStatic(w, r, path)
	default:
		http.NotFound(w, r)
	}
}

func bgmCommandSequence(r *http.Request) (uint64, error) {
	raw := r.URL.Query().Get("seq")
	if raw == "" {
		return 0, nil
	}
	return strconv.ParseUint(raw, 10, 64)
}

func (a *app) serveStatic(w http.ResponseWriter, r *http.Request, requestPath string) {
	clean := filepath.Clean(filepath.FromSlash(strings.TrimPrefix(requestPath, "/")))
	if clean == "." {
		http.NotFound(w, r)
		return
	}
	full := filepath.Join(a.root, clean)
	relative, err := filepath.Rel(a.root, full)
	if err != nil || relative == ".." || strings.HasPrefix(relative, ".."+string(filepath.Separator)) {
		http.Error(w, "forbidden", http.StatusForbidden)
		return
	}
	file, err := os.Open(full)
	if err != nil {
		http.NotFound(w, r)
		return
	}
	defer file.Close()
	info, err := file.Stat()
	if err != nil || info.IsDir() {
		http.NotFound(w, r)
		return
	}
	ctype := mime.TypeByExtension(strings.ToLower(filepath.Ext(full)))
	switch strings.ToLower(filepath.Ext(full)) {
	case ".swf":
		ctype = "application/x-shockwave-flash"
	case ".sol":
		ctype = "application/octet-stream"
	case ".xml":
		ctype = "application/xml; charset=utf-8"
	case ".json":
		ctype = "application/json; charset=utf-8"
	}
	if ctype == "" {
		ctype = "application/octet-stream"
	}
	w.Header().Set("Content-Type", ctype)
	w.Header().Set("Content-Length", strconv.FormatInt(info.Size(), 10))
	w.WriteHeader(http.StatusOK)
	if r.Method == http.MethodGet {
		_, _ = io.Copy(w, file)
	}
}

func (a *app) mock4399(w http.ResponseWriter, r *http.Request, path string) {
	lower := strings.ToLower(path)
	switch {
	case strings.Contains(lower, "list"), strings.Contains(lower, "get"):
		a.sendText(w, "0", http.StatusOK)
	case strings.Contains(lower, "save"), strings.Contains(lower, "set"):
		body, _ := io.ReadAll(http.MaxBytesReader(w, r.Body, 16*1024*1024))
		stamp := time.Now().Format("20060102_150405.000")
		base := filepath.Join(a.store.saves, "api_save_"+stamp)
		_ = os.MkdirAll(a.store.saves, 0o755)
		_ = os.WriteFile(base+".bin", body, 0o644)
		meta, _ := json.MarshalIndent(map[string]any{
			"path": path, "query": r.URL.Query(), "len": len(body), "at": nowISO(),
		}, "", "  ")
		_ = os.WriteFile(base+".meta.json", meta, 0o644)
		a.sendText(w, "1", http.StatusOK)
	case strings.Contains(lower, "time"), strings.Contains(lower, "session"):
		a.sendText(w, time.Now().Format("2006-01-02 15:04:05"), http.StatusOK)
	case strings.Contains(lower, "token"):
		a.sendText(w, "offline-token", http.StatusOK)
	default:
		a.sendText(w, "1", http.StatusOK)
	}
}

func (a *app) sendResult(w http.ResponseWriter, value any, err error) {
	if err != nil {
		log.Printf("[http] %v", err)
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
		return
	}
	a.sendJSON(w, value, http.StatusOK)
}

func (a *app) sendJSON(w http.ResponseWriter, value any, code int) {
	data, err := json.MarshalIndent(value, "", "  ")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	a.sendBytes(w, data, "application/json; charset=utf-8", code)
}

func (a *app) sendText(w http.ResponseWriter, value string, code int) {
	a.sendBytes(w, []byte(value), "text/plain; charset=utf-8", code)
}

func (a *app) sendBytes(w http.ResponseWriter, data []byte, contentType string, code int) {
	w.Header().Set("Content-Type", contentType)
	w.Header().Set("Content-Length", strconv.Itoa(len(data)))
	w.WriteHeader(code)
	_, _ = w.Write(data)
}

const crossDomain = `<?xml version="1.0"?>
<!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">
<cross-domain-policy>
  <site-control permitted-cross-domain-policies="all"/>
  <allow-access-from domain="*" secure="false"/>
  <allow-http-request-headers-from domain="*" headers="*" secure="false"/>
</cross-domain-policy>
`

const indexHTML = `<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8"/>
<title>超合金战记3 离线包</title>
<style>
 body{font-family:system-ui,sans-serif;max-width:720px;margin:2rem auto;padding:0 1rem;line-height:1.5}
 code{background:#f4f4f4;padding:0.1em 0.3em;border-radius:3px}
 a{color:#06c}.box{border:1px solid #ddd;border-radius:8px;padding:1rem;margin:1rem 0}
</style>
</head>
<body>
<h1>超合金战记3 · Go 离线服务</h1>
<p>请用 <strong>SAFlashPlayer</strong> 打开游戏地址。</p>
<div class="box"><p>游戏地址：</p><p><code id="url"></code></p></div>
<div class="box">
 <p>权威存档：<code>saves/game_save.bin</code>；同时导出 JSON 和 SQLite 历史。</p>
 <p><a href="/api/saves/export">查看当前存档</a> · <a href="/api/saves/list">存档列表</a> · <a href="/api/saves/latest.json">最新 JSON</a></p>
</div>
<script>document.getElementById('url').textContent=location.origin+'/game.swf';</script>
</body></html>`

func (a *app) clientLog(w http.ResponseWriter, r *http.Request) {
	body, err := io.ReadAll(http.MaxBytesReader(w, r.Body, 64*1024+1))
	if err != nil {
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusBadRequest)
		return
	}
	kind := "error"
	message := strings.TrimSpace(string(body))
	stack := ""
	extra := ""
	var payload map[string]any
	if json.Unmarshal(body, &payload) == nil {
		if v, ok := payload["kind"].(string); ok && strings.TrimSpace(v) != "" {
			kind = strings.TrimSpace(v)
		}
		if v, ok := payload["message"].(string); ok {
			message = strings.TrimSpace(v)
		}
		if v, ok := payload["stack"].(string); ok {
			stack = strings.TrimSpace(v)
		}
		if v, ok := payload["extra"].(string); ok {
			extra = strings.TrimSpace(v)
		}
	}
	if message == "" {
		message = "(empty client error)"
	}
	// Console output for black window / server console.
	log.Printf("[client-error] kind=%s message=%s extra=%s", kind, message, extra)
	if stack != "" {
		log.Printf("[client-error-stack]\n%s", stack)
	}
	// Persist for later diagnosis.
	if err := a.appendClientLog(kind, message, stack, extra); err != nil {
		log.Printf("[client-error] write log file failed: %v", err)
	}
	a.sendJSON(w, map[string]any{"ok": true}, http.StatusOK)
}

func (a *app) clientLogList(w http.ResponseWriter, r *http.Request) {
	path := a.clientLogPath()
	data, err := os.ReadFile(path)
	if err != nil {
		if os.IsNotExist(err) {
			a.sendJSON(w, map[string]any{"ok": true, "path": path, "lines": []string{}}, http.StatusOK)
			return
		}
		a.sendJSON(w, map[string]any{"ok": false, "error": err.Error()}, http.StatusInternalServerError)
		return
	}
	raw := strings.ReplaceAll(string(data), "\r\n", "\n")
	lines := strings.Split(strings.TrimRight(raw, "\n"), "\n")
	if len(lines) == 1 && lines[0] == "" {
		lines = []string{}
	}
	// return last 200 lines
	if len(lines) > 200 {
		lines = lines[len(lines)-200:]
	}
	a.sendJSON(w, map[string]any{"ok": true, "path": path, "lines": lines}, http.StatusOK)
}

func (a *app) clientLogPath() string {
	return filepath.Join(a.store.saves, "client_errors.log")
}

func (a *app) appendClientLog(kind, message, stack, extra string) error {
	if err := os.MkdirAll(a.store.saves, 0o755); err != nil {
		return err
	}
	f, err := os.OpenFile(a.clientLogPath(), os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0o644)
	if err != nil {
		return err
	}
	defer f.Close()
	line := fmt.Sprintf("%s\tkind=%s\tmessage=%s", time.Now().Format(time.RFC3339), sanitizeLogField(kind), sanitizeLogField(message))
	if extra != "" {
		line += "\textra=" + sanitizeLogField(extra)
	}
	if stack != "" {
		line += "\tstack=" + sanitizeLogField(stack)
	}
	line += "\n"
	_, err = f.WriteString(line)
	return err
}

func sanitizeLogField(v string) string {
	v = strings.ReplaceAll(v, "\r", "\\r")
	v = strings.ReplaceAll(v, "\n", "\\n")
	v = strings.ReplaceAll(v, "\t", " ")
	if len(v) > 4000 {
		v = v[:4000]
	}
	return v
}
func logRequest(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("[http] %s %s", r.Method, r.URL.RequestURI())
		next.ServeHTTP(w, r)
	})
}

func gameURL(host string, port int) string {
	return fmt.Sprintf("http://%s:%d/game.swf", host, port)
}
