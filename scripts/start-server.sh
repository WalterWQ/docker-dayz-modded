#!/bin/bash

if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
    echo "SteamCMD not found!"
    wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
    tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
    rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi

echo "---Update SteamCMD---"
if [ "${USERNAME}" == "" ]; then
    ${STEAMCMD_DIR}/steamcmd.sh +login anonymous +quit
else
    ${STEAMCMD_DIR}/steamcmd.sh +login ${USERNAME} ${PASSWRD} +quit
fi

echo "---Update Server---"
if [ "${USERNAME}" == "" ]; then
    if [ "${VALIDATE}" == "true" ]; then
        echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh +force_install_dir ${SERVER_DIR} +login ${USERNAME} ${PASSWRD} +app_update ${GAME_ID} validate +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh +force_install_dir ${SERVER_DIR} +login ${USERNAME} ${PASSWRD} +app_update ${GAME_ID} +quit
    fi
else
    if [ "${VALIDATE}" == "true" ]; then
        echo "---Validating installation---"
        ${STEAMCMD_DIR}/steamcmd.sh +force_install_dir ${SERVER_DIR} +login ${USERNAME} ${PASSWRD} +app_update ${GAME_ID} validate +quit
    else
        ${STEAMCMD_DIR}/steamcmd.sh +force_install_dir ${SERVER_DIR} +login ${USERNAME} ${PASSWRD} +app_update ${GAME_ID} +quit
    fi
fi

echo "---Download Mods---"
# Check if MODS is not empty (from the environment)
if [ -z "${MODS}" ]; then
    echo "No mods specified. Skipping mod download."
else
    MOD_CMDS=""
    MODS_ARRAY=(${MODS//;/ }) # Split MODS env variable by semicolons into an array
    for MOD in "${MODS_ARRAY[@]}"; do
        MOD_CMDS+="+workshop_download_item ${GAME_ID} $MOD "
    done
    # Run SteamCMD once to download all mods
    ${STEAMCMD_DIR}/steamcmd.sh +force_install_dir ${SERVER_DIR} +login ${USERNAME} ${PASSWRD} ${MOD_CMDS} +quit
fi

echo "---Prepare Server---"
if [ ! -f ${DATA_DIR}/.steam/sdk32/steamclient.so ]; then
    if [ ! -d ${DATA_DIR}/.steam ]; then
        mkdir ${DATA_DIR}/.steam
    fi
    if [ ! -d ${DATA_DIR}/.steam/sdk32 ]; then
        mkdir ${DATA_DIR}/.steam/sdk32
    fi
    cp -R ${STEAMCMD_DIR}/linux32/* ${DATA_DIR}/.steam/sdk32/
fi
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
if [ -z "${MODS}" ]; then
    # Prepare and start the DayZ server
    echo "---Starting DayZ Server With Mods---"
    cd ${SERVER_DIR}
    ./DayZServer \
    -config="serverDZ.cfg" \
    -port=${GAME_PORT} \
    -BEpath=battleye \
    -profiles=profiles \
    -freezecheck \
    -mod=${MOD_LIST}
    
    echo "---Server Started---"
else
    # Prepare and start the DayZ server
    echo "---Starting DayZ Server With Mods---"
    cd ${SERVER_DIR}
    ./DayZServer \
    -config="serverDZ.cfg" \
    -port=${GAME_PORT} \
    -BEpath=battleye \
    -profiles=profiles \
    -freezecheck 
    
    echo "---Server Started---"
fi
