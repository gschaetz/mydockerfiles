FROM debian:latest
LABEL maintainer "gary schaetz"

RUN apt-get update && apt-get install -y \
    curl git vim-gtk  \
 && cd tmp \ 
 &&  bash -c "$(curl -fsSL https://raw.github.com/gschaetz/dotfiles/master/bin/bootstrap)" -- link \
 && rm /root/.profile
