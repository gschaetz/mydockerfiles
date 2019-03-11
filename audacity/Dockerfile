FROM debian:sid
LABEL maintainer "Gary Schaetz"

RUN apt-get update && apt-get install -y \
	audacity \
	pulseaudio \
	libpulse0 \
        libgtk-3-0 \
        lxappearance \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user

ENTRYPOINT [ "audacity" ]
