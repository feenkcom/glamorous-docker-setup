# glamorous docker setup
This is a template repository for building and packaging a Glamorous Toolkit app in a docker image. It is based on GT.zip which contains a GlamorousToolkit.image without the GtWorld opened.


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

# GUI app served from within a running container by [Xpra](https://xpra.org/)

The `gui-app` branch allows running Glamorous Toolkit in linux systems with older versions of `GLIBCXX`. Its only dependency being docker and a browser.
Only tested this setup on OS X and Chrome.

## Build docker image with bash
```
DOCKER_BUILDKIT=1 docker build --no-cache --secret id=myid_rsa,src=$HOME/.ssh/id_rsa --secret id=myid_rsa.pub,src=$HOME/.ssh/id_rsa.pub -t glamorousdocker .
```
## Run
First run the docker image 
```
docker run -it -p 9876:9876 glamorousdocker
```
Then open the browser on [http://localhost:9876](http://localhost:9876).
Then, in xterm 
```
cd GlamorousToolkit
./glamoroustoolkit GlamorousToolkit.image st ../run.st --no-quit --interactive
```