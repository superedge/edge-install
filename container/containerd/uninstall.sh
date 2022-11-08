#!/bin/bash

uninstall::service() {
	systemctl stop docker || true
	systemctl disable docker || true
	systemctl stop containerd || true
	systemctl disable containerd || true
	systemctl stop dockerd || true
	systemctl disable dockerd || true
}

uninstall::remove() {
	local os_name="$(. /etc/os-release && echo "$ID")"
	local cmd
	case ${os_name} in
	 	"ubuntu" ) cmd="dpkg --purge ";;
		"centos" | "tlinux" ) cmd="yum erase -y -q ";;
	esac 

	# (centos7.2, ubuntu16.04)         => hook
	# (tlinux, centos7.6, ubuntu18.04) => toolkit
	local nvidia_pkgs="nvidia-docker2" # nvidia-container-runtime nvidia-container-runtime-hook nvidia-container-toolkit libnvidia-container-tools libnvidia-container1"
	# (centos7.2, ubuntu16.04)         => docker-ce
	# (tlinux, centos7.6, ubuntu18.04) => all
	local runtime_pkgs="docker-ce docker-ce-cli containerd.io"

	for pkg in $nvidia_pkgs; do
		$cmd $pkg || true
	done

	for pkg in $runtime_pkgs; do
		$cmd $pkg || true
	done
}

uninstall::file() {
	rm -rf /etc/docker
	rm -rf /etc/containerd
	rm -rf /usr/bin/docker*
	rm -rf /usr/local/sbin/containerd*
	rm -f /usr/local/sbin/ctr /usr/local/sbin/crictl
}

uninstall::main() {
	uninstall::service
	uninstall::remove
	uninstall::file
}
