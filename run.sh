#!/usr/bin/env bash
# docker run -v 'C:\Users\P1GXL02:/home/p1gxl02' -it geordandev:0.0.1 /bin/bash
docker run \
  -v '/Users/geordan/code/geordan/dotfiles:/dotfiles' \
  -v '/Users/geordan/code:/home/dev/code' \
  -it geodev:0.0.1 /bin/bash
