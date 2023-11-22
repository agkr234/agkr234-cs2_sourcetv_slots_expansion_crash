@echo off
cd /d "%~dp0"

docker build --secret id=credentials,src=.\.credentials -t cs2-sniper:latest .

pause