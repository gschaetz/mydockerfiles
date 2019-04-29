FROM debian:latest

RUN apt-get update -y && \
    apt-get install -y gnupg2 \
    libgtk-3-0 \
    libgtk2.0-0 \
    apt-transport-https \
    ca-certificates \
    kdesudo && \
    echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list && \
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61 && \
    apt-get update -y && \
    apt-get install -y balena-etcher-electron

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user

CMD ["etcher-electron"]
