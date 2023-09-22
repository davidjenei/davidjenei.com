Install Azure IoT Edge on Toradex modules
=========================================

Toradex is a well-known manufacturer on the [Computer on Module] market.
They offer lots of guides for their hardware modules including
[tutorials] on how to get started with AWS Greengrass, but there is not
much information on the Azure counterpart.

The official Azure IoT Edge documentation has [instructions] for
installing the runtime with package managers on Linux. But on some
constrained hardware, you may want to consider building a minimal Linux
without package managers or the prebuilt package is simply not suitable
for your system. In this post I would like to show how to compile a
Linux image from scratch with Azure IoT Edge runtime. I will also test
the service and deploy an example application to the board in a Linux
container.

For building Linux, I will use the Yocto framework, so first make sure
that you have the [required packages] for your system.

Toradex uses the repo utility to manage multiple git repositories for
their BSP. It is available for many distros, so we can install simply
install with our package manager

    david.jenei@yocto-env:~$ sudo apt install repo

Now we can set up the build environment. Follow this Toradex [tutorial]
and check out the bsp layers.

    david.jenei@yocto-env:~/oe-core$ repo init -u http://git.toradex.com/toradex-bsp-platform.git -b LinuxImage3.0 -m default.xml
    david.jenei@yocto-env:~/oe-core$ repo sync

Open local.conf and set your machine. In this demonstration I am working
with a Colibri i.MX6 board:

    MACHINE ?= "colibri-imx6"

Append this line to the config to accept Freescale EULA, so the build
will complete on your first try:

    ACCEPT_FSL_EULA = "1"

Build the default console image with bitbake:

    david.jenei@yocto-env:~/oe-core/build$ bitbake -k console-tdx-image

When the build completes, you can find the binaries in the deploy
directory:

    david.jenei@yocto-env:~/oe-core/build$ ls deploy/images/colibri-imx6/

I am going to assume here, that you already have bootloader installed on
your board (otherwise you have to enter recovery mode and use
[imx\_loader] and execute u-boot.imx).

Connect to the debug serial and get a u-boot shell. Also connect to the
USB OTG port, and attach the eMMC boot partition to your PC as an USB
mass storage.

    Colibri iMX6 # ums 0 mmc 0.1
    UMS: LUN 0, dev 0, hwpart 1, sector 0x0, count 0x1000
    USB EHCI 1.00

Write the SPL and the u-boot.img to the eMMC with dd:

> Make sure that you select the right output device here (/dev/disk2,
> /dev/sda etc. depending on your platform).

    sudo dd if=./SPL-colibri-imx6-2019.07+gitAUTOINC+e1cbe8c74e-r0-spl-2019.07+gitAUTOINC+e1cbe8c74e-r0 of=/dev/disk2 bs=1k seek=1 conv=sync
    sudo dd if=./u-boot-spl-2019.07+gitAUTOINC+e1cbe8c74e-r0.img of=/dev/disk2 bs=1k seek=69 conv=sync

Reset the board, and check the build time stamp:

    Colibri iMX6 # reset
    resetting ...

    Industrial temperature grade DDR3 timings, 64bit bus width.
    Trying to boot from MMC1

    U-Boot 2019.07-3.0.3+g694e2136ee (Mar 05 2020 - 11:14:09 +0000)

Now that we have our fresh bootloader installed on the board, we can try
to compile Azure IoT Edge. Edit local.conf once again, and add the
following:

    DISTRO_FEATURES_append = " virtualization"
    IMAGE_INSTALL_append = " iotedge-daemon iotedge-cli cgroup-lite rng-tools procps"

We enable virtualization layer as a distro feature and install a few
packages. With cgroup-lite we can mount cgroups on startup, we need
rng-tools.

Run bitbake again and compile our eMMC user partition image now:

    david.jenei@yocto-env:~/oe-core/build$ bitbake -k console-tdx-image

Enter UMS mode again, and write the contents of the

    Colibri iMX6 # ums 0 mmc 0

  [Computer on Module]: https://www.toradex.com/computer-on-modules
  [tutorials]: https://developer.toradex.com/knowledge-base/aws-greengrass-getting-started
  [instructions]: https://docs.microsoft.com/en-us/azure/iot-edge/how-to-install-iot-edge-linux
  [required packages]: https://www.yoctoproject.org/docs/1.7/yocto-project-qs/yocto-project-qs.html#ubuntu
  [tutorial]: https://developer.toradex.com/knowledge-base/board-support-package/openembedded-(core)
  [imx\_loader]: https://github.com/toradex/imx_loader
