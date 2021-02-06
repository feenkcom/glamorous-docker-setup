# syntax = docker/dockerfile:1.0-experimental
FROM ubuntu:latest
RUN apt -q update && apt -q install -y curl unzip libgit2-dev
ADD dockerimage.sh load.st run.st ./
RUN /bin/sh dockerimage.sh
CMD ["./GlamorousToolkit/glamoroustoolkit", "./GlamorousToolkit/GlamorousToolkit.image", "st", "run.st"]