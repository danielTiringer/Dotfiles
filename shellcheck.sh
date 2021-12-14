#!/bin/sh

docker run --rm -w /app -v /home/daniel/Dotfiles:/app koalaman/shellcheck /app/"$1"
