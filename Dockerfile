FROM amazonlinux:2.0.20210701.0

LABEL maintainer="Geordan Liban"

ENV \
AWSCLI_VERSION=1.18.32 \
PIP_OPTS="--force-reinstall --no-cache-dir"

RUN yum update -y

RUN yum install -y \
git \
pip3 \
python3 \
vim

# pip installs
RUN pip3 install ${PIP_OPTS} awscli==${AWSCLI_VERSION}
RUN pip3 install ${PIP_OPTS} git-remote-codecommit

RUN mkdir /dotfiles
WORKDIR /root

RUN ln -s /dotfiles/.vimrc .vimrc
RUN ln -s /dotfiles/.bashrc .bashrc
RUN ln -s /dotfiles/.bash_profile .bash_profile
RUN ln -s /dotfiles/.bash_aliases .bash_aliases
