FROM debian:latest

RUN apt-get update -y && \
    apt-get install -y gnupg2 \
    kdesudo && \ 
    echo "deb http://dl.bintray.com/resin-io/debian stable etcher" \
    | tee /etc/apt/sources.list.d/etcher.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61 && \
    apt-get update -y && \
    apt-get install -y etcher-electron

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user

CMD ["etcher-electron"]
