# MAME emulator in a container
#
# docker run --rm -d \
# 	--device /dev/snd \
# 	-v /tmp/.X11-unix:/tmp/.X11-unix \
#       -v ~/games/nes:/games \
# 	-e DISPLAY=unix$DISPLAY \
# 	--device /dev/dri \
# 	gschaetz/mame 
#
FROM debian:latest
LABEL maintainer "gary schaetz"

RUN apt-get update && apt-get install -y \
	libgl1-mesa-dev \
	libgl1-mesa-dri \
	libxcursor-dev \
	libxi-dev \
	libxinerama-dev \
	libxrandr-dev \
	pulseaudio \
	libpulse0 \
	build-essential \
	git \ 
	autoconf \
	automake \
	libsdl2-dev \
	libasound2-dev \
	libfreetype6-dev \
	zlib1g-dev \
	libexpat1-dev \
	libslang2-dev \
	libncurses5-dev \
	gcc \
	curl \
	ca-certificates \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& ldconfig

RUN mkdir /games \
&& curl -L https://github.com/amadvance/advancemame/releases/download/v3.9/advancemame-3.9.tar.gz -o /tmp/mame.tar.gz \
&& tar -xzf /tmp/mame.tar.gz -C /usr/local/bin/ \
&& cd /usr/local/bin/advancemame*/ \
&& 	./configure \
&& make -j3 \
&& make install

 
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user

ENTRYPOINT [ "bash" ]
