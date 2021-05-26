# syntax = docker/dockerfile:1.0-experimental
FROM ubuntu:latest
RUN apt update && apt install -y curl unzip libgit2-dev xdg-utils
ADD dockerimage.sh load.st run.st ./
RUN --mount=type=secret,id=myid_rsa --mount=type=secret,id=myid_rsa.pub /bin/sh dockerimage.sh
CMD ["./GlamorousToolkit/glamoroustoolkit", "./GlamorousToolkit/GlamorousToolkit.image", "st", "run.st"]