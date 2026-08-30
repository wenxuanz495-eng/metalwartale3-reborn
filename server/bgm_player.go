package main

import (
	"crypto/sha256"
	"encoding/json"
	"errors"
	"fmt"
	"math"
	"math/rand"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"sort"
	"strings"
	"sync"
	"time"
)

const externalBGMBaseGain = 0.20

var bgmLabelPattern = regexp.MustCompile(`^[A-Za-z0-9_-]+$`)

type bgmTrack struct {
	ID            string   `json:"id"`
	Title         string   `json:"title"`
	Group         string   `json:"group"`
	Context       string   `json:"context"`
	Aliases       []string `json:"aliases,omitempty"`
	DefaultMain   bool     `json:"default_main,omitempty"`
	DefaultBattle bool     `json:"default_battle,omitempty"`
	MainOrder     int      `json:"main_order,omitempty"`
	BattleOrder   int      `json:"battle_order,omitempty"`
	Path          string   `json:"-"`
}

type bgmManifest struct {
	Tracks []bgmManifestTrack `json:"tracks"`
}

type bgmManifestTrack struct {
	ID            string   `json:"id"`
	File          string   `json:"file"`
	Group         string   `json:"group"`
	Context       string   `json:"context"`
	Aliases       []string `json:"aliases"`
	DefaultMain   bool     `json:"default_main"`
	DefaultBattle bool     `json:"default_battle"`
	MainOrder     int      `json:"main_order"`
	BattleOrder   int      `json:"battle_order"`
}

type bgmPlayer struct {
	mu              sync.Mutex
	root            string
	ready           bool
	playing         bool
	paused          bool
	label           string
	volume          float32
	native          nativeBGM
	err             string
	catalog         []bgmTrack
	tracks          map[string]bgmTrack
	playlist        []string
	playlistIndex   int
	playlistMode    string
	playlistContext string
	playlistActive  bool
	rng             *rand.Rand
	done            chan struct{}
	startedAt       time.Time
	positionBase    float32
	duration        float32
	commandSeq      uint64
}

type bgmStatus struct {
	OK              bool    `json:"ok"`
	Ready           bool    `json:"ready"`
	Playing         bool    `json:"playing"`
	Paused          bool    `json:"paused"`
	Label           string  `json:"label"`
	Volume          float32 `json:"volume"`
	BaseGain        float32 `json:"base_gain"`
	Position        float32 `json:"position"`
	Duration        float32 `json:"duration"`
	PlaylistMode    string  `json:"playlist_mode,omitempty"`
	PlaylistContext string  `json:"playlist_context,omitempty"`
	Error           string  `json:"error,omitempty"`
}

func newBGMPlayer(root string) *bgmPlayer {
	p := &bgmPlayer{
		root: root, volume: 1, tracks: make(map[string]bgmTrack),
		rng: rand.New(rand.NewSource(time.Now().UnixNano())), done: make(chan struct{}),
	}
	p.scanRecommendedCatalog()
	dllPath := filepath.Join(root, "tools", "audio", "miniaudio.dll")
	if err := p.native.init(dllPath, root); err != nil {
		p.err = err.Error()
		return p
	}
	p.ready = true
	go p.monitorPlaylist()
	return p
}

func (p *bgmPlayer) playerLibraryPath() string {
	return filepath.Join(p.root, "bgm", "player")
}

func (p *bgmPlayer) openPlayerLibrary() error {
	folder := p.playerLibraryPath()
	if err := os.MkdirAll(folder, 0755); err != nil {
		return err
	}
	return exec.Command("explorer.exe", folder).Start()
}

func (p *bgmPlayer) rescanCatalog() map[string]any {
	p.mu.Lock()
	defer p.mu.Unlock()
	p.scanRecommendedCatalog()
	return map[string]any{"ok": true, "tracks": p.catalog}
}

func (p *bgmPlayer) close() {
	p.mu.Lock()
	defer p.mu.Unlock()
	if p.ready {
		close(p.done)
		p.native.shutdown()
		p.ready = false
	}
}

