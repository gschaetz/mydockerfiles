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
	mame \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& ldconfig

RUN mkdir /games 
 
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user

ENTRYPOINT [ "/usr/games/mame" ]
