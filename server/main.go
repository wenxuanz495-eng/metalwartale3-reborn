package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"os/signal"
	"path/filepath"
	"syscall"
	"time"
)

func main() {
	host := flag.String("host", "127.0.0.1", "listen host")
	port := flag.Int("port", 8765, "listen port")
	exportOnly := flag.Bool("export-only", false, "export latest SOL and exit")
	fixZeroCarAffixOnce := flag.Bool("fix-zero-car-affix-once", false, "one-time fix for cars whose random affix values are all zero")
	rootFlag := flag.String("root", "", "static root; defaults to server.exe directory")
	flag.Parse()

	root, err := resolveRoot(*rootFlag)
	if err != nil {
		log.Fatal(err)
	}
	store := newSaveStore(root)
	if err := store.init(); err != nil {
		log.Fatal(err)
	}
	if *exportOnly {
		result, err := store.exportSOL(true)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf("%v\n", result)
		return
	}
	if *fixZeroCarAffixOnce {
		if err := runFixZeroCarAffixOnce(root); err != nil {
			log.Fatal(err)
		}
		return
	}
	if _, err := os.Stat(filepath.Join(root, "game.swf")); err != nil {
		log.Fatalf("game.swf missing in %s", root)
	}

	application := &app{root: root, store: store}
	server := &http.Server{
		Addr:              net.JoinHostPort(*host, fmt.Sprint(*port)),
		Handler:           logRequest(application.routes()),
		ReadHeaderTimeout: 10 * time.Second,
	}
	errs := make(chan error, 1)
	go func() {
		fmt.Println("============================================================")
		fmt.Println("  Metal War Tale offline server")
		fmt.Printf("  Static root : %s\n", root)
		fmt.Printf("  Game URL    : %s\n", gameURL(*host, *port))
		fmt.Printf("  Saves       : %s\n", store.saves)
		fmt.Println("============================================================")
		errs <- server.ListenAndServe()
	}()

	signals := make(chan os.Signal, 1)
	signal.Notify(signals, os.Interrupt, syscall.SIGTERM)
	select {
	case sig := <-signals:
		log.Printf("received %s", sig)
	case err := <-errs:
		if err != nil && err != http.ErrServerClosed {
			log.Fatal(err)
		}
	}
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	_ = server.Shutdown(ctx)
}

func resolveRoot(explicit string) (string, error) {
	if explicit != "" {
		return filepath.Abs(explicit)
	}
	exe, err := os.Executable()
	if err == nil {
		dir := filepath.Dir(exe)
		if _, statErr := os.Stat(filepath.Join(dir, "game.swf")); statErr == nil {
			return dir, nil
		}
	}
	return os.Getwd()
}