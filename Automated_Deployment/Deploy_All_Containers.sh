#!/bin/bash

docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest

docker run -d --name vaultwarden -v /vw-data/:/data/ vaultwarden/server:latest

cd docker_apps/

cd bazarr && docker compose up -d --force-recreate
cd .. && cd file_browser && docker compose up -d --force-recreate
cd .. && cd heimdall && docker compose up -d --force-recreate
cd .. && cd jackett && docker compose up -d --force-recreate
cd .. && cd jellyfin && docker compose up -d --force-recreate
cd .. && cd monitoring && docker compose up -d --force-recreate
cd .. && cd nginx && docker compose up -d --force-recreate
cd .. && cd openbooks && docker compose up -d --force-recreate
cd .. && cd qbittorrent && docker compose up -d --force-recreate
cd .. && cd radarr && docker compose up -d --force-recreate
cd .. && cd sonarr && docker compose up -d --force-recreate
cd .. && cd unmanic && docker compose up -d --force-recreate
cd .. && cd uptime_kuma && docker compose up -d --force-recreate
cd .. && cd wireguard && docker compose up -d --force-recreate
