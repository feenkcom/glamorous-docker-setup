# glamorous docker setup
This is a template repository for building and packaging a Server built with Glamorous Toolkit in a docker image.

## Build docker image with bash
```
DOCKER_BUILDKIT=1 docker build --no-cache --secret id=myid_rsa,src=$HOME/.ssh/id_rsa --secret id=myid_rsa.pub,src=$HOME/.ssh/id_rsa.pub -t glamorousdocker .
```
## Run
```
docker run glamorousdocker:latest
```
should print a number to console and then exit.

