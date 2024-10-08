FROM steamcmd/steamcmd:ubuntu-18
# steamcmd doesnt work properly on ubuntu 20 due to misssing 32 bit deps

ENV DEBIAN_FRONTEND=noninteractive

# install deps
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y \
        lib32gcc1 \
        libcap-dev \
        libcurl4 \
        libcurl4-openssl-dev \
    && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# steam cmd and directory conf
ENV USER dayz
ENV BASE_DIR /dayz
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=770
ENV HOME ${BASE_DIR}/home
ENV SERVER_DIR ${BASE_DIR}/server
ENV STEAM_CMD_USER anonymous
ENV STEAM_CMD_PASSWORD=""

RUN mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d ${HOME} -s /bin/bash $USER && \
	chown -R $USER ${BASE_DIR} && \
	ulimit -n 2048

# game
EXPOSE 2302/udp
EXPOSE 2303/udp
EXPOSE 2304/udp
EXPOSE 2305/udp
# steam
EXPOSE 8766/udp
EXPOSE 27016/udp
# rcon (preferred)
EXPOSE 2310

WORKDIR ${BASE_DIR}
VOLUME ${BASE_DIR}

# currently linux server is experimental only
ENV APP_ID="1042420"

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
