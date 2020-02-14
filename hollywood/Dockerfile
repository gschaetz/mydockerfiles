FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
	software-properties-common \
	--no-install-recommends && \
	apt-get update && \
	apt-get install -y \
	byobu \
	hollywood \
	mlocate \
	tree \
        apg \
        bmon \
        bsdmainutils \
        ccze \
        cmatrix \
        htop \
        jp2a \
        moreutils \
        speedometer \
        --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& updatedb

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER root

WORKDIR $HOME

CMD [ "bash" ]
