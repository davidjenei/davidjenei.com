tags: #linux #imx
title: i.MX kernel variants
description: linux-fslc, linux-imx, linux-fslc-imx

FSL community BSP
=================

The FSL Community BSP is a community-driven project to provide and
maintain Board Support Package (BSP) metadata layers for use in
OpenEmbedded and Yocto Project with Freescale’s SoCs.

[http://freescale.github.io/\#]

Kernel
------

linux-fslc: Linux kernel based on mainline kernel used by FSL Community
BSP in order to provide support for some backported features and fixes,
or because it was applied in linux-next and takes some time to become
part of a stable version, or because it is not applicable for
upstreaming.

linux-imx: Linux Kernel provided and supported by NXP with focus on i.MX
Family Reference Boards. It includes support for many IPs such as GPU,
VPU and IPU.

linux-fslc-imx: Linux kernel based on NXP 4.1.15-1.2.0 GA release, used
by FSL Community BSP in order to provide support for i.MX based
platforms and include official Linux kernel stable updates, backported
features and fixes coming from the vendors, kernel community or FSL
Community itself.

linux-toradex: Linux kernel for Toradex Freescale i.MX based modules.

NXP BSP kernel
--------------

[https://source.codeaurora.org/external/imx/linux-imx/refs/]

Toradex BSP
-----------

based on linux-imx toradex\_4.14-2.3.x-imx

Webkit
------

[https://github.com/Igalia/meta-webkit/wiki/i.MX6]

kernel - mainline
-----------------

DRM\_ETNAVIV - "ETNAVIV (DRM support for Vivante GPU IP cores)" - needs
FIRMWARE

DRM\_IMX - "DRM Support for Freescale i.MX" depends on IMX\_IPUV3\_CORE

- tristate "IPUv3 core support" - needs FIRMWARE

DRM\_IMX\_HDMI - "Freescale i.MX DRM HDMI"

kernel - imx (toradex)
----------------------

DRM\_VIVANTE=y FB\_MXC\_HDMI=y

  [http://freescale.github.io/\#]: http://freescale.github.io/#
  [https://source.codeaurora.org/external/imx/linux-imx/refs/]: https://source.codeaurora.org/external/imx/linux-imx/refs/
  [https://github.com/Igalia/meta-webkit/wiki/i.MX6]: https://github.com/Igalia/meta-webkit/wiki/i.MX6
