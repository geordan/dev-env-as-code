FROM amazonlinux:2.0.20210701.0


ENV \
AWSCLI_VERSION=1.18.32 \
PIP_OPTS="--force-reinstall --no-cache-dir"

WORKDIR /tmp

RUN yum update -y

RUN yum install -y \
	git \
	man \
	man-db \ 
	man-pages \
	pip3 \
	python3 \
	tar \
	tmux \ 
	vim

COPY files/ .

RUN bash install-neovim.sh

# pip installs
RUN pip3 install ${PIP_OPTS} \
	awscli==${AWSCLI_VERSION} \ 
	git-remote-codecommit \
	pynvim

RUN mkdir /dotfiles
WORKDIR /root

RUN mkdir -p .config/nvim
RUN mkdir -p .config/nvim/undodir

RUN ln -s /dotfiles/.bash_aliases .bash_aliases
RUN ln -s /dotfiles/.bash_profile .bash_profile
RUN ln -s /dotfiles/.bashrc .bashrc
RUN ln -s /dotfiles/.config/nvim/init.lua .config/nvim/init.lua
RUN ln -s /dotfiles/.gitconfig .gitconfig
RUN ln -s /dotfiles/.tmux.conf .tmux.conf

RUN git clone --depth=1 https://github.com/savq/paq-nvim.git "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
