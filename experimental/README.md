# Experimental docker files

Simple docker images for ACE v13 on Linux (amd64 and s390x) and Windows

Dockefiles in the following directories are used for various purposes:

- ace-full can run the full product, including mqsicreatebar with a virtual X server.
- ace-basic can run the product server, including all files except the toolkit.
- ace-minimal can run simple servers with a non-root user, and can be configured to install an MQ client.
- ace-sample contains a sample BAR file and Dockerfiles for building runnable images to serve HTTP clients.
- devcontainers is used with GitHub Codespaces to allow container-based development with VisualStudio Code in a web browser.

See build-all.sh for details on building the images; setting LICENSE=accept is required for all but the initial image builds.

## Setting the correct product URL

The Dockerfiles in the various directories take a `DOWNLOAD_URL` parameter that may
need to be specified to build a specific version of the product. This is provided on
the command line using the `--build-arg` parameter, and for the demo repos that use
Tekton to build the image, the URL is the `aceDownloadUrl` value in ace-minimal-image-pipeline-run.yaml.

This value may need updating, either to another version in the same server directory
(if available) or else to an ACE developer edition URL from the IBM website. In the latter
case, start at https://www.ibm.com/docs/en/app-connect/13.0?topic=enterprise-download-ace-developer-edition-get-started
and proceed through the pages until the main download page with a link: 

![download page](ace-dev-edition-download.png)

The link is likely to be of the form
```
https://iwm.dhe.ibm.com/sdfdl/v2/regs2/mbford/Xa.2/Xb.WJL1cUPI9gANEhP8GuPD_qX1rj6x5R4yTUM7s_C2ue8/Xc.13.0.1.0-ACE-LINUX64-EVALUATION.tar.gz/Xd./Xf.LpR.D1vk/Xg.12164875/Xi.swg-wmbfd/XY.regsrvs/XZ.pPVETUejcqPsVfDVKbdNu6IRpo4TkyKu/13.0.1.0-ACE-LINUX64-EVALUATION.tar.gz
```
Copy that link into the aceDownloadUrl parameter or use it as the DOWNLOAD_URL build
parameter, adjusting the version numbers in the other files and parameters as needed.

## Running the sample

To run the sample after building:
```
docker run -e LICENSE=accept --rm -ti ace-sample:13.0.1.0-alpine
```
and then `curl http://[container IP]:7800/test` should return '{"data":"a string from ACE"}'

## Various sizes

Local on Ubuntu with defaults in Dockerfiles:

```
ace-minimal      13.0.1.0-alpine-java8         f5fd8880aac2   14 hours ago     723MB
ace-minimal      13.0.1.0-alpine               0d0a36b729ed   14 hours ago     772MB
ace-minimal      13.0.1.0-alpine-mqclient      0ed6a3e42872   13 minutes ago   915MB
ace-minimal      13.0.1.0-ubuntu               42f4213b7872   14 hours ago     1.13GB
ace-basic        13.0.1.0-ubuntu               68f30d39fc7a   14 hours ago     2.61GB
ace-full         13.0.1.0-ubuntu               e193df427153   14 hours ago     4.94GB
```

Compressed sizes on DockerHub:

```
ace-minimal      13.0.1.0-alpine-java8         421.04 MB
ace-minimal      13.0.1.0-alpine               397.06 MB
ace-minimal      13.0.1.0-alpine-mqclient      441.58 MB
ace-minimal      13.0.1.0-ubuntu               588.08 MB
ace-basic        13.0.1.0-ubuntu               1.18 GB
ace-full         13.0.1.0-ubuntu               2.36 GB
```

Some of these will fit into the IBM Cloud container registry free tier due to compression, but ace-full and ace-basic are too big for that.