func (p *bgmPlayer) status() bgmStatus {
	p.mu.Lock()
	defer p.mu.Unlock()
	position, duration := float32(0), p.duration
	if p.ready && p.playing {
		position = p.positionBase + float32(time.Since(p.startedAt).Seconds())
		if p.paused {
			position = p.positionBase
		}
		if duration > 0 && position >= duration {
			if p.playlistActive && p.playlistMode == "single" {
				position = float32(math.Mod(float64(position), float64(duration)))
			} else {
				position = duration
			}
		}
	}
	return bgmStatus{OK: true, Ready: p.ready, Playing: p.playing, Paused: p.paused, Label: p.label, Volume: p.volume, BaseGain: externalBGMBaseGain, Position: position, Duration: duration, PlaylistMode: p.playlistMode, PlaylistContext: p.playlistContext, Error: p.err}
}

func (p *bgmPlayer) playTrack(id string, commandSeq uint64) (bool, error) {
	p.mu.Lock()
	defer p.mu.Unlock()
	if !p.acceptCommandLocked(commandSeq) {
		return false, nil
	}
	track, ok := p.tracks[id]
	if !ok {
		return true, os.ErrNotExist
	}
	if !p.ready {
		return true, errors.New("external BGM player unavailable: " + p.err)
	}
	if index := indexOfTrack(p.playlist, id); index >= 0 {
		p.playlistIndex = index
		p.playlistActive = true
	} else {
		p.playlistActive = false
	}
	if err := p.native.play(track.Path, true, p.outputVolume(), 0.15); err != nil {
		return true, fmt.Errorf("play recommended BGM: %w", err)
	}
	p.playing = true
	p.paused = false
	p.label = track.ID
	p.playlistContext = track.Context
	p.startTimelineLocked(track.Path)
	return true, nil
}

func indexOfTrack(ids []string, id string) int {
	for i, candidate := range ids {
		if candidate == id {
			return i
		}
	}
	return -1
}

func (p *bgmPlayer) pause() error {
	p.mu.Lock()
	defer p.mu.Unlock()
	if !p.ready || !p.playing || p.paused {
		return errors.New("BGM cannot be paused")
	}
	p.positionBase += float32(time.Since(p.startedAt).Seconds())
	if err := p.native.pause(); err != nil {
		return err
	}
	p.paused = true
	return nil
}

func (p *bgmPlayer) resume() error {
	p.mu.Lock()
	defer p.mu.Unlock()
	if !p.ready || !p.playing || !p.paused {
		return errors.New("BGM cannot be resumed")
	}
	if err := p.native.resume(); err != nil {
		return err
	}
	p.startedAt = time.Now()
	p.paused = false
	return nil
}

func (p *bgmPlayer) changePlaylistTrack(direction int) error {
	p.mu.Lock()
	defer p.mu.Unlock()
	if !p.ready || len(p.playlist) == 0 {
		return errors.New("playlist has no playable tracks")
	}
	if direction > 0 && p.playlistMode == "random" {
		p.playlistIndex = p.rng.Intn(len(p.playlist))
	} else {
		p.playlistIndex = (p.playlistIndex + direction + len(p.playlist)) % len(p.playlist)
	}
	p.playlistActive = true
	return p.playPlaylistTrackLocked()
}

func (p *bgmPlayer) seek(seconds float64) error {
	p.mu.Lock()
	defer p.mu.Unlock()
	if !p.ready || !p.playing {
		return errors.New("BGM is not playing")
	}
	if math.IsNaN(seconds) || math.IsInf(seconds, 0) || seconds < 0 || p.duration <= 0 || seconds > float64(p.duration) {
		return errors.New("invalid BGM position")
	}
	if err := p.native.seek(float32(seconds)); err != nil {
		return err
	}
	p.positionBase = float32(seconds)
	p.startedAt = time.Now()
	return nil
}

func (p *bgmPlayer) play(label string, commandSeq uint64) (bool, error) {
	p.mu.Lock()
	defer p.mu.Unlock()
	if !p.acceptCommandLocked(commandSeq) {
		return false, nil
	}
	if !p.ready {
		return true, errors.New("external BGM player unavailable: " + p.err)
	}
	if !bgmLabelPattern.MatchString(label) {
		return true, errors.New("invalid BGM label")
	}
	rel := filepath.ToSlash(filepath.Join("bgm", "default", label+".mp3"))
	if _, err := os.Stat(filepath.Join(p.root, filepath.FromSlash(rel))); err != nil {
		if os.IsNotExist(err) {
			return true, os.ErrNotExist
		}
		return true, err
	}
	p.playlistActive = false
	if err := p.native.play(rel, true, p.outputVolume(), 0.15); err != nil {
		return true, fmt.Errorf("play BGM: %w", err)
	}
	p.playing = true
	p.paused = false
	p.label = label
	p.startTimelineLocked(rel)
	return true, nil
}

