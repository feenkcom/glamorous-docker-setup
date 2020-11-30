# glamorousapp
This is a template repository for building and packaging a Glamorous Toolkit app.

# Build with
## Build docker image with bash
```
DOCKER_BUILDKIT=1 docker build --no-cache --secret id=myid_rsa,src=$HOME/.ssh/id_rsa --secret id=myid_rsa.pub,src=$HOME/.ssh/id_rsa.pub -t glamorousapp .
```
## Run
```
docker run glamorousapp:latest
```
should print a number to console and then exit.

