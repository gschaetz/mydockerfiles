# Visual Studio Code in a container
#	NOTE: Needs the redering device (yeah... idk)
#
# docker run -d \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -v $HOME: \
#    -e DISPLAY=unix$DISPLAY \
#    --device /dev/dri \
#    --name vscode \
#    jess/vscode

FROM debian:buster
LABEL maintainer "Gary Schaetz"

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends

# Add the vscode debian repo
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN apt-get update && apt-get -y install \
	code \
	git \
	libasound2 \
	libatk1.0-0 \
	libcairo2 \
	libcups2 \
	libexpat1 \
	libfontconfig1 \
	libfreetype6 \
	libgtk2.0-0 \
	libpango-1.0-0 \
	libx11-xcb1 \
	libxcomposite1 \
	libxcursor1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
	libgtk-3-0 \
    libgtk2.0-0 \
	openssh-client \
	docker.io \
	graphviz \
	default-jre \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME \ 
	&& usermod -aG docker user \
	&& groupmod -g 999 docker \
	&& usermod -u 1000 user \
	&& groupmod -g 1000 user

RUN adduser user sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoer

COPY start.sh /usr/local/bin/start.sh

USER user
RUN code --extension-dir /.vscode/extensions --install-extension PeterJausovec.vscode-docker \
&&  code --extension-dir /.vscode/extensions --install-extension henriiik.docker-linter \
&&  code --extension-dir /.vscode/extensions --install-extension vscjava.vscode-java-pack \
&&  code --extension-dir /.vscode/extensions --install-extension donjayamanne.python-extension-pack \
&&  code --extension-dir /.vscode/extensions --install-extension donjayamanne.git-extension-pack \
&&  code --extension-dir /.vscode/extensions --install-extension vscodevim.vim \
&&  code --extension-dir /.vscode/extensions --install-extension redhat.vscode-yaml \
&&  code --extension-dir /.vscode/extensions --install-extension jebbs.plantuml \
&&  code --extension-dir /.vscode/extensions --install-extension ms-vscode.go \
&&  code --extension-dir /.vscode/extensions --install-extension formulahendry.code-runner \
&&  code --extension-dir /.vscode/extensions --install-extension yzhang.markdown-all-in-one \
&&  code --extension-dir /.vscode/extensions --install-extension donjayamanne.githistory 

WORKDIR $HOME

CMD [ "start.sh" ]
