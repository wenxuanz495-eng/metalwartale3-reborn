//go:build !windows

package main

import "errors"

type nativeBGM struct{}

func (n *nativeBGM) init(dllPath, root string) error {
	return errors.New("external BGM requires Windows")
}
func (n *nativeBGM) play(path string, loop bool, volume, fade float32) error {
	return errors.New("external BGM requires Windows")
}
func (n *nativeBGM) stop(fade float32) error  { return errors.New("external BGM requires Windows") }
func (n *nativeBGM) setVolume(volume float32) {}
func (n *nativeBGM) shutdown()                {}
func (n *nativeBGM) isPlaying() bool          { return false }
