#!/usr/bin/env python3

from config import *
from pathlib import Path
import subprocess
import os

try:
    http_proxy = os.environ["HTTP_PROXY"]
    https_proxy = os.environ["HTTPS_PROXY"]
    no_proxy = os.environ["NO_PROXY"]
except:
    http_proxy = ""
    https_proxy = ""
    no_proxy = ""

home = str(Path.home())

build_result = subprocess.run(
    [
        "docker",
        "build",
        "-e",
        f"HTTP_PROXY={http_proxy}",
        "-e",
        f"HTTPS_PROXY={https_proxy}",
        "-e",
        f"NO_PROXY={no_proxy}",
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
