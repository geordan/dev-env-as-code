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
# update image
RUN yum update --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos -y && rm -rf /var/cache/yum
#
# yum installs
RUN yum install -y \
--disableplugin=subscription-manager \
# --disablerepo=* \
# --enablerepo=ubi-8-appstream \
# --enablerepo=ubi-8-baseos -y \
curl \
gcc \
git \
golang \
make \
man-db \
python3 \
python3-pip \
sudo \
tzdata \
unzip \
vim \
wget \
&& rm -rf /var/cache/yum && yum -y clean all
#
# RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && yum repolist
# RUN yum install -y tmux
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

# RUN for f in $(ls -A /dotfiles | grep -v README | grep -vE '^.git/*$' ); do ln -s /dotfiles/$f $f; done
# RUN for f in $(ls -A $DOTFILES_DIR | grep -v README | grep -vE '^.git/*$' ); do ln -s $DOTFILES_DIR/$f $f; done


##
## Set application execution parameters
##

#WORKDIR ${AWSCLI_WORKDIR}


#ENV AWSCLI_VERSION=1.18.32 \
#    AWSCLI_USER=awscli \
#    AWSCLI_WORKDIR=/home/awscli \
#    YUM_OPTS="--setopt=install_weak_deps=False --setopt=tsflags=nodocs" \
#    PIP_OPTS="--force-reinstall --no-cache-dir"

##
## Copy helper scripts to image
##

#COPY helpers/* /usr/bin/

##
## Install requirements and application
##

#RUN yum install ${YUM_OPTS} -y python36 nss_wrapper && \
#    yum -y clean all && \
#    pip3 install ${PIP_OPTS} awscli==${AWSCLI_VERSION}

##
## Prepare the image for running on OpenShift
##

#RUN useradd -m -g 0 ${AWSCLI_USER} && \
#    chgrp -R 0 ${AWSCLI_WORKDIR} && \
#    chmod -R g+rwX ${AWSCLI_WORKDIR}

#USER ${AWSCLI_USER}

##
## Set application execution parameters
##

#WORKDIR ${AWSCLI_WORKDIR}

#ENTRYPOINT ["/usr/bin/entrypoint.sh"]
#CMD [ "/bin/bash" ]


# FROM ubuntu:21.04

# ARG USER
# # suppress questions from tzdata, etc
# ENV DEBIAN_FRONTEND=noninteractive

# WORKDIR /root

# # RUN ls -s /home/$USER/.aws /root/aws
# RUN apt-get update -y
# RUN apt-get install -y \
# ack \
# awscli \
# bsdmainutils \
# curl \
# gcc \
# git \
# golang \
# make \
# man-db \
# python3 \
# python3-pip \
# tzdata \
# unzip \
# wget

# # # RUN mkdir -t /mnt/c/Users && ln -s /home/$USER /mnt/c/Users
# RUN mkdir /mnt/home && ln -s /home/$USER /mnt/home

# RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv
# RUN echo 'export PATH="/root/.tfenv/bin:$PATH" && tfenv use 0.12.31'

# # COPY dotfiles /root


# # RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
# # RUN . /root/.bashrc && nvm install v14.17.0
# # RUN . /root/.bashrc && nvm install v14.22.0
# # RUN . /root/.bashrc && nvm install v14.17.0

# # # RUN echo 'source /home/$USER/docker/.bashrc' >> ~/.bashrc

# # ENV GO111MODULE="on"
# # ENV GO111MODULE="on" go get github.com/terraform-docs/terraform-docs
# # RUN yes | unminimize
