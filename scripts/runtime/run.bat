@echo off
rem Runtime-only dispatcher shipped with player releases.
setlocal EnableExtensions
set "COMMAND=%~1"
if /i "%COMMAND%"=="game" goto game
if /i "%COMMAND%"=="debug" goto debug
if /i "%COMMAND%"=="modifier" goto modifier
if /i "%COMMAND%"=="check-game" goto check_game
if /i "%COMMAND%"=="check-debug" goto check_debug
if /i "%COMMAND%"=="check-modifier" goto check_modifier
if /i "%COMMAND%"=="smoke-game" goto smoke_game
if /i "%COMMAND%"=="smoke-modifier" goto smoke_modifier
echo Usage: scripts\runtime\run.bat [game^|debug^|modifier^|check-game^|check-debug^|check-modifier^|smoke-game^|smoke-modifier]
exit /b 64

:game
call "%~dp0launch_game.bat" sa
exit /b %ERRORLEVEL%
:debug
call "%~dp0launch_game.bat" sa_debug
exit /b %ERRORLEVEL%
:modifier
call "%~dp0launch_modifier.bat"
exit /b %ERRORLEVEL%
:check_game
call "%~dp0launch_game.bat" --check sa
exit /b %ERRORLEVEL%
:check_debug
call "%~dp0launch_game.bat" --check sa_debug
exit /b %ERRORLEVEL%
:check_modifier
call "%~dp0launch_modifier.bat" --check
exit /b %ERRORLEVEL%
:smoke_game
call "%~dp0launch_game.bat" --smoke sa
exit /b %ERRORLEVEL%
:smoke_modifier
call "%~dp0launch_modifier.bat" --smoke
exit /b %ERRORLEVEL%
