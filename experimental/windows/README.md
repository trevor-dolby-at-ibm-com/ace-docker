# Windows containers

Simple docker images for ACE v13 on Windows, using Windows containers. These containers
will run Windows Server Core, and are not running Linux containers on Windows.

Dockefiles in the following directories are used for various purposes:

- ace-basic can run the product server, including all files except the toolkit.
- ace-sample contains a sample BAR file and Dockerfiles for building runnable images to serve HTTP clients.

## Docker Engine versus Docker Desktop

Docker Desktop for Windows may require licensing, and Docker Engine can be used instead. Follow the
instructions at https://docs.docker.com/engine/install/binaries/#install-server-and-client-binaries-on-windows
to install and start the Docker service.
