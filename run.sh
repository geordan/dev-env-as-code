#!/usr/bin/env bash

set -eu

echo ""
echo "Run '. ./setup.sh && source .bashrc'"
echo ""

docker run \
  -v '/Users/geordan/code/geordan/dotfiles:/dotfiles' \
  -v '/Users/geordan/code:/home/dev/code' \
  -it geodev:0.0.1 /bin/bash
