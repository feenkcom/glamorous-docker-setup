#!/bin/bash
set -e

#get the latest gt image
curl -s -L https://github.com/feenkcom/gtoolkit/releases/latest/download/GT.zip -o GT.zip
unzip -q GT.zip

#get the latest glamorous toolkit vm
cd GlamorousToolkit
curl -s -L https://github.com/feenkcom/gtoolkit/releases/latest/download/GlamorousToolkitVM-linux64-bin.zip -o GlamorousToolkitVM-linux64-bin.zip
unzip -q GlamorousToolkitVM-linux64-bin.zip

#get the linux ui libs
curl -s -L  https://github.com/feenkcom/gtoolkit/releases/latest/download/libLinux64.zip -o libLinux64.zip
unzip -q libLinux64.zip
mv libLinux64-v*/* .
ls -al
ldd libSkia.so
#load our own code on top of pharo
./glamoroustoolkit GlamorousToolkit.image st ../load.st