#!/bin/bash

service() {
	systemctl stop docker || true
	systemctl disable docker || true
	systemctl stop containerd || true
	systemctl disable containerd || true
	systemctl stop dockerd || true
	systemctl disable dockerd || true
}

remove() {
	local os_name="$(. /etc/os-release && echo "$ID")"
	local cmd
	case ${os_name} in
	 	"ubuntu" ) cmd="dpkg --purge ";;
		"centos" | "tlinux" ) cmd="yum erase -y -q ";;
	esac 

	# (centos7.2, ubuntu16.04)         => hook
	local nvidia_pkgs="nvidia-docker2" # nvidia-container-runtime nvidia-container-runtime-hook nvidia-container-toolkit libnvidia-container-tools libnvidia-container1"
	# (centos7.2, ubuntu16.04)         => docker-ce
	local runtime_pkgs="docker-ce docker-ce-cli containerd.io"

	for pkg in $nvidia_pkgs; do
		$cmd $pkg || true
	done

	for pkg in $runtime_pkgs; do
		$cmd $pkg || true
	done
}

file() {
	rm -rf /etc/docker
	rm -rf /etc/containerd
	rm -f /usr/bin/docker*
	rm -f /usr/bin/containerd*
}

main() {
	service
	remove
	file
}

main
