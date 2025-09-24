#!/usr/bin/env bash

# docker run --rm -it -v $(pwd):/opt -w /opt -p 80:80 -p 443:443 --cap-add=NET_ADMIN --privileged ubuntu bash

# Const
NC="\033[0m"
CYAN="\033[1;36m"
GREEN="\033[1;32m"
WHITE="\033[1;37m"
FS="https://raw.githubusercontent.com/devem-tech/droplet/main/fs"

# Functions
log() {
  echo -e "${GREEN}==>${NC} ${WHITE}Installing${NC} ${GREEN}$1${NC}"
}

finished() {
  echo -e "🍺  ${CYAN}Done${NC}"
}

# Go
log "bash-prompt"
curl -s $FS/root/.bash_aliases -o $HOME/.bash_aliases && \
  curl -s $FS/root/.bash_prompt -o $HOME/.bash_prompt && \
  curl -s $FS/root/.config/docker-color-output/config.json -o $HOME/.config/docker-color-output/config.json ||
  exit 1

log "docker"
  curl -s https://get.docker.com | sh ||
  exit 1

log "docker-color-output"
curl -fsSL https://keyserver.ubuntu.com/pks/lookup?op=get\&search=0xcab3412463e1567a -o /etc/apt/keyrings/docker-color-output.asc && \
  chmod a+r /etc/apt/keyrings/docker-color-output.asc && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker-color-output.asc] https://ppa.launchpadcontent.net/dldash/core/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") main" | tee /etc/apt/sources.list.d/docker-color-output.list > /dev/null && \
  apt update && \
  apt install -y docker-color-output && \
  apt update && apt upgrade -y && apt autoremove -y && apt clean ||
  exit 1

finished
