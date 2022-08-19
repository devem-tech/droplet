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

docker_compose_latest_version() {
  curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

# Go
log "bash-prompt"
curl -s $FS/root/.bash_aliases -o $HOME/.bash_aliases && \
  curl -s $FS/root/.bash_prompt -o $HOME/.bash_prompt ||
  exit 1

log "docker"
apt update && \
  apt install -y \
    curl \
    htop \
    gnupg \
    lsb-release \
    ca-certificates && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt update && \
  DEBIAN_FRONTEND=noninteractive apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin ||
  exit 1

log "docker-color-output"
gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/docker-color-output-keyring.gpg --keyserver keyserver.ubuntu.com --recv CAB3412463E1567A && \
  chmod 644 /usr/share/keyrings/docker-color-output-keyring.gpg && \
  rm -f /usr/share/keyrings/docker-color-output-keyring.gpg~ && \
  echo "deb [signed-by=/usr/share/keyrings/docker-color-output-keyring.gpg] https://ppa.launchpadcontent.net/dldash/core/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/docker-color-output.list && \
  apt update && \
  apt install -y docker-color-output && \
  apt update && apt upgrade -y && apt autoremove -y && apt clean ||
  exit 1

finished
