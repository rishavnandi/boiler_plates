#!/bin/bash

apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sleep 5

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sleep 5

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

sleep 5

apt-get install docker-ce docker-ce-cli containerd.io -y
