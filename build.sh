#!/usr/bin/env bash

set -eux

. env.sh

docker build -t "${IMAGE_NAME}":"${IMAGE_TAG}" .