func (p *bgmPlayer) stop(commandSeq uint64) (bool, error) {
	p.mu.Lock()
	defer p.mu.Unlock()
	if !p.acceptCommandLocked(commandSeq) {
		return false, nil
	}
	if !p.ready {
		return true, errors.New("external BGM player unavailable")
	}
	if err := p.native.stop(0.1); err != nil {
		return true, err
	}
	p.playing = false
	p.paused = false
	p.label = ""
	p.playlistActive = false
	p.positionBase = 0
	p.duration = 0
	return true, nil
}

func (p *bgmPlayer) acceptCommandLocked(commandSeq uint64) bool {
	if commandSeq == 0 {
		return true
	}
	if commandSeq <= p.commandSeq {
		return false
	}
	p.commandSeq = commandSeq
	return true
}

func (p *bgmPlayer) setVolume(value float64) error {
	p.mu.Lock()
	defer p.mu.Unlock()
	if math.IsNaN(value) || math.IsInf(value, 0) || value < 0 || value > 1 {
		return errors.New("volume must be between 0 and 1")
	}
	p.volume = float32(value)
	if !p.ready {
		return errors.New("external BGM player unavailable")
	}
	p.native.setVolume(p.outputVolume())
	return nil
}

func (p *bgmPlayer) outputVolume() float32 { return p.volume * externalBGMBaseGain }

func (p *bgmPlayer) startTimelineLocked(rel string) {
	p.positionBase = 0
	p.startedAt = time.Now()
	p.duration = float32(mediaDuration(filepath.Join(p.root, filepath.FromSlash(rel))).Seconds())
}

func (p *bgmPlayer) catalogStatus() map[string]any {
	p.mu.Lock()
	defer p.mu.Unlock()
	return map[string]any{"ok": true, "tracks": p.catalog}
}

func (p *bgmPlayer) scanRecommendedCatalog() {
	p.catalog = nil
	p.tracks = make(map[string]bgmTrack)
	selected := ""
	workspaceRoot := filepath.Clean(filepath.Join(p.root, "..", ".."))
	if entries, err := os.ReadDir(workspaceRoot); err == nil {
		for _, entry := range entries {
			if !entry.IsDir() {
				continue
			}
			candidate := filepath.Join(workspaceRoot, entry.Name())
			if info, markerErr := os.Stat(filepath.Join(candidate, ".playlist-root")); markerErr == nil && !info.IsDir() {
				selected = candidate
				break
			}
		}
	}
	if selected == "" {
		candidate := filepath.Join(p.root, "bgm", "recommended")
		if info, err := os.Stat(candidate); err == nil && info.IsDir() {
			selected = candidate
		}
	}
	if selected == "" {
		p.scanPlayerCatalog()
		return
	}
	if p.scanUnifiedDeveloperCatalog(selected) {
		p.scanPlayerCatalog()
		p.sortCatalog()
		return
	}
	_ = filepath.Walk(selected, func(path string, info os.FileInfo, err error) error {
		if err != nil || info == nil || info.IsDir() {
			return nil
		}
		ext := strings.ToLower(filepath.Ext(path))
		if ext != ".mp3" && ext != ".flac" && ext != ".wav" {
			return nil
		}
		rel, err := filepath.Rel(selected, path)
		if err != nil {
			return nil
		}
		parts := strings.Split(filepath.ToSlash(rel), "/")
		if len(parts) < 2 {
			return nil
		}
		context := ""
		if strings.EqualFold(parts[0], "主界面bgm") {
			context = "main"
		} else if strings.EqualFold(parts[0], "战斗bgm") {
			context = "battle"
		} else {
			return nil
		}
		group := "默认"
		if len(parts) > 2 {
			group = strings.Join(parts[1:len(parts)-1], " / ")
		}
		hash := sha256.Sum256([]byte(filepath.ToSlash(rel)))
		id := fmt.Sprintf("%x", hash[:8])
		playRel, err := filepath.Rel(p.root, path)
		if err != nil {
			return nil
		}
		track := bgmTrack{ID: id, Title: strings.TrimSuffix(info.Name(), filepath.Ext(info.Name())), Group: group, Context: context, Path: filepath.ToSlash(playRel)}
		p.catalog = append(p.catalog, track)
		p.tracks[id] = track
		return nil
	})
	p.scanPlayerCatalog()
	p.sortCatalog()
}

