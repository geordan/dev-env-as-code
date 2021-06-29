FROM registry.access.redhat.com/ubi8/ubi-init
LABEL maintainer="Geordan Liban"
WORKDIR /tmp

ENV \
    HOME="/root" \
    DOTFILES_DIR="/Users/geordan/code/geordan/dotfiles" \
    AWSCLI_VERSION=1.18.32 \
    GID=1000 \
    UID=1000 \
    PIP_OPTS="--force-reinstall --no-cache-dir" \
    YUM_OPTS="--setopt=install_weak_deps=False --setopt=tsflags=nodocs"
#
RUN yum upgrade -y
# RUN yum install -y dnf-plugins-core
RUN yum config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
RUN yum config-manager --add-repo https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
RUN yum install -y \
curl \
gcc \
git \
golang \
make \
man-db \
python3 \
python3-pip \
ripgrep \
terraform-ls \
tzdata \
unzip \
vim \
wget
# && rm -rf /var/cache/yum && yum -y clean all
#
# pip installs
RUN pip3 install ${PIP_OPTS} awscli==${AWSCLI_VERSION}
#
# neovim nightly install
RUN curl -L -O https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage && \
    chmod +x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    ln -s /tmp/squashfs-root/usr/bin/nvim /usr/local/bin/nvim && \
    nvim +PlugInstall +qall
#
#
# tmux install
COPY install-tmux .
RUN bash install-tmux
#
RUN mkdir /dotfiles
#
# tfenv install
RUN git clone https://github.com/tfutils/tfenv.git /root/.tfenv
RUN ln -s /root/.tfenv/bin/* /usr/local/bin
# RUN echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
#
# user setup
# RUN usermod -s /bin/zsh root
COPY setup.sh .
