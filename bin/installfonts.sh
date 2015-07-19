#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

mkdir -p ~/.fonts

curl -#L "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/LiberationMono/Literation%20Mono%20Powerline%20Plus%20Nerd%20File%20Types%20Mono%20Plus%20Pomicons.ttf" -o ~/.fonts/LiterationMonoPlusIcons.ttf

fc-cache -vf ~/.fonts/
