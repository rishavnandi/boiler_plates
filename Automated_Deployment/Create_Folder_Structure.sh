#!/bin/bash

cd /home/ubuntu/

echo "Enter Your PUID"
read PUID
echo "Enter Your PGID"
read PGID
echo "Enter Your Timezone"
read TZ
echo "Enter IP Address of your server"
read IP

echo "------------------------Creating Folder Structure------------------------"
mkdir data
mkdir docker_apps
mkdir data/torrents
mkdir data/media
mkdir data/torrents/movies
mkdir data/torrents/tv
mkdir data/media/movies
mkdir data/media/tv

mkdir docker_apps/bazarr
mkdir docker_apps/file_browser
mkdir docker_apps/heimdall
mkdir docker_apps/jackett
mkdir docker_apps/jellyfin
mkdir docker_apps/monitoring
mkdir docker_apps/nginx
mkdir docker_apps/overseerr
mkdir docker_apps/qbittorrent
mkdir docker_apps/radarr
mkdir docker_apps/sonarr
mkdir docker_apps/unmanic
mkdir docker_apps/uptime_kuma
mkdir docker_apps/wireguard
mkdir docker_apps/prowlarr
mkdir docker_apps/readarr
mkdir docker_apps/guacamole
mkdir docker_apps/ubooquity
mkdir docker_apps/portainer
mkdir docker_apps/vaultwarden
mkdir /etc/prometheus/

echo "------------------------Folder Structure Created------------------------"
echo "------------------------Creating Docker Compose Files------------------------"
touch docker_apps/bazarr/docker-compose.yml
touch docker_apps/file_browser/docker-compose.yml
touch docker_apps/file_browser/filebrowser.db
touch docker_apps/heimdall/docker-compose.yml
touch docker_apps/jackett/docker-compose.yml
touch docker_apps/jellyfin/docker-compose.yml
touch docker_apps/monitoring/docker-compose.yml
touch docker_apps/nginx/docker-compose.yml
touch docker_apps/qbittorrent/docker-compose.yml
touch docker_apps/radarr/docker-compose.yml
touch docker_apps/sonarr/docker-compose.yml
touch docker_apps/unmanic/docker-compose.yml
touch docker_apps/uptime_kuma/docker-compose.yml
touch docker_apps/wireguard/docker-compose.yml
touch docker_apps/prowlarr/docker-compose.yml
touch docker_apps/readarr/docker-compose.yml
touch docker_apps/guacamole/docker-compose.yml
touch docker_apps/overseerr/docker-compose.yml
touch docker_apps/ubooquity/docker-compose.yml
touch docker_apps/vaultwarden/docker-compose.yml
touch /etc/prometheus/prometheus.yml

echo "------------------------Docker Compose Files Created------------------------"
echo "------------------------Creating Docker Network------------------------"
docker network create homelab
echo "------------------------Docker Network Created------------------------"

echo "------------------------Setting up Docker Compose Files------------------------"
echo "global:
  scrape_interval:     15s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['node_exporter:9100']

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']" >> /etc/prometheus/prometheus.yml

echo "version: '2.1'
services:
  bazarr:
    image: lscr.io/linuxserver/bazarr
    container_name: bazarr
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
    volumes:
      - /home/ubuntu/docker_apps/bazarr/config:/config
      - /home/ubuntu/data/:/data
    #ports:
    #  - 6767:6767
    restart: unless-stopped

networks:
  default:
    external:
      name: homelab" >> docker_apps/bazarr/docker-compose.yml

echo "version: '3'
services:
  file-browser:
    image: filebrowser/filebrowser
    container_name: file_browser
    user: $PUID:$PGID
    ports:
      - 8081:80
    volumes:
      - /home/ubuntu/:/srv/
      - /home/ubuntu/docker_apps/file_browser/filebrowser.db:/database.db
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true" >> docker_apps/file_browser/docker-compose.yml

echo "version: '2.1'
services:
  heimdall:
    image: lscr.io/linuxserver/heimdall
    container_name: heimdall
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
    volumes:
      - /home/ubuntu/docker_apps/heimdall/config/:/config
    #ports:
    #  - 80:80
    #  - 443:443
    restart: unless-stopped

networks:
  default:
    external:
      name: homelab" >> docker_apps/heimdall/docker-compose.yml

echo "version: '2.1'
services:
  jellyfin:
    image: lscr.io/linuxserver/jellyfin
    container_name: jellyfin
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
      - JELLYFIN_PublishedServerUrl=$IP #optional
    volumes:
      - /home/ubuntu/docker_apps/jellyfin/config/:/config
      - /home/ubuntu/data/media/:/data/media
    #ports:
    #  - 8096:8096
    #  - 8920:8920 #optional
    #  - 7359:7359/udp #optional
    #  - 1900:1900/udp #optional
    restart: unless-stopped
    
networks:
  default:
    external:
      name: homelab" >> docker_apps/jellyfin/docker-compose.yml

echo "version: '3'

volumes:
  prometheus-data:
    driver: local
  grafana-data:
    driver: local

services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    #ports:
    #  - "9090:9090"
    volumes:
      - /etc/prometheus:/etc/prometheus
      - prometheus-data:/prometheus
    restart: unless-stopped
    command:
      - "--config.file=/etc/prometheus/prometheus.yml"

  node_exporter:
    image: quay.io/prometheus/node-exporter:latest
    container_name: node_exporter
    command:
      - '--path.rootfs=/host'
    pid: host
    restart: unless-stopped
    volumes:
      - '/:/host:ro,rslave'

  cadvisor:
    image: budry/cadvisor-arm:latest
    container_name: cadvisor
    # ports:
    #   - "8080:8080"
    volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:ro
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
      - /dev/disk/:/dev/disk:ro
    devices:
      - /dev/kmsg
    restart: unless-stopped

  grafana:
    image: grafana/grafana-oss:latest
    container_name: grafana
    #ports:
    #  - "3000:3000"
    volumes:
      - grafana-data:/var/lib/grafana
    restart: unless-stopped
    
