package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"syscall"
	"time"
	"unsafe"
)

const (
	launcherTitle = "超合金战记启动器"
	firstPort     = 52000
	lastPort      = 63999
)

type serverStatus struct {
	Backend  string `json:"backend"`
	Instance string `json:"instance"`
}

func main() {
	if err := run(); err != nil {
		messageBox(launcherTitle, "游戏启动失败：\n\n"+err.Error(), 0x10)
		os.Exit(1)
	}
}

func run() error {
	root, err := executableDir()
	if err != nil {
		return err
	}

	serverPath := filepath.Join(root, "build", "server.exe")
	playerPath := filepath.Join(root, "tools", "runtime", "FlashPlayer.exe")
	gamePath := filepath.Join(root, "build", "game.swf")
	resourcePath := filepath.Join(root, "build", "swf")
	for _, path := range []string{serverPath, playerPath, gamePath, resourcePath} {
		if _, err := os.Stat(path); err != nil {
			return fmt.Errorf("缺少必要文件：%s", path)
		}
	}
	if err := prepareSave(root); err != nil {
		return err
	}

	port, err := freePort()
	if err != nil {
		return err
	}
	instance := strconv.FormatInt(time.Now().UnixNano(), 10)
	server := exec.Command(serverPath,
		"-host", "127.0.0.1",
		"-port", strconv.Itoa(port),
		"-root", filepath.Join(root, "build"),
		"-instance", instance,
	)
	server.Dir = root
	server.SysProcAttr = &syscall.SysProcAttr{HideWindow: true}
	if err := server.Start(); err != nil {
		return fmt.Errorf("无法启动本地存档服务：%w", err)
	}
	defer stopProcess(server)

	if err := waitForServer(port, instance, server); err != nil {
		return err
	}
	gameURL := fmt.Sprintf("http://127.0.0.1:%d/game.swf?localrun=%d", port, time.Now().UnixNano())
	player := exec.Command(playerPath, gameURL)
	player.Dir = root
	if err := player.Start(); err != nil {
		return fmt.Errorf("无法启动 FlashPlayer：%w", err)
	}
	if err := player.Wait(); err != nil {
		var exitErr *exec.ExitError
		if !errors.As(err, &exitErr) {
			return fmt.Errorf("FlashPlayer 运行异常：%w", err)
		}
	}
	requestShutdown(port)
	waitForProcessExit(server, 3*time.Second)
	return nil
}

func requestShutdown(port int) {
	client := &http.Client{Timeout: 1500 * time.Millisecond}
	request, err := http.NewRequest(http.MethodPost, fmt.Sprintf("http://127.0.0.1:%d/api/shutdown", port), nil)
	if err != nil {
		return
	}
	response, err := client.Do(request)
	if err == nil && response.Body != nil {
		response.Body.Close()
	}
}

func waitForProcessExit(command *exec.Cmd, timeout time.Duration) {
	if command == nil || command.Process == nil {
		return
	}
	deadline := time.Now().Add(timeout)
	for time.Now().Before(deadline) {
		if command.ProcessState != nil && command.ProcessState.Exited() {
			return
		}
		if err := command.Process.Signal(syscall.Signal(0)); err != nil {
			return
		}
		time.Sleep(100 * time.Millisecond)
	}
}

func executableDir() (string, error) {
	path, err := os.Executable()
	if err != nil {
		return "", fmt.Errorf("无法确定启动器目录：%w", err)
	}
	path, err = filepath.EvalSymlinks(path)
	if err != nil {
		return "", fmt.Errorf("无法解析启动器目录：%w", err)
	}
	dir := filepath.Dir(path)
	// Accept both release packages (launcher at root) and repository builds
	// where the executable is kept in launcher/ or build/.
	for candidate := dir; ; candidate = filepath.Dir(candidate) {
		if fileExists(filepath.Join(candidate, "build", "server.exe")) &&
			fileExists(filepath.Join(candidate, "build", "game.swf")) &&
			fileExists(filepath.Join(candidate, "tools", "runtime", "FlashPlayer.exe")) {
			return candidate, nil
		}
		parent := filepath.Dir(candidate)
		if parent == candidate {
			break
		}
	}
	return dir, nil
}

func fileExists(path string) bool {
	info, err := os.Stat(path)
	return err == nil && !info.IsDir()
}

func prepareSave(root string) error {
	saves := filepath.Join(root, "build", "saves")
	if err := os.MkdirAll(filepath.Join(saves, "backups"), 0755); err != nil {
		return fmt.Errorf("无法创建存档目录：%w", err)
	}
	destination := filepath.Join(saves, "game_save.bin")
	if _, err := os.Stat(destination); err == nil {
		return nil
	} else if !os.IsNotExist(err) {
		return fmt.Errorf("无法检查存档：%w", err)
	}
	template := filepath.Join(root, "build", "swf", "empty-save-template.bin")
	source, err := os.Open(template)
	if err != nil {
		return fmt.Errorf("缺少初始存档模板：%w", err)
	}
	defer source.Close()
	target, err := os.OpenFile(destination, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0644)
	if err != nil {
		return fmt.Errorf("无法创建初始存档：%w", err)
	}
	if _, err := io.Copy(target, source); err != nil {
		target.Close()
		return fmt.Errorf("无法写入初始存档：%w", err)
	}
	return target.Close()
}

func freePort() (int, error) {
	start := firstPort + int(time.Now().UnixNano()%int64(lastPort-firstPort+1))
	for offset := 0; offset <= lastPort-firstPort; offset++ {
		port := firstPort + (start-firstPort+offset)%(lastPort-firstPort+1)
		listener, err := net.Listen("tcp4", "127.0.0.1:"+strconv.Itoa(port))
		if err == nil {
			listener.Close()
			return port, nil
		}
	}
	return 0, errors.New("没有找到可用的本地端口")
}

func waitForServer(port int, instance string, command *exec.Cmd) error {
	client := &http.Client{Timeout: time.Second}
	url := fmt.Sprintf("http://127.0.0.1:%d/api/status", port)
	for attempt := 0; attempt < 40; attempt++ {
		time.Sleep(250 * time.Millisecond)
		if command.ProcessState != nil && command.ProcessState.Exited() {
			return errors.New("本地存档服务意外退出")
		}
		response, err := client.Get(url)
		if err != nil {
			continue
		}
		var status serverStatus
		err = json.NewDecoder(response.Body).Decode(&status)
		response.Body.Close()
		if err == nil && status.Backend == "go" && status.Instance == instance {
			return nil
		}
	}
	return errors.New("本地存档服务启动超时")
}

func stopProcess(command *exec.Cmd) {
	if command == nil || command.Process == nil {
		return
	}
	_ = command.Process.Kill()
	_, _ = command.Process.Wait()
}

func messageBox(title, body string, flags uintptr) {
	user32 := syscall.NewLazyDLL("user32.dll")
	procedure := user32.NewProc("MessageBoxW")
	titlePtr, _ := syscall.UTF16PtrFromString(title)
	bodyPtr, _ := syscall.UTF16PtrFromString(body)
	_, _, _ = procedure.Call(0, uintptr(unsafe.Pointer(bodyPtr)), uintptr(unsafe.Pointer(titlePtr)), flags)
}
