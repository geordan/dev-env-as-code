#!/usr/bin/env python3

from config import *
from pathlib import Path
import subprocess
import os


home = str(Path.home())

# create build args and env vars from config.py
with open("config.py", "r") as config_file:
    build_arg_str = ""
    for line in config_file:
        if line.startswith("#"):
            continue
        build_arg_str += line.strip('\n')
        build_arg_str += " --build-arg "

# remove last ' --build-arg'... hacky
build_arg_str = " ".join(build_arg_str.split()[:-1])

# env_arg_str = build_arg_str.replace("--build-arg", "--env")
# env_arg_str = env_arg_str.replace("'", "")

# print(build_arg_str)
# print(env_arg_str)
# quit()

build_result = subprocess.run(
    [
        "docker",
        "build",
        "--build-arg",
        build_arg_str,
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
        "bash",
    ]
)
