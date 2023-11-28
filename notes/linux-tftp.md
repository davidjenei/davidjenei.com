title: Network boot
tags: #linux
description: u-boot, pxe, tftp, nfs

Network boot with u-boot
========================

U-boot setup
------------

[Documentation]

```
setenv serverip 192.168.1.3
pxe get
pxe boot
```

TFTP setup
---

```
menu title Select the boot mode
 DEFAULT nfs
 TIMEOUT 20
 LABEL nfs
        KERNEL zImage
        FDT imx6q-apalis-ixora-v1.1.dtb
        APPEND root=/dev/nfs nfsroot=192.168.1.3:/srv/fs/debian-rootfs,nfsvers=4 ip=dhcp rootwait rw earlyprintk console=ttymxc0,115200
```

NFS setup
---

  [Network boot with u-boot]: #network-boot-with-u-boot
  [U-boot setup]: #u-boot-setup
  [Documentation]: https://elixir.bootlin.com/u-boot/latest/source/doc/README.pxe