func (p *bgmPlayer) sortCatalog() {
	sort.Slice(p.catalog, func(i, j int) bool {
		if p.catalog[i].Context != p.catalog[j].Context {
			return p.catalog[i].Context < p.catalog[j].Context
		}
		if p.catalog[i].Group != p.catalog[j].Group {
			return p.catalog[i].Group < p.catalog[j].Group
		}
		return p.catalog[i].Title < p.catalog[j].Title
	})
}

func (p *bgmPlayer) scanUnifiedDeveloperCatalog(selected string) bool {
	library := ""
	manifestPath := ""
	entries, err := os.ReadDir(selected)
	if err != nil {
		return false
	}
	for _, entry := range entries {
		if !entry.IsDir() {
			continue
		}
		candidateLibrary := filepath.Join(selected, entry.Name())
		candidateManifest := filepath.Join(candidateLibrary, "developer-playlists.json")
		if info, statErr := os.Stat(candidateManifest); statErr == nil && !info.IsDir() {
			library = candidateLibrary
			manifestPath = candidateManifest
			break
		}
	}
	if manifestPath == "" {
		return false
	}
	data, err := os.ReadFile(manifestPath)
	if err != nil {
		return false
	}
	var manifest bgmManifest
	if json.Unmarshal(data, &manifest) != nil {
		return false
	}
	manifestFiles := make(map[string]bool)
	for _, entry := range manifest.Tracks {
		manifestFiles[strings.ToLower(filepath.ToSlash(filepath.Clean(entry.File)))] = true
		fullPath := filepath.Join(library, filepath.FromSlash(entry.File))
		info, err := os.Stat(fullPath)
		if err != nil || info.IsDir() {
			continue
		}
		playRel, err := filepath.Rel(p.root, fullPath)
		if err != nil {
			continue
		}
		track := bgmTrack{ID: entry.ID, Title: strings.TrimSuffix(info.Name(), filepath.Ext(info.Name())), Group: entry.Group, Context: entry.Context, Aliases: entry.Aliases, DefaultMain: entry.DefaultMain, DefaultBattle: entry.DefaultBattle, MainOrder: entry.MainOrder, BattleOrder: entry.BattleOrder, Path: filepath.ToSlash(playRel)}
		p.catalog = append(p.catalog, track)
		p.tracks[track.ID] = track
		for _, alias := range track.Aliases {
			p.tracks[alias] = track
		}
	}
	_ = filepath.Walk(library, func(path string, info os.FileInfo, walkErr error) error {
		if walkErr != nil || info == nil || info.IsDir() {
			return nil
		}
		ext := strings.ToLower(filepath.Ext(path))
		if ext != ".mp3" && ext != ".flac" && ext != ".wav" {
			return nil
		}
		rel, relErr := filepath.Rel(library, path)
		if relErr != nil {
			return nil
		}
		normalizedRel := filepath.ToSlash(filepath.Clean(rel))
		if manifestFiles[strings.ToLower(normalizedRel)] {
			return nil
		}
		group := filepath.ToSlash(filepath.Dir(rel))
		if group == "." {
			group = "开发者曲库"
		}
		hash := sha256.Sum256([]byte("developer/" + normalizedRel))
		id := fmt.Sprintf("%x", hash[:8])
		playRel, relErr := filepath.Rel(p.root, path)
		if relErr != nil {
			return nil
		}
		track := bgmTrack{ID: id, Title: strings.TrimSuffix(info.Name(), filepath.Ext(info.Name())), Group: group, Context: "developer", Path: filepath.ToSlash(playRel)}
		p.catalog = append(p.catalog, track)
		p.tracks[id] = track
		return nil
	})
	return true
}

func (p *bgmPlayer) scanPlayerCatalog() {
	root := p.playerLibraryPath()
	_ = os.MkdirAll(root, 0755)
	_ = filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		if err != nil || info == nil || info.IsDir() {
			return nil
		}
		ext := strings.ToLower(filepath.Ext(path))
		if ext != ".mp3" && ext != ".flac" && ext != ".wav" {
			return nil
		}
		rel, err := filepath.Rel(root, path)
		if err != nil {
			return nil
		}
		parts := strings.Split(filepath.ToSlash(rel), "/")
		group := "玩家曲库"
		if len(parts) > 1 {
			group = strings.Join(parts[:len(parts)-1], " / ")
		}
		hash := sha256.Sum256([]byte("player/" + filepath.ToSlash(rel)))
		id := fmt.Sprintf("%x", hash[:8])
		playRel, err := filepath.Rel(p.root, path)
		if err != nil {
			return nil
		}
		track := bgmTrack{ID: id, Title: strings.TrimSuffix(info.Name(), filepath.Ext(info.Name())), Group: group, Context: "player", Path: filepath.ToSlash(playRel)}
		p.catalog = append(p.catalog, track)
		p.tracks[id] = track
		return nil
	})
}

