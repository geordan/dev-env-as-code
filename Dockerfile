FROM ubuntu:20.04

ENV AWSCLI_VERSION=1.18.32
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_OPTS="--force-reinstall --no-cache-dir"

WORKDIR /tmp

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get clean

RUN apt-get install -y \
    curl \
    dos2unix \
    git \
    lsb-release \
    man-db \
    manpages \
    openjdk-8-jre \
    python3 \
    python3-pip \
    software-properties-common \
    unzip \
    vim


# Add the HashiCorp GPG key and repository
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get install -y terraform-ls

ADD files . 

# pip installs
RUN pip3 install ${PIP_OPTS} \
    -r requirements.txt

RUN mkdir /dotfiles

WORKDIR /root

## terraform - tfenv, 
RUN git clone https://github.com/tfutils/tfenv.git .tfenv
RUN ./.tfenv/bin/tfenv install 0.12.31
RUN ./.tfenv/bin/tfenv install 0.13.7
RUN ./.tfenv/bin/tfenv install  0.14.11
RUN ./.tfenv/bin/tfenv use 0.12.31

## vim
RUN vim +q

RUN ln -s -f /dotfiles/.bash_profile .bash_profile
RUN ln -s -f /dotfiles/.bashrc .bashrc
RUN ln -s /dotfiles/.gitconfig .gitconfig
RUN ln -s /dotfiles/.vim .vim
RUN ln -s /dotfiles/.vimrc .vimrc

RUN yes | unminimize
