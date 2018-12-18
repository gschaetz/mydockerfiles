# docker run --namme mailspring -d 
# -v /tmp/.X11-unix:/tmp/.X11-unix 
# -e DISPLAY=$DISPLAY 
# --privileged 
# --net dev -v /:/host_drive  
# mailspring 

FROM centos:latest

ARG VERSION=1.5.3
ARG SUBVERSION=0.1

RUN yum update -y && yum install -y \
    wget libXtst libxss1 \ 
    libXScrnSaver libsecret \
    libconfig-devel.x86_64 libappindicator lsb-core-noarch \
    GConf2 alsa-utils dbus-x11 gnome-keyring libgnome-keyring-devel && \
    wget https://github.com/Foundry376/Mailspring/releases/download/${VERSION}/mailspring-${VERSION}-${SUBVERSION}.x86_64.rpm && \
    rpm -i mailspring-${VERSION}-${SUBVERSION}.x86_64.rpm && \
    rm -rf /var/lib/apt/lists/* && \
    dbus-uuidgen >/etc/machine-id 

ENTRYPOINT [ "mailspring" ]
