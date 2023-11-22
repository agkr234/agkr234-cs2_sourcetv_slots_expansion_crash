@echo off
set gameport=%1
if "%gameport%"=="" set /p gameport="Enter CS2 game port number: "

if %gameport% GTR 65535 GOTO invalid_port_range
if %gameport% LSS 1 GOTO invalid_port_range

docker run -it --rm --name cs2-sniper -p %gameport%:%gameport%/udp cs2-sniper:latest -dedicated -port %gameport% -maxplayers 10 -console -usercon +game_type 0 +game_mode 1 +map de_inferno +exec server.cfg
pause
exit

:invalid_port_range
  echo Error: game port should be between 1 and 65535.
  pause
  exit 1
