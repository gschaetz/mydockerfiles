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
	pulseaudio \
    libgtk-3-0 \
    libgtk2.0-0 \
	libpulse0 \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& ldconfig

RUN mkdir /games \
  && chmod -R 777 /games
  
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user

ENTRYPOINT [ "/usr/games/fceux" ]
