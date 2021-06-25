#!/usr/bin/env bash

set -eu

for f in $(ls -A /dotfiles | grep -v README | grep -vE '^.git/*$' ); do ln -s /dotfiles/$f $f; done

source .bashrc
