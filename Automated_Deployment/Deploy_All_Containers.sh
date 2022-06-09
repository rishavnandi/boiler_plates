#!/bin/bash

cd /home/ubuntu/

docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=unless-stopped \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest

docker run -d --name vaultwarden --restart=unless-stopped -v /vw-data/:/data/ vaultwarden/server:latest

cd docker_apps/

cd bazarr && docker compose up -d --force-recreate
cd .. && cd file_browser && docker compose up -d --force-recreate
cd .. && cd heimdall && docker compose up -d --force-recreate
cd .. && cd jackett && docker compose up -d --force-recreate
cd .. && cd jellyfin && docker compose up -d --force-recreate
cd .. && cd monitoring && docker compose up -d --force-recreate
cd .. && cd qbittorrent && docker compose up -d --force-recreate
cd .. && cd radarr && docker compose up -d --force-recreate
cd .. && cd sonarr && docker compose up -d --force-recreate
cd .. && cd unmanic && docker compose up -d --force-recreate
cd .. && cd uptime_kuma && docker compose up -d --force-recreate
cd .. && cd wireguard && docker compose up -d --force-recreate
cd .. && cd prowlarr && docker compose up -d --force-recreate
cd .. && cd readarr && docker compose up -d --force-recreate
cd .. && cd guacamole && docker compose up -d --force-recreate
cd .. && cd nginx && docker compose up -d --force-recreate
cd .. && cd overseer && docker compose up -d --force-recreate
cd .. && cd ubooquity && docker compose up -d --force-recreate
