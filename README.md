# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD and the according game that is pulled via specifying the Tag.

**Please see the different Tags/Branches which games are available.**

## Example Env params for DayZ Stable Branch
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '232330 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 232330 |
| GAME_NAME | SRCDS gamename | dayz |
| MODS | Mod SteamIDS  | 23563563565;54546457856;548765744 |
| GAME_PARAMS | Values to start the server | -profiles dayzProfiles |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| GAME_PORT | Port the server will be running on | 27015 |
| VALIDATE | Validates the game data | blank |
| USERNAME | MUST BE FILLED WITH CREDIENTALS FROM A NON STEAM GUARD PROFILE WITH DAYZ | blank |
| PASSWRD | MUST BE FILLED WITH CREDIENTALS FROM A NON STEAM GUARD PROFILE WITH DAYZ | blank |


This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

This Docker is forked from mattieserver, thank you for this wonderfull Docker.

