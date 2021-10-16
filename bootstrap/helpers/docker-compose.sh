#!/bin/bash

SYSTEM_TYPE=$(uname -s)
SYSTEM_ARCH=$(uname -m)
COMPOSE_VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
COMPOSE_LOCATION=/usr/local/bin/docker-compose
sudo curl -L --fail https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-${SYSTEM_TYPE}-${SYSTEM_ARCH} -o $COMPOSE_LOCATION
sudo chmod +x $COMPOSE_LOCATION
