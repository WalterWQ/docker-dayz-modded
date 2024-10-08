#!/bin/bash


function updateGame() {
    steamcmd \
        +login ${USERNAME} ${PASSWRD} \
        +force_install_dir ${SERVER_DIR} \
        +app_update ${GAME_ID} \
        +quit
}

function startGame() {
    cd ${SERVER_DIR}
    ./DayZServer \
        -config="serverDZ.cfg" 
}
