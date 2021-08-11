#!/usr/bin/env python3

from config import *
from pathlib import Path
import subprocess


home = str(Path.home())

build_result = subprocess.run(["docker", "build", "-t", f'{IMAGE_NAME}:{IMAGE_TAG}', "."])

run_result = subprocess.run(["docker", "run", "-v", f'{home}/code/dotfiles:/dotfiles', "-v", f'{home}/code/:/root/code', "-it", f'{IMAGE_NAME}:{IMAGE_TAG}', "tmux"])

# docker run \
#   -v '/Users/geordan/code/dotfiles:/dotfiles' \
#   -v '/Users/geordan/code:/root/code' \
#   -it "${IMAGE_NAME}":"${IMAGE_TAG}" bash
