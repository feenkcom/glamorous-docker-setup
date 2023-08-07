FROM ubuntu:latest as ubuntu-gtbase
# This build prepares ubuntu for GToolkit, installing required libraries.

LABEL authors="feenk"
LABEL maintainer="feenk <admin@feenk.com>"

# Install required applications
# Source: https://octopus.com/blog/using-ubuntu-docker-image
RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
# Install libraries for libSkia.so
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y libfreetype6 libx11-6 libgl1 libegl1 libfontconfig1 \
  && rm -rf /var/lib/apt/lists/*

# Create working directory
RUN mkdir "/gtoolkit"
WORKDIR "/gtoolkit/"


FROM ubuntu-gtbase as gt-download
# This build downloads and extract GToolkit of a given version.

# Define GToolkit version that should be downloaded
ARG GT_VERSION

# install cURL, unzip
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y curl ca-certificates unzip \
  && rm -rf /var/lib/apt/lists/*

# Copy default files
COPY download-gt.sh /usr/local/bin

# Download GToolkit VM and image
RUN download-gt.sh $GT_VERSION


FROM ubuntu-gtbase as gtoolkit
# This build

# Copy VM, image, and documentation files
COPY --from=gt-download /gtoolkit/ /gtoolkit/

# You want to replace the run.st file with our own version
# This version
COPY run.st /gtoolkit/

ENTRYPOINT [ "./bin/GlamorousToolkit-cli", "GlamorousToolkit.image", "st", "run.st" ]
