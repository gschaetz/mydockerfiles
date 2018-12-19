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
CMD ["thunderbird"]