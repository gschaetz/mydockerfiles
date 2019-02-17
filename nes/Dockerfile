# NES emulator in a container
#
# docker run --rm -d \
# 	--device /dev/snd \
# 	-v /tmp/.X11-unix:/tmp/.X11-unix \
# 	-e DISPLAY=unix$DISPLAY \
# 	--device /dev/dri \
# 	jess/nes /games/zelda.rom
#
FROM debian:latest
LABEL maintainer "gary schaetz"

RUN apt-get update && apt-get install -y \
    fceux \
	libgl1-mesa-dev \
	libgl1-mesa-dri \
	libxcursor-dev \
	libxi-dev \
	libxinerama-dev \
	libxrandr-dev \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& ldconfig

COPY games /games

ENTRYPOINT [ "/usr/games/fceux" ]
