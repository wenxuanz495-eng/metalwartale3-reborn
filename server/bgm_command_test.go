package main

import "testing"

func TestBGMCommandSequenceRejectsStaleAndDuplicateCommands(t *testing.T) {
	p := &bgmPlayer{}
	if !p.acceptCommandLocked(100) {
		t.Fatal("first ordered command was rejected")
	}
	if p.acceptCommandLocked(99) {
		t.Fatal("stale command was accepted")
	}
	if p.acceptCommandLocked(100) {
		t.Fatal("duplicate command was accepted")
	}
	if !p.acceptCommandLocked(101) {
		t.Fatal("newer command was rejected")
	}
}

func TestBGMCommandSequenceKeepsLegacyRequestsCompatible(t *testing.T) {
	p := &bgmPlayer{commandSeq: 100}
	if !p.acceptCommandLocked(0) {
		t.Fatal("legacy command without a sequence was rejected")
	}
	if p.commandSeq != 100 {
		t.Fatalf("legacy command changed sequence to %d", p.commandSeq)
	}
}

func TestScenePlaylistChangeKeepsCurrentPlayerTrackWhenStillSelected(t *testing.T) {
	p := &bgmPlayer{
		ready:        true,
		playing:      true,
		label:        "player-track-a",
		positionBase: 37.5,
		tracks: map[string]bgmTrack{
			"player-track-a": {ID: "player-track-a", Context: "player", Path: "bgm/player/a.mp3"},
			"player-track-b": {ID: "player-track-b", Context: "player", Path: "bgm/player/b.mp3"},
		},
	}

	handled, err := p.startPlaylist("battle", "sequence", []string{"player-track-b", "player-track-a"}, false, 1)
	if err != nil || !handled {
		t.Fatalf("scene playlist update failed: handled=%v err=%v", handled, err)
	}
	if p.label != "player-track-a" {
		t.Fatalf("current player track was replaced with %q", p.label)
	}
	if p.positionBase != 37.5 {
		t.Fatalf("current player track position was reset to %v", p.positionBase)
	}
	if p.playlistContext != "battle" || p.playlistIndex != 1 {
		t.Fatalf("destination playlist was not adopted: context=%q index=%d", p.playlistContext, p.playlistIndex)
	}
}
