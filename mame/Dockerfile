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
    mame \
	libgl1-mesa-dev \
	libgl1-mesa-dri \
	libxcursor-dev \
	libxi-dev \
	libxinerama-dev \
	libxrandr-dev \
	pulseaudo \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& ldconfig

RUN mkdir /games

ENTRYPOINT [ "/usr/games/mame" ]
