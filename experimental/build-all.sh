#!/bin/bash

# Later versions from the same site, or else via the Developer edition download site linked from
# https://www.ibm.com/docs/en/app-connect/13.0?topic=enterprise-download-ace-developer-edition-get-started
export DOWNLOAD_URL=https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/integration/13.0.4.0-ACE-LINUX64-EVALUATION.tar.gz
#export DOWNLOAD_URL=http://192.168.1.70:49177/ace/13.0.4.0-ACE-LINUX64-EVALUATION.tar.gz
export PRODUCT_VERSION=13.0.4.0

# Used for ace-minimal and ace-devcontainer mqclient variants
export MQ_DOWNLOAD_URL=https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqdev/redist/9.4.3.0-IBM-MQC-Redist-LinuxX64.tar.gz
export DOWNLOAD_CONNECTION_COUNT=10


# Exit on error
set -e

cd ace-minimal
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT -t ace-minimal:${PRODUCT_VERSION}-alpine -f Dockerfile.alpine .
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT -t ace-minimal:${PRODUCT_VERSION}-alpine-java8 -f Dockerfile.alpine-java8 .
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT -t ace-minimal:${PRODUCT_VERSION}-ubuntu -f Dockerfile.ubuntu .
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT --build-arg MQ_DOWNLOAD_URL -t ace-minimal:${PRODUCT_VERSION}-alpine-mqclient -f Dockerfile.alpine .

cd ../ace-full
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT -t ace-full:${PRODUCT_VERSION}-ubuntu -f Dockerfile.ubuntu .

cd ../ace-basic
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT -t ace-basic:${PRODUCT_VERSION}-ubuntu -f Dockerfile.ubuntu .

cd ../devcontainers
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT -t ace-devcontainer:${PRODUCT_VERSION} -f Dockerfile .
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT -t ace-minimal-devcontainer:${PRODUCT_VERSION} -f Dockerfile.ace-minimal .
docker build --build-arg DOWNLOAD_URL --build-arg DOWNLOAD_CONNECTION_COUNT --build-arg MQ_DOWNLOAD_URL -t ace-devcontainer-mqclient:${PRODUCT_VERSION} -f Dockerfile.mqclient .

cd ../sample
# Normally only one of these would be built, and would be tagged with an application version
docker build --build-arg LICENSE=accept --build-arg BASE_IMAGE=ace-minimal:${PRODUCT_VERSION}-alpine -t ace-sample:${PRODUCT_VERSION}-alpine -f Dockerfile .
docker build --build-arg LICENSE=accept --build-arg BASE_IMAGE=ace-minimal:${PRODUCT_VERSION}-alpine-java8 -t ace-sample:${PRODUCT_VERSION}-alpine-java8 -f Dockerfile .
docker build --build-arg LICENSE=accept --build-arg BASE_IMAGE=ace-minimal:${PRODUCT_VERSION}-ubuntu -t ace-sample:${PRODUCT_VERSION}-ubuntu -f Dockerfile .
docker build --build-arg LICENSE=accept --build-arg BASE_IMAGE=ace-full:${PRODUCT_VERSION}-ubuntu -t ace-sample:${PRODUCT_VERSION}-full-ubuntu -f Dockerfile .

