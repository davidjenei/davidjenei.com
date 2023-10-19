tags: #linux #kernel

Kernel module development notes
===============================

Motivation
----------

Why develop a custom device driver or a kernel mode service?

-   Manage exclusive hardware access
-   Reduced event latency - access low-level resources like interrupts
-   Device accessibility can be controled by file permissions
-   Access data structures that are not exported out of kernel space
-   Higher execution privilege, +impact, +security

> in short: if you need to support a new device or implement low-latency
> low-level functionality composed of multiple device drivers

How to get started?

-   don't start from scratch

-   when writing new device drivers - look up examples on how other
    drivers use peripheral bus framework (spi, i2c, usb, eg.
    `drivers/net/can/spi/mcp251x.c`)

-   when writing combined drivers - start modifying an existing one (eg.
    `drivers/iio/adc/mxs-lradc-adc.c`) and add new functionality

-   misc drivers - create a new misc driver (`my-misc-driver.c`)

Access hardware from userspace
------------------------------

-   Userspace application
-   C Library
-   System Call Interface (open, read, write, ioctl)
-   Framework (block, character, subsystems: network, iio)
-   Driver (mcp25xx) - this is what we program
-   Bus infrastructure (spi, usb)
-   Hardware

> /dev entry: misc character device, read/write + ioctl typically used
> by applications to access devices
>
> /sys entry: read/write for simple shell scripts typically used by
> applications to manage devices
>
> eg. use /dev to access a storage device /sys to tune

Makefile
--------

-   two build stages

-   needs kernel built from source or linux-headers package installed

-   compiler flags with `ccflags`

-   out-of-tree build, separete output directory

<!-- -->

    ifneq ($(KERNELRELEASE),)

    my-module-objs := my-plat-drv.o my-other-source.o
    obj-m := my_module.o
    ccflags-y +=-DDEBUG -DCONFIG_PWM -DCONFIG_HAVE_PWM

    else

    # Full kernel source
    KDIR := $(HOME)/linux
    BUILD_DIR ?= $(PWD)/build
    BUILD_DIR_MAKEFILE ?= $(PWD)/build/Makefile

    # linux-header-* packages, created by make header_install
    #KDIR := /lib/modules/$(shell uname -r)/build

    default: $(BUILD_DIR_MAKEFILE)
    	$(MAKE) -C $(KDIR) M=$(BUILD_DIR) src=$(PWD) modules

    $(BUILD_DIR):
    	mkdir -p "$@"

    $(BUILD_DIR_MAKEFILE): $(BUILD_DIR)
    	touch "$@"

    all:
    	$(MAKE) -C $(KDIR) M=$$PWD

    clean:
    	$(MAKE) -C $(KDIR) M=$(BUILD_DIR) src=$(PWD) clean
    endif

Device tree
-----------

-   [documentation]
-   what is device tree? - data structure and language for describing
    hardware
-   platform drivers vs dynamically enumerated drivers

Device tree binding
-------------------

-   resource mechanism - irq lines, gpios, pwms

<!-- -->

    apbx@80040000 {
      pwm: pwm@80064000 {
        pinctrl-names = "default";
        pinctrl-0 = <&pwm2_pins_a>;
        status = "okay";
    };
      my-module: lradc@80050000 {
        error-gpios = <&gpio1 6 0>;
        status-gpios = <&gpio1 7 0>;
        adc-gpios = <&gpio1 4 0>;
        txen-gpios = <&gpio1 20 0>;
        uart-gpios = <&gpio1 21 0>;
        relayA-gpios = <&gpio2 3 0>;
        relayB-gpios = <&gpio2 4 0>;
        pwms = <&pwm 2 1000000 0>;
        compatible = "my,my-module";
        status = "okay";
    };

**Aliases**

    i2c = &i2c

???

Minimal code
---

```
// SPDX-License-Identifier: GPL-2.0
#include <linux/init.h>
#include <linux/module.h>

/* Add your code here */
static int __init hello_version_init(void)
{
	pr_info("Hello, World!\n");
	return 0;
}

static void __exit hello_version_exit(void)
{
	pr_info("Goodbye, World!\n");
}

module_init(hello_version_init);
module_exit(hello_version_exit);
//MODULE_INFO(vermagic, "5.10.16-rockchip64 SMP preempt mod_unload aarch64");
MODULE_LICENSE("GPL");
```

  [documentation]: https://www.kernel.org/doc/Documentation/devicetree/usage-model.txt
