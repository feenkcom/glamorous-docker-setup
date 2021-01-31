# glamorous docker setup
This is a template repository for building and packaging a Glamorous Toolkit app in a docker image.


# Command line only
The `main` branch shows how to run a command line app that does not really do much - it just outputs a number. The code in `run.st` could instead start a [Teapot](https://github.com/zeroflag/Teapot).

## Build docker image with bash
```
DOCKER_BUILDKIT=1 docker build --no-cache --secret id=myid_rsa,src=$HOME/.ssh/id_rsa --secret id=myid_rsa.pub,src=$HOME/.ssh/id_rsa.pub -t glamorousdocker .
```
## Run
```
docker run glamorousdocker:latest
```
should print a number to console and then exit.

# GUI app server from within a running container by [Xpra](https://xpra.org/)

## Build docker image with bash
```
DOCKER_BUILDKIT=1 docker build --no-cache --secret id=myid_rsa,src=$HOME/.ssh/id_rsa --secret id=myid_rsa.pub,src=$HOME/.ssh/id_rsa.pub -t glamorousdocker .
```
## Run
```
docker run -it -p 9876:9876 glamorousdocker
```