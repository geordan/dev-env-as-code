#!/usr/bin/env bash

set -eux

docker build  --build-arg USER="${USER}" -t geodev:0.0.1 .