networks:
  default:
    external:
      name: homelab" >> docker_apps/monitoring/docker-compose.yml

echo "version: '3'
services:
  app:
    image: 'jc21/nginx-proxy-manager:latest'
    restart: unless-stopped
    ports:
      # These ports are in format <host-port>:<container-port>
      - '80:80' # Public HTTP Port
      - '443:443' # Public HTTPS Port
      - '81:81' # Admin Web Port
      # Add any other Stream port you want to expose
      # - '21:21' # FTP

    # Uncomment the next line if you uncomment anything in the section
    # environment:
      # Uncomment this if you want to change the location of
      # the SQLite DB file within the container
      # DB_SQLITE_FILE: "/data/database.sqlite"

      # Uncomment this if IPv6 is not enabled on your host
      # DISABLE_IPV6: 'true'

    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
      
networks:
  default:
    external:
      name: homelab" >> docker_apps/nginx/docker-compose.yml

echo "version: '2.1'
services:
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent
    container_name: qbittorrent
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
      - WEBUI_PORT=8080
    volumes:
      - /home/ubuntu/docker_apps/qbittorrent/config:/config
      - /home/ubuntu/data/torrents/:/data/torrents/
      - /home/ubuntu/docker_apps/qbittorrent/vuetorrent:/vuetorrent
    ports:
      - 8080:8080
      - 6881:6881
      - 6881:6881/udp
    restart: unless-stopped" >> docker_apps/qbittorrent/docker-compose.yml

echo "version: '2.1'
services:
  radarr:
    image: lscr.io/linuxserver/radarr
    container_name: radarr
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
    volumes:
      - /home/ubuntu/docker_apps/radarr/config/:/config
      - /home/ubuntu/data/:/data #optional
    #ports:
    #  - 7878:7878
    restart: unless-stopped
    
networks:
  default:
    external:
      name: homelab" >> docker_apps/radarr/docker-compose.yml

echo "version: '2.1'
services:
  sonarr:
    image: lscr.io/linuxserver/sonarr
    container_name: sonarr
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
    volumes:
      - /home/ubuntu/docker_apps/sonarr/config/:/config
      - /home/ubuntu/data/:/data
    #ports:
    #  - 8989:8989
    restart: unless-stopped
    
networks:
  default:
    external:
      name: homelab" >> docker_apps/sonarr/docker-compose.yml

echo "version: '2.4'
services:
  unmanic:
    container_name: unmanic
    image: josh5/unmanic:latest
    #ports:
    #  - 8888:8888
    environment:
      - PUID=$PUID
      - PGID=$PGID
    volumes:
      - /home/ubuntu/docker_apps/unmanic/config/:/config
      - /home/ubuntu/data/media/movies/:/library/movies
      - /home/ubuntu/data/media/tv/:/library/tv
      - /tmp/:/tmp/unmanic
    restart: unless-stopped
    
networks:
  default:
    external:
      name: homelab" >> docker_apps/unmanic/docker-compose.yml

echo "version: '3.1'
services:
  uptime-kuma:
    image: louislam/uptime-kuma:1
    container_name: uptime_kuma
    volumes:
      - /home/ubuntu/docker_apps/uptime_kuma/data:/app/data
    #ports:
    #  - 3001:3001
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
      
networks:
  default:
    external:
      name: homelab" >> docker_apps/uptime_kuma/docker-compose.yml

echo "version: '2.1'
services:
  wireguard:
    image: lscr.io/linuxserver/wireguard
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
      - SERVERURL=$IP #optional
      - SERVERPORT=51820 #optional
      - PEERS=1 #optional
      - PEERDNS=auto #optional
      - INTERNAL_SUBNET=10.13.13.0 #optional
      - ALLOWEDIPS=0.0.0.0/0 #optional
    volumes:
      - /home/ubuntu/docker_apps/wireguard/config:/config
      - /lib/modules:/lib/modules
    ports:
      - 51820:51820/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped" >> docker_apps/wireguard/docker-compose.yml

echo "version: '2.1'
services:
  prowlarr:
    image: lscr.io/linuxserver/prowlarr:develop
    container_name: prowlarr
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=$TZ
    volumes:
      - /home/ubuntu/docker_apps/prowlarr/config/:/config
    #ports:
    #  - 9696:9696
    restart: unless-stopped
    
networks:
  default:
    external:
      name: homelab" >> docker_apps/prowlarr/docker-compose.yml

echo "version: '2'
services:
  guacamole:
    image: oznu/guacamole:armhf
    container_name: guacamole
    volumes:
      - /home/docker_apps/guacamole/config/:/config
    ports:
      - 9000:8080
    restart: unless-stopped" >> docker_apps/guacamole/docker-compose.yml

echo "version: '3'
services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./portainer-data:/data
    ports:
      - 9443:9443" >> docker_apps/portainer/docker-compose.yml

echo "version: '3'

services:
  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    restart: unless-stopped
    volumes:
      - ./vw-data:/data" >> docker_apps/vaultwarden/docker-compose.yml

echo "------------------------Docker Compose Files Setup Complete------------------------"
echo "------------------------Adding Required Permissions to Folders------------------------"
chown -R ubuntu:ubuntu data/
chmod -R 775 data/
chown -R ubuntu:ubuntu docker_apps/
chmod -R 775 docker_apps/
echo "------------------------Permissions Added------------------------"
echo "------------------------Setup Complete Now Run Deploy.sh without sudo to Deploy the Containers------------------------"