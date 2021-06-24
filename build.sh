#!/usr/bin/env bash

set -eux

docker build  --build-arg USER="${USER}" -t geordandev:0.0.1 .
