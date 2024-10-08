#!/bin/bash

# Prepare and start the DayZ server
echo "---Starting DayZ Server---"
cd ${SERVER_DIR}
./DayZServer \
-config="serverDZ.cfg"

echo "---Server Started---"
