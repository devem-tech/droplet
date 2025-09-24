#!/bin/bash

cd /opt/compose

. ~/.bash_prompt

di() {
  docker images "$@" | docker-color-output -c ~/.config/docker-color-output/config.json
}

dps() {
  docker ps --format "table {{.Names}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}" "$@" | docker-color-output -c ~/.config/docker-color-output/config.json
}

dcps() {
  docker compose ps "$@" | docker-color-output -c ~/.config/docker-color-output/config.json
}

alias h='cd /opt/compose'
alias upgrade='apt update && apt upgrade -y && apt autoremove -y && apt clean'
alias docker-cleanup='docker system prune -f --volumes && docker images -f "dangling=true" -q | xargs -r docker rmi -f'
alias fs='df -h | egrep '\''^/dev/.da'\'' | egrep '\''/$'\'' | awk '\''{ print "Available: \033[32m" $4 "\033[0m \033[33m(" 100-$5 "%)\033[0m \033[30m" $3 "/" $2 " " $1 "\033[0m" }'\'''
