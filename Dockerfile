FROM ubuntu:21.04

# suppress questions from tzdata, etc
ENV DEBIAN_FRONTEND=noninteractive

# RUN ls -s /home/$USER/.aws /root/aws
RUN apt-get update -y
RUN apt-get install -y \
ack \
awscli \
bsdmainutils \
curl \
gcc \
git \
golang \
make \
man-db \
neovim \
python3 \
python3-pip \
tzdata \
unzip \
wget

# # RUN mkdir -t /mnt/c/Users && ln -s /home/$USER /mnt/c/Users
RUN mkdir /mnt/home && ln -s /home/$USER /mnt/home

RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv
RUN echo 'export PATH="/root/.tfenv/bin:$PATH" && tfenv use 0.12.31'

# RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
# RUN . /root/.bashrc && nvm install v14.17.0
# RUN . /root/.bashrc && nvm install v14.22.0
# RUN . /root/.bashrc && nvm install v14.17.0

# # RUN echo 'source /home/$USER/docker/.bashrc' >> ~/.bashrc

# ENV GO111MODULE="on"
# ENV GO111MODULE="on" go get github.com/terraform-docs/terraform-docs
# RUN yes | unminimize
