package main

import (
	"encoding/binary"
	"os"
	"path/filepath"
	"strings"
	"time"
)

func mediaDuration(path string) time.Duration {
	data, err := os.ReadFile(path)
	if err != nil {
		return 0
	}
	switch strings.ToLower(filepath.Ext(path)) {
	case ".flac":
		return flacDuration(data)
	case ".mp3":
		return mp3Duration(data)
	case ".wav":
		return wavDuration(data)
	}
	return 0
}

func flacDuration(data []byte) time.Duration {
	if len(data) < 42 || string(data[:4]) != "fLaC" || data[4]&0x7f != 0 {
		return 0
	}
	stream := data[8:42]
	sampleRate := uint64(stream[10])<<12 | uint64(stream[11])<<4 | uint64(stream[12])>>4
	totalSamples := uint64(stream[13]&0x0f)<<32 | uint64(stream[14])<<24 | uint64(stream[15])<<16 | uint64(stream[16])<<8 | uint64(stream[17])
	if sampleRate == 0 {
		return 0
	}
	return time.Duration(float64(totalSamples) / float64(sampleRate) * float64(time.Second))
}

func mp3Duration(data []byte) time.Duration {
	offset := 0
	if len(data) >= 10 && string(data[:3]) == "ID3" {
		offset = 10 + int(data[6]&0x7f)<<21 + int(data[7]&0x7f)<<14 + int(data[8]&0x7f)<<7 + int(data[9]&0x7f)
	}
	bitrates := [...]int{0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 0}
	for i := offset; i+4 <= len(data); i++ {
		header := binary.BigEndian.Uint32(data[i : i+4])
		if header&0xffe00000 != 0xffe00000 || (header>>17)&3 != 1 {
			continue
		}
		bitrate := bitrates[(header>>12)&0x0f]
		if bitrate == 0 {
			continue
		}
		return time.Duration(float64(len(data)-i) * 8 / float64(bitrate*1000) * float64(time.Second))
	}
	return 0
}

func wavDuration(data []byte) time.Duration {
	if len(data) < 44 || string(data[:4]) != "RIFF" || string(data[8:12]) != "WAVE" {
		return 0
	}
	byteRate := binary.LittleEndian.Uint32(data[28:32])
	dataSize := binary.LittleEndian.Uint32(data[40:44])
	if byteRate == 0 {
		return 0
	}
	return time.Duration(float64(dataSize) / float64(byteRate) * float64(time.Second))
}
