FROM ubuntu:impish-20210722


ENV \
AWSCLI_VERSION=1.18.32 \
DEBIAN_FRONTEND=noninteractive \
PIP_OPTS="--force-reinstall --no-cache-dir"

WORKDIR /tmp

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y \
	curl \
	git \
	man-db \ 
	manpages \
	python3-pip \
	python3 \
	tmux \ 
	vim \
	zsh
COPY files/ .

RUN bash install-neovim.sh

# pip installs
RUN pip3 install ${PIP_OPTS} \
	awscli==${AWSCLI_VERSION} \ 
	git-remote-codecommit \
	pynvim

RUN mkdir /dotfiles

WORKDIR /root

RUN chsh -s /usr/bin/zsh


RUN ln -s /dotfiles/.gitconfig .gitconfig
RUN ln -s /dotfiles/.tmux.conf .tmux.conf
RUN ln -s /dotfiles/.vimrc .vimrc
RUN ln -s /dotfiles/.zsh_history .zsh_history
RUN ln -s /dotfiles/.zshrc .zshrc

## nvim
#RUN git clone --depth=1 https://github.com/savq/paq-nvim.git "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
# RUN mkdir -p .config/nvim
# RUN mkdir -p .config/nvim/undodir
# RUN ln -s /dotfiles/.config/nvim/init.lua .config/nvim/init.lua

## vim
RUN vim +q

## zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
