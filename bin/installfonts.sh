#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

mkdir -p ~/.fonts

curl -#L "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/LiberationMono/complete/Literation%20Mono%20Powerline%20Nerd%20Font%20Complete%20Mono.ttf?raw=true" -o ~/.fonts/LiterationMonoPowerlineNerd.ttf

fc-cache -vf ~/.fonts/
