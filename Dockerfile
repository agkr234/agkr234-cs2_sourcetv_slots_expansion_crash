FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install lib32gcc-s1 curl  \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m cs2

USER cs2

RUN mkdir -p $HOME/steamcmd \
    && cd $HOME/steamcmd \
    && curl -s https://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz

RUN --mount=type=secret,id=credentials,uid=1000 \
    eval "`tr -d "\r" < /run/secrets/credentials`" \
    && $HOME/steamcmd/steamcmd.sh +force_install_dir $HOME/server +login $STEAM_ID $STEAM_PWD +app_update 730 validate +quit 

RUN mkdir -p $HOME/.steam/sdk64/ $HOME/.steam/sdk32/ \
    && ln -s $HOME/steamcmd/linux64/steamclient.so $HOME/.steam/sdk64/steamclient.so \
    && ln -s $HOME/steamcmd/linux32/steamclient.so $HOME/.steam/sdk32/steamclient.so

RUN echo "" >> $HOME/server/game/csgo/cfg/gamemode_competitive.cfg \
    && echo "bot_quota 10" >> $HOME/server/game/csgo/cfg/gamemode_competitive.cfg \
    && echo "" >> $HOME/server/game/csgo/cfg/server.cfg \    
    && echo "sv_hibernate_when_empty 0" >> $HOME/server/game/csgo/cfg/server.cfg \
    && echo "tv_enable 1" >> $HOME/server/game/csgo/cfg/server.cfg \
    && echo "bot_join_after_player 0" >> $HOME/server/game/csgo/cfg/server.cfg


WORKDIR /home/cs2/server/game

ENTRYPOINT ["./cs2.sh"]

