FROM registry.access.redhat.com/ubi8/ubi-init
LABEL maintainer="Geordan Liban"
WORKDIR /tmp

ENV \
    USER="dev" \
    HOME="/home/dev" \
    DOTFILES_DIR="/Users/geordan/code/geordan/dotfiles" \
    AWSCLI_VERSION=1.18.32 \
    GID=1000 \
    UID=1000 \
    PIP_OPTS="--force-reinstall --no-cache-dir" \
    YUM_OPTS="--setopt=install_weak_deps=False --setopt=tsflags=nodocs"
#
# add extra rpm repo
COPY extras.repo /etc/yum.repos.d/
#
# update image
RUN yum update --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos -y && rm -rf /var/cache/yum
#
# yum installs
RUN yum install -y \
--disableplugin=subscription-manager \
curl \
gcc \
git \
golang \
make \
man-db \
python3 \
python3-pip \
ripgrep \
sudo \
tmux \
tzdata \
unzip \
vim \
wget \
&& rm -rf /var/cache/yum && yum -y clean all
#
# pip installs
RUN pip3 install ${PIP_OPTS} awscli==${AWSCLI_VERSION}
#
# neovim nightly install
RUN wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage && \
    chmod +x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    sudo ln -s /tmp/squashfs-root/usr/bin/nvim /usr/bin/nvim
#
# user creation
RUN useradd -u ${UID} -m -g 0 ${USER} && \
    chgrp -R 0 ${HOME} && \
    chmod -R g+rwX ${HOME} && \
    usermod -aG wheel ${USER} && \
    echo -e "${USER}\tALL=(ALL)\tNOPASSWD: ALL" > /etc/sudoers.d/020_sudo_${USER}

RUN mkdir /dotfiles

WORKDIR $HOME

COPY setup.sh .
RUN chown $USER setup.sh
