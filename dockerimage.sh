#!/bin/bash
set -e

#get the latest gt image
curl -L https://github.com/feenkcom/gtoolkit/releases/latest/download/GT.zip -o GT.zip
unzip GT.zip

#get the latest glamorous toolkit vm
cd GlamorousToolkit
curl -L https://github.com/feenkcom/gtoolkit/releases/latest/download/GlamorousToolkitVM-linux64-bin.zip -o GlamorousToolkitVM-linux64-bin.zip
unzip GlamorousToolkitVM-linux64-bin.zip

#get the linux ui libs
curl -L  https://github.com/feenkcom/gtoolkit/releases/latest/download/libLinux64.zip -o libLinux64.zip
unzip libLinux64.zip
mv libLinux64-v*/* .
ls -al
#load our own code on top of pharo
./glamoroustoolkit GlamorousToolkit.image st ../load.st