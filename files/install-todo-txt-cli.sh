#!/usr/bin/env bash

set -eux

# install todo-txt cli
# https://github.com/todotxt/todo.txt-cli

RELEASE=2.12.0

rm -rf  todo*

curl -L -O https://github.com/todotxt/todo.txt-cli/releases/download/v$RELEASE/todo.txt_cli-$RELEASE.tar.gz

tar xvzf todo.txt_cli-$RELEASE.tar.gz

cd todo.txt_cli-$RELEASE 

cp todo.cfg /root
cp todo.sh /usr/local/bin && chmod +x /usr/local/bin/todo.sh
cp todo_completion /etc