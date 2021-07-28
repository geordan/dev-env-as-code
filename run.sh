#!/usr/bin/env bash

set -eux

. env.sh

# echo ""
# echo "Run './setup.sh && source .bashrc'"
# echo ""

docker run \
  -v '/Users/geordan/code/geordan/dotfiles:/dotfiles' \
  -v '/Users/geordan/code:/home/dev/code' \
  -it "${IMAGE_NAME}":"${IMAGE_TAG}" bash
