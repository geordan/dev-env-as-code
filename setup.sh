#!/usr/bin/env bash

set -eu

for f in $(ls -A /dotfiles | grep -v README | grep -vE '^.git/*$' ); do ln -f -s /dotfiles/$f $f; done
