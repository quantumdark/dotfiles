#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

mkdir -p ~/.fonts

curl -#L "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/LiberationMono/additional-variations/Literation%20Mono%20Powerline%20Nerd%20Font%20Plus%20Font%20Awesome%20Plus%20Octicons%20Plus%20Pomicons%20Mono.ttf" -o ~/.fonts/LiterationMonoPlusIcons.ttf

fc-cache -vf ~/.fonts/
