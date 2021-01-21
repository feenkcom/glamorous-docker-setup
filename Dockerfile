FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu20.04
# FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

# install XPRA: https://xpra.org/trac/wiki/Usage/Docker 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y wget gnupg2 && \
    wget -O - http://winswitch.org/gpg.asc | apt-key add - && \
    echo "deb http://winswitch.org/beta/  focal main" > /etc/apt/sources.list.d/xpra.list && \
    apt-get update && \
    apt-get install -y xpra xdg-utils xvfb xterm mesa-utils curl unzip && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*
    
# non-root user
RUN adduser --disabled-password --gecos "VICE_User" --uid 1000 user

# install all X apps here
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y firefox && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/user/1000/xpra
RUN mkdir -p /run/xpra
RUN chown user:user /run/user/1000/xpra
RUN chown user:user /run/xpra
RUN chmod 775 /run/xpra
RUN chmod 700 /run/user/1000/xpra

USER user

ENV DISPLAY=:100

# CMD ["./glamoroustoolkit", "GlamorousToolkit/GlamorousToolkit.image", "st", "run.st"]

WORKDIR /home/user

# RUN sudo apt update && apt install -y curl wget unzip
ADD .project .properties dockerimage.sh load.st run.st ./
ADD .git .git
ADD src src
RUN --mount=type=secret,id=myid_rsa --mount=type=secret,id=myid_rsa.pub /bin/sh dockerimage.sh

EXPOSE 9876

CMD xpra start :100 --bind-tcp=0.0.0.0:9876 --html=on --start-child=xterm --exit-with-children=no --daemon=no --xvfb="/usr/bin/Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" --pulseaudio=no --notifications=no --bell=no