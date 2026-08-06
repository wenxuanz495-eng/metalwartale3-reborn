//go:build windows

package main

import (
	"fmt"
	"math"
	"syscall"
	"unsafe"
)

type nativeBGM struct {
	dll           *syscall.LazyDLL
	initProc      *syscall.LazyProc
	playProc      *syscall.LazyProc
	stopProc      *syscall.LazyProc
	volumeProc    *syscall.LazyProc
	shutdownProc  *syscall.LazyProc
	isPlayingProc *syscall.LazyProc
	seekProc      *syscall.LazyProc
	pauseProc     *syscall.LazyProc
	resumeProc    *syscall.LazyProc
}

func (n *nativeBGM) init(dllPath, root string) error {
	n.dll = syscall.NewLazyDLL(dllPath)
	n.initProc = n.dll.NewProc("ma_bridge_init")
	n.playProc = n.dll.NewProc("ma_bridge_bgm_play")
	n.stopProc = n.dll.NewProc("ma_bridge_bgm_stop")
	n.volumeProc = n.dll.NewProc("ma_bridge_bgm_set_volume")
	n.shutdownProc = n.dll.NewProc("ma_bridge_shutdown")
	n.isPlayingProc = n.dll.NewProc("ma_bridge_bgm_is_playing")
	n.seekProc = n.dll.NewProc("ma_bridge_bgm_seek")
	n.pauseProc = n.dll.NewProc("ma_bridge_bgm_pause")
	n.resumeProc = n.dll.NewProc("ma_bridge_bgm_resume")
	if err := n.dll.Load(); err != nil {
		return err
	}
	rootPtr, err := syscall.UTF16PtrFromString(root)
	if err != nil {
		return err
	}
	result, _, callErr := n.initProc.Call(uintptr(unsafe.Pointer(rootPtr)))
	if int32(result) != 0 {
		return fmt.Errorf("ma_bridge_init returned %d (%v)", int32(result), callErr)
	}
	return nil
}

func (n *nativeBGM) play(path string, loop bool, volume, fade float32) error {
	pathPtr, err := syscall.UTF16PtrFromString(path)
	if err != nil {
		return err
	}
	loopValue := uintptr(0)
	if loop {
		loopValue = 1
	}
	result, _, callErr := n.playProc.Call(
		uintptr(unsafe.Pointer(pathPtr)), loopValue,
		uintptr(math.Float32bits(volume)), uintptr(math.Float32bits(fade)),
	)
	if int32(result) != 0 {
		return fmt.Errorf("ma_bridge_bgm_play returned %d (%v)", int32(result), callErr)
	}
	return nil
}

func (n *nativeBGM) stop(fade float32) error {
	result, _, callErr := n.stopProc.Call(uintptr(math.Float32bits(fade)))
	if int32(result) != 0 {
		return fmt.Errorf("ma_bridge_bgm_stop returned %d (%v)", int32(result), callErr)
	}
	return nil
}

func (n *nativeBGM) setVolume(volume float32) {
	n.volumeProc.Call(uintptr(math.Float32bits(volume)))
}

func (n *nativeBGM) shutdown() {
	n.shutdownProc.Call()
}

func (n *nativeBGM) isPlaying() bool {
	result, _, _ := n.isPlayingProc.Call()
	return int32(result) != 0
}

func (n *nativeBGM) seek(seconds float32) error {
	result, _, callErr := n.seekProc.Call(uintptr(math.Float32bits(seconds)))
	if int32(result) != 0 {
		return fmt.Errorf("ma_bridge_bgm_seek returned %d (%v)", int32(result), callErr)
	}
	return nil
}

func (n *nativeBGM) pause() error {
	result, _, callErr := n.pauseProc.Call()
	if int32(result) != 0 {
		return fmt.Errorf("ma_bridge_bgm_pause returned %d (%v)", int32(result), callErr)
	}
	return nil
}

func (n *nativeBGM) resume() error {
	result, _, callErr := n.resumeProc.Call()
	if int32(result) != 0 {
		return fmt.Errorf("ma_bridge_bgm_resume returned %d (%v)", int32(result), callErr)
	}
	return nil
}
