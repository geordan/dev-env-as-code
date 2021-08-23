#!/usr/bin/env bash
# Install neovim/nvim

set -eux

curl --location --remote-name https://github.com/neovim/neovim/releases/download/v0.5.0/nvim-linux64.tar.gz

tar xvzf nvim-linux64.tar.gz

mv nvim-linux64/bin/nvim /usr/local/bin

export PATH='/opt/nvim/bin:$PATH'

