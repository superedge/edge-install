#!/usr/bin

DOCKER_VERSION="docker-19.03-linux-amd64.tgz"
CONTAINERD_VERSION="containerd-1.3.4-linux-amd64.tgz"
KUBE_VERSION="kube-linux-amd64-v1.22.6.tar.gz"

WORKDIR=`pwd`
cd edge-install/container/
tar zcvf $DOCKER_VERSION ./docker/
tar zcvf $CONTAINERD_VERSION ./containerd/
rm -rf ./docker
rm -rf ./containerd

cd $WORKDIR
rm -rf edge-install/.git
tar zcvf $KUBE_VERSION ./edge-install


