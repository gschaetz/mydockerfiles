FROM debian:sid-slim
LABEL maintainer "Jessie Frazelle <jess@linux.com>"

RUN apt-get update && apt-get install -y \
	dirmngr \
	gnupg \
	--no-install-recommends \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0AB215679C571D1C8325275B9BDB3D89CE49EC21 \
	&& echo "deb http://ppa.launchpad.net/mozillateam/firefox-next/ubuntu xenial main" >> /etc/apt/sources.list.d/firefox.list \
	&& apt-get update && apt-get install -y \
	apulse \
	ca-certificates \
	ffmpeg \
	firefox \
    libgtk-3-0 \
    libgtk2.0-0 \
	hicolor-icon-theme \
	libasound2 \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
	fonts-noto \
	fonts-noto-cjk \
	fonts-noto-color-emoji \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV LANG en-US

COPY local.conf /etc/fonts/local.conf
RUN echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js \
 && chmod 777 /etc/firefox/syspref.js \
 && chmod 777 /etc/fonts/local.conf
 
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user


COPY entrypoint.sh /usr/bin/startfirefox

ENTRYPOINT [ "startfirefox" ]
