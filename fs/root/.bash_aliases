#!/bin/bash

. ~/.bash_prompt

di() {
  docker images "$@" | docker-color-output
}

dps() {
  docker ps "$@" | docker-color-output
}

dcps() {
  docker compose ps "$@" | docker-color-output
}

alias h='cd /opt'
alias ll='ls -lh'
alias upgrade='apt update && apt upgrade -y && apt autoremove -y && apt clean'
alias docker-cleanup='docker system prune -f --volumes && docker images -f "dangling=true" -q | xargs -r docker rmi -f'
alias fs='df -h | egrep '\''^/dev/.da'\'' | egrep '\''/$'\'' | awk '\''{ print "Available: \033[32m" $4 "\033[0m \033[33m(" 100-$5 "%)\033[0m \033[30m" $3 "/" $2 " " $1 "\033[0m" }'\'''
