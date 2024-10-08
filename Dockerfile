FROM ich777/debian-baseimage:bullseye_amd64

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-steamcmd-server"

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends lib32gcc-s1 lib32stdc++6 lib32z1 libcap2 libcap2-bin libc6:i386 && \
    rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="serverdata/"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV GAME_NAME="template"
ENV GAME_PARAMS="template"
ENV GAME_PORT=2302
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV MODS=""
ENV USER="steam"
ENV DATA_PERM=770

RUN mkdir -p $DATA_DIR $STEAMCMD_DIR $SERVER_DIR && \
    useradd -d $DATA_DIR -s /bin/bash $USER && \
    chown -R $USER $DATA_DIR && \
    ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

# Set entrypoint
ENTRYPOINT ["/opt/scripts/start.sh"]