func (p *bgmPlayer) startPlaylist(context, mode string, ids []string, forceSwitch bool, commandSeq uint64) (bool, error) {
	p.mu.Lock()
	defer p.mu.Unlock()
	if !p.acceptCommandLocked(commandSeq) {
		return false, nil
	}
	if !p.ready {
		return true, errors.New("external BGM player unavailable")
	}
	if context != "main" && context != "battle" {
		return true, errors.New("invalid playlist context")
	}
	if mode != "sequence" && mode != "random" && mode != "single" {
		return true, errors.New("invalid playlist mode")
	}
	valid := make([]string, 0, len(ids))
	for _, id := range ids {
		if _, ok := p.tracks[id]; ok {
			valid = append(valid, id)
		}
	}
	if len(valid) == 0 {
		if err := p.native.stop(0.1); err != nil {
			return true, err
		}
		p.playlist = nil
		p.playlistActive = false
		p.playing = false
		p.paused = false
		p.label = ""
		p.positionBase = 0
		p.duration = 0
		return true, nil
	}
	p.playlist = valid
	p.playlistMode = mode
	p.playlistContext = context
	p.playlistIndex = 0
	p.playlistActive = true
	if !forceSwitch {
		if index := indexOfTrack(valid, p.label); index >= 0 && p.playing {
			p.playlistIndex = index
			if p.paused {
				if err := p.native.resume(); err != nil {
					return true, err
				}
				p.startedAt = time.Now()
				p.paused = false
			}
			return true, nil
		}
	}
	if mode == "random" {
		p.playlistIndex = p.rng.Intn(len(valid))
	}
	return true, p.playPlaylistTrackLocked()
}

func (p *bgmPlayer) updatePlaylist(context, mode string, ids []string) error {
	p.mu.Lock()
	defer p.mu.Unlock()
	if context != "main" && context != "battle" {
		return errors.New("invalid playlist context")
	}
	if mode != "sequence" && mode != "random" && mode != "single" {
		return errors.New("invalid playlist mode")
	}
	valid := make([]string, 0, len(ids))
	for _, id := range ids {
		if _, ok := p.tracks[id]; ok {
			valid = append(valid, id)
		}
	}
	if len(valid) == 0 {
		if err := p.native.stop(0.1); err != nil {
			return err
		}
		p.playlist = nil
		p.playing = false
		p.paused = false
		p.label = ""
		p.positionBase = 0
		p.duration = 0
		return nil
	}
	p.playlist = valid
	p.playlistMode = mode
	p.playlistContext = context
	p.playlistActive = true
	if index := indexOfTrack(valid, p.label); index >= 0 && p.playing {
		p.playlistIndex = index
		return nil
	}
	p.playlistIndex = 0
	if mode == "random" {
		p.playlistIndex = p.rng.Intn(len(valid))
	}
	return p.playPlaylistTrackLocked()
}

func (p *bgmPlayer) playPlaylistTrackLocked() error {
	track := p.tracks[p.playlist[p.playlistIndex]]
	loop := p.playlistMode == "single"
	if err := p.native.play(track.Path, loop, p.outputVolume(), 0.15); err != nil {
		return err
	}
	p.playing = true
	p.paused = false
	p.label = track.ID
	p.startTimelineLocked(track.Path)
	return nil
}

func (p *bgmPlayer) monitorPlaylist() {
	ticker := time.NewTicker(500 * time.Millisecond)
	defer ticker.Stop()
	for {
		select {
		case <-p.done:
			return
		case <-ticker.C:
			p.mu.Lock()
			if p.ready && p.playlistActive && p.playing && !p.paused && !p.native.isPlaying() {
				if p.playlistMode == "random" {
					p.playlistIndex = p.rng.Intn(len(p.playlist))
				} else {
					p.playlistIndex = (p.playlistIndex + 1) % len(p.playlist)
				}
				_ = p.playPlaylistTrackLocked()
			}
			p.mu.Unlock()
		}
	}
}
