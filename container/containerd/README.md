## 组件版本：

### Containerd:

代码来源： github.com/containerd/containerd 

Tag：v1.3.2

Commit Id：ff48f57fc83a8c44cf4ad5d672424a98ba37ded6

#### 编译链接库说明：

containerd目前使用社区发行版是经过动态编译的。其中依赖库：

```
$ ldd containerd
	linux-vdso.so.1 (0x00007fff46370000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f7b10cba000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f7b10a9b000)
	libseccomp.so.2 => /lib/x86_64-linux-gnu/libseccomp.so.2 (0x00007f7b10854000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f7b10463000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f7b13c63000)
```

这些是Linux默认安装的基本依赖库，而`libseccomp`需要确认下是否
已经安装（如果没有可以自己安装）。

containerd的静态编译结果不支持运行插件，因此不能使用静态编译。

### runc

```
runc version 1.0.0-rc6+dev
commit: f56b4cbeadc407e715d9b2ba49e62185bd81cef4
spec: 1.0.1-dev
```

runc编译选项：

```
$ make static BUILDTAGS="seccomp apparmor nokmem"
```

### crictl

v1.14.0

下载来源：https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-v1.14.0-linux-amd64.tar.gz

支持Kubernetes 1.14.X，兼容支持Kubernetes 1.12.X

crictl工具支持命令集：
```
attach        Attach to a running container
create        Create a new container
exec          Run a command in a running container
version       Display runtime version information
images        List images
inspect       Display the status of one or more containers
inspecti      Return the status of one or more images
imagefsinfo   Return image filesystem info
inspectp      Display the status of one or more pods
logs          Fetch the logs of a container
port-forward  Forward local port to a pod
ps            List containers
pull          Pull an image from a registry
runp          Run a new pod
rm            Remove one or more containers
rmi           Remove one or more images
rmp           Remove one or more pods
pods          List pods
start         Start one or more created containers
info          Display information of the container runtime
stop          Stop one or more running containers
stopp         Stop one or more running pods
update        Update one or more running containers
config        Get and set crictl options
stats         List container(s) resource usage statistics
completion    Output shell completion code
help, h       Shows a list of commands or help for one command
```

同docker client工具相比，crictl不支持build，save，load，top等命令，其余命令基本与docker client相同。

## fix list：

在TKE集群使用Contaienrd代替Docker Daemon，不需要再维护Docker版本，并可以避免Docker里面的bug。

## install
mv bin/* ./
mv conf/* ./
./install
