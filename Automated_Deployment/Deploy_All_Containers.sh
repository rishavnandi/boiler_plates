#!/bin/bash
#    _____             _               _    _                      _           _       ____        _ _                 _       _            
#   |  __ \           | |             | |  | |                    | |         | |     |  _ \      (_) |               | |     | |           
#   | |  | | ___   ___| | _____ _ __  | |__| | ___  _ __ ___   ___| |     __ _| |__   | |_) | ___  _| | ___ _ __ _ __ | | __ _| |_ ___  ___ 
#   | |  | |/ _ \ / __| |/ / _ \ '__| |  __  |/ _ \| '_ ` _ \ / _ \ |    / _` | '_ \  |  _ < / _ \| | |/ _ \ '__| '_ \| |/ _` | __/ _ \/ __|
#   | |__| | (_) | (__|   <  __/ |    | |  | | (_) | | | | | |  __/ |___| (_| | |_) | | |_) | (_) | | |  __/ |  | |_) | | (_| | ||  __/\__ \
#   |_____/ \___/ \___|_|\_\___|_|    |_|  |_|\___/|_| |_| |_|\___|______\__,_|_.__/  |____/ \___/|_|_|\___|_|  | .__/|_|\__,_|\__\___||___/
#                                                                                                               | |                         
#                                                                                                               |_|                         
# https://github.com/rishavnandi/Boiler_Plates.git

echo "------------------------Enter Username------------------------"
read name
cd /home/$name && cd docker_apps
echo "------------------------Deploying Containers------------------------"

docker_apps=(
    "file_browser" 
    "heimdall" 
    "jellyfin"
    "monitoring" 
    "qbittorrent" 
    "radarr" 
    "sonarr" 
    "unmanic" 
    "uptime_kuma" 
    "wireguard" 
    "prowlarr" 
    "guacamole" 
    "nginx" 
    "portainer" 
    "vaultwarden"
    "code_server"
    "duplicati"
    "jellyseerr"
    "watchtower"
)

for app in ${docker_apps}[@]; do
    cd $app
    docker compose up -d --force-recreate
    cd ..
done
