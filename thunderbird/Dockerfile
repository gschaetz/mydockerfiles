# Thunderbird in a docker container
#
# Usage
# docker run \
# --name thunderbird_"$(date +%s)" \
# -d \
# -v /path/to/thunderbird/config:/root/.thunderbird \
# -v /etc/localtime:/etc/localtime:ro \
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -e DISPLAY=unix"$DISPLAY" \
# gruen/thunderbird
FROM debian:latest
RUN apt-get -y update \
&& apt-get install -y thunderbird \
&& rm -rf /var/lib/apt/lists/* \
&& apt-get autoremove -y

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG root user \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user
USER user

CMD ["thunderbird"]