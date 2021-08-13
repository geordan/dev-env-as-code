#!/usr/bin/env python3

from config import *
from pathlib import Path
import subprocess
import os

try:
    http_proxy = os.environ["HTTP_PROXY"]
    https_proxy = os.environ["HTTPS_PROXY"]
    no_proxy = os.environ["NO_PROXY"]
    build_arg = "HTTP_PROXY={http_proxy} --build-arg HTTPS_PROXY={https_proxy} --build-arg NO_PROXY={no_proxy}"

except:
    build_arg = "foo=bar"

home = str(Path.home())

build_result = subprocess.run(
    [
        "docker",
        "build",
        "--build-arg",
        build_arg,
        "-t",
        f"{IMAGE_NAME}:{IMAGE_TAG}",
        ".",
    ]
)

run_result = subprocess.run(
    [
        "docker",
        "run",
        "-v",
        f"{home}/code/dotfiles:/dotfiles",
        "-v",
        f"{home}/code/:/root/code",
        "-it",
        f"{IMAGE_NAME}:{IMAGE_TAG}",
        "tmux",
    ]
)
