# Build minimal container OS with Yocto for edge devices

Linux containers started to become more widespread in embedded systems
during the last few years. Application portability, ease of
configuration, and isolation are all desirable features in edge devices
just as in the cloud. To quickly get started with containers on ARM
devices, you can download pre-built images like
[Armbian](https://www.armbian.com) for the [supported
boards](https://www.armbian.com/download/) and install Docker using
standard package managers.

If you wish to run all applications in Linux containers, you will
probably aim for a lightweight distribution instead of a full featured
one. Minimal container operating systems like
[CoreOS](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html/architecture/architecture-rhcos),
[RancherOS](https://rancher.com/rancher-os/) and others were created for
this purpose and you can use them on regular VMs.

For IoT devices, there is [Ubuntu Core](https://ubuntu.com/download/iot)
with off-the-shelf Raspberry and Dragonboard support. But if your
hardware is not supported or you’re not planning to use the snap package
format of Ubuntu, you can always compile your own distribution with
Buildroot or Yocto.

In this tutorial, I will show **how to build a custom Linux OS with
container support for an ARM board and how to deploy some simple apps in
containers**.

![orangepipc](/images/orangepipc.png)

For managing containers, I will use [Podman](https://podman.io) instead
of Docker as an experiment. I found during my early tests that starting
containers with Docker took ages on my board. But instead of playing
around with different container runtimes, I chose to test Podman, so
later I can [move to
Kubernetes](https://developers.redhat.com/blog/2019/01/29/podman-kubernetes-yaml/)
or run rootless containers.

First, set up a basic Yocto environment and clone the poky reference
distribution repository.

    git clone -b thud git://git.yoctoproject.org/poky

Configurations in the Yocto build system are stored in layers. The first
layer we need is
[meta-sunxi](https://github.com/linux-sunxi/meta-sunxi), which is the
BSP layer for my Allwinner based Orange Pi board, so let’s download this
layer.

    git clone https://github.com/linux-sunxi/meta-sunxi.git

We also need
[meta-openembedded](http://git.openembedded.org/meta-openembedded),
[meta-virtualization](https://git.yoctoproject.org/cgit/cgit.cgi/meta-virtualization/),
[meta-security](https://git.yoctoproject.org/cgit/cgit.cgi/meta-security)
layers to compile Podman and the container runtime.

    git clone -b thud git://git.openembedded.org/meta-openembedded && \
    git clone -b thud git://git.yoctoproject.org/meta-virtualization && \
    git clone -b thud git://git.yoctoproject.org/meta-security

Before adding these layers to the build system, we have to setup the
build directory. Run the poky environment setup script which will
automatically generate your */build* folder. Note that this command will
change your working directory.

    source poky/oe-init-build-env

Now we can set up the configuration files in the build directory. Enable
the following layers from the previously cloned repos with the
**bitbake-layers** command, so we don’t have to edit **bblayer.conf** by
hand.

    bitbake-layers add-layer ../meta-sunxi/ \
      	../meta-openembedded/meta-oe/ \
    	../meta-openembedded/meta-filesystems/ \
      	../meta-openembedded/meta-python/ \
    	../meta-openembedded/meta-networking/ \
    	../meta-openembedded/meta-perl/ \
    	../meta-virtualization/ \
    	../meta-security/

For the time being, I am going to add every customisation to the
**local.conf** file. This file stores the local or user specific
configuration. Later we can create a new configuration layer with
recipes for this image to store our changes permanently.

First we set the target device in **local.conf**. I checked the exact
machine name for my board in the BSP layer (*meta-sunxi/conf/machine/*)
and modified the `MACHINE` parameter accordingly.

    # This sets the default machine to be qemux86-64 if no other machine is selected:
    MACHINE ??= "orange-pi-one"

Linux container isolation is built on kernel features like cgroups and
namespaces but the kernel configuration for my board did not enable
these by default.

Instead of editing the kernel configuration in the BSP layer, settings
in meta-virtualization can extend our configuration to enable kernel
features to support containers. The meta-virtualization layer implements
this with defining a new `DISTRO_FEATURE`. Distro features can enable
functionality across multiple packages. So add this to our local.conf:

    DISTRO_FEATURES_append = " virtualization"

Finally select the packages we want to build into the image.

    IMAGE_INSTALL_append = "  podman podman-compose crun cgroup-lite rng-tools \
                              procps ca-certificates python3-setuptools \
                              python3-pyyaml python3-json"

Here is a little explanation for this part:

  - [podman](https://github.com/containers/libpod): Docker compatible
    container manager tool for libpod. We will use this command to
    manage containers just as with Docker.
  - [podman-compose](https://github.com/containers/podman-compose):
    **docker-compose** implementation with [podman](https://podman.io/)
    backend. We can run multi container applications and store container
    configuration in yaml files with this tool.
  - [crun](https://github.com/containers/crun): OCI Container Runtime
    written in C. Originally it was written for supporting cgroupV2.
    This runtime is a bit more leightweight than runc.
  - [cgroup-lite](http://git.yoctoproject.org/cgit/cgit.cgi/meta-virtualization/tree/recipes-containers/cgroup-lite/cgroup-lite_1.1.bb?h=fido):
    mounts cgroups on startup.
  - rng-tools: on my 4.19 kernel hardware rng is not yet mainlined for
    the Allwinner H3 processor, so I need [jitter
    entropy](https://lwn.net/Articles/642166/) to keep my startup time
    reasonable and don’t wait for /dev/random too long.
  - ca-certificates: podman wants to check the server certificates when
    pulling new images
  - some python3 packages: podman-compose depends on these, but were not
    included as dependencies the recipe.
  - e2fsprogs-mke2fs: we also need mkfs to create a data partition for
    the containers

Now we need to specify the image recipe we want to build. As a starting
point I used the core-image-minimal as the smallest default image. Use
the bitbake command to start the build.

    bitbake core-image-minimal

> This image configuration is the reason why we added all these
> seemingly random packages to the build. It is a minimal default
> configuration, so we had to add these otherwise essential tools like
> rngd to the image.

After a few hours hopefully the build completes, and you can find the sd
card image in *build/tmp/deploy/images*

    ls -ailh build/tmp/deploy/images/orange-pi-one/core-image-minimal-orange-pi-one-20200310152758.rootfs.sunxi-sdimg

Write this image to an SD card and boot the board with the new image.
Get a terminal using a serial port or SSH.

Before starting a container with podman, we have to modify libpod.conf.

    root@orange-pi-one:~# vi /etc/containers/libpod.conf

Set crun as a container runtime and use cgroupfs instead of systemd to
manage cgroups.

    cgroup_manager = "cgroupfs"
    runtime = "/usr/bin/crun"

Now we can try running our first container.

    root@orange-pi-one:~# podman run hello-world
    Trying to pull docker.io/library/hello-world...
    Getting image source signatures
    Copying blob b6206e5d545d done
    Copying config cfdb1bf11e done
    Writing manifest to image destination
    Storing signatures
    
    Hello from Docker!
    ...

With this build, your root partition has very little free space
available. If you would like to store your containers and container
images on another partition, edit storage.conf.

    root@orange-pi-one:~# vi /etc/containers/storage.conf

Point runroot and graphroot locations to your data partition.

    # Temporary storage location
    #runroot = "/var/run/containers/storage"
    runroot = "/mnt/data/storage"
    
    # Primary Read/Write location of container storage
    #graphroot = "/var/lib/containers/storage"
    graphroot = "/mnt/data/storage

(Now you can create a new partiton with fdisk and mkfs, then edit your
fstab to mount your partition on startup. Or you can use wic to create
an sd image with an empty data partition)

Test `podman-compose` with a simple configuration. Create a new compose
file.

    vi docker-compose.yml

Define an example service.

    version: '2.0'
    services:
      hello-world:
         image: hello-world

And start this configuration.

    root@orange-pi-one:~/test# podman-compose up
    podman pod create --name=test --share net
    4dc74923c2314d0ef0379f90e0246fab5d41896ae815ee33287b5e6360c40fac
    0
    podman create --name=test_hello-world_1 --pod=test -l io.podman.compose.config-hash=123 -l io.podman.compose.project=test -l io.podman.compose.version=0.0.1 -l com.docker.compose.container-number=1 -l com.docker.compose.service=hello-world --add-host hello-world:127.0.0.1 --add-host test_hello-world_1:127.0.0.1 hello-world
    ea9f6fd6fce3af419d1306b94e9de21f49bb323a870ed053abf4e5a8d9ae1b0c
    0
    podman start -a test_hello-world_1

    Hello from Docker!

In this example, we used Yocto to build a small Linux image from scratch
and installed essential packages to get started with containers on an
ARM devices. With the lightweight container runtime and the minimal
configuration the image still has a significant size (\~250MB) but it is
a good starting point for testing.

The next steps would be saving this configuration in a separate Yocto
layer, but this is a topic for another tutorial.
