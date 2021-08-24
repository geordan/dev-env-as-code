FROM ubuntu:20.04


ENV AWSCLI_VERSION=1.18.32
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_OPTS="--force-reinstall --no-cache-dir"

WORKDIR /tmp

RUN yes | unminimize

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y --fix-missing \
    curl \
    dos2unix \
    git \
    lsb-release \
    man-db \
    manpages \
    python3 \
    python3-pip \
    software-properties-common \
    tmux \
    unzip \
    vim \
    zsh

# Add the HashiCorp GPG key and repository
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update -y
RUN apt-get install -y terraform-ls

# pip installs
RUN pip3 install ${PIP_OPTS} \
	awscli==${AWSCLI_VERSION} \ 
	git-remote-codecommit 

ADD files . 

RUN bash install-todo-txt-cli.sh

RUN mkdir /dotfiles

WORKDIR /root

RUN chsh -s /usr/bin/zsh

## nvim
#RUN git clone --depth=1 https://github.com/savq/paq-nvim.git "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
# RUN mkdir -p .config/nvim
# RUN mkdir -p .config/nvim/undodir
# RUN ln -s /dotfiles/.config/nvim/init.lua .config/nvim/init.lua

## terraform - tfenv, 
RUN git clone https://github.com/tfutils/tfenv.git .tfenv
RUN ./.tfenv/bin/tfenv install 0.12.31
RUN ./.tfenv/bin/tfenv install 0.13.7
RUN ./.tfenv/bin/tfenv install  0.14.11
RUN ./.tfenv/bin/tfenv use 0.12.31

## vim
RUN vim +q

## zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN ln -s -f /dotfiles/.todo.cfg .todo.cfg
RUN ln -s -f /dotfiles/.zshrc .zshrc
RUN ln -s /dotfiles/.gitconfig .gitconfig
RUN ln -s /dotfiles/.tmux.conf .tmux.conf
RUN ln -s /dotfiles/.vimrc .vimrc
RUN ln -s /dotfiles/.vim .vim
RUN ln -s /dotfiles/.zsh_history .zsh_history
