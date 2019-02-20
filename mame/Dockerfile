FROM pataquets/ubuntu:trusty

RUN \
  echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" | \
    tee /etc/apt/sources.list.d/multiverse.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
      libgl1-mesa-glx \
      mame \
      mesa-utils \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/usr/games/mame" ]


# FROM debian:latest
# LABEL maintainer "gary schaetz"

# RUN apt-get update && apt-get install -y \
#     mame \
# 	libgl1-mesa-dev \
# 	libgl1-mesa-dri \
# 	libxcursor-dev \
# 	libxi-dev \
# 	libxinerama-dev \
# 	libxrandr-dev \
# 	pulseaudio \
# 	libpulse0 \
# 	--no-install-recommends \
# 	&& rm -rf /var/lib/apt/lists/* \
# 	&& ldconfig

# RUN mkdir /games

# ENV HOME /home/user
# RUN useradd --create-home --home-dir $HOME user \
# 	&& chown -R user:user $HOME \ 
# 	&& usermod -aG root user \
# 	&& usermod -u 1000 user \
# 	&& groupmod -g 1000 user
# USER user

# ENTRYPOINT [ "/usr/games/mame" ]
