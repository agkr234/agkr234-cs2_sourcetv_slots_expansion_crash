#!/bin/bash

gameport=$1
if [ -z "$1" ]; then
  read -p "Enter CS2 game port number: " gameport
fi

if ((gameport > 65535 || gameport < 1)); then
  echo Error: game port should be between 1 and 65535.
  exit 1
fi

docker run -it --name cs2-sniper --rm -p $gameport:$gameport/udp cs2-sniper:latest -dedicated -port $gameport -maxplayers 10 -console -usercon +game_type 0 +game_mode 1 +map de_inferno +exec server.cfg
