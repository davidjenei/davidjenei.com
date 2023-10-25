tags: #linux #network #training

Linux networking
================

Essentials
----------

[Network protocols quick start]

Packet filtering
----------

Network engineers need OS API for packet inspections. Simple solution -
copy all packets to userspace - flood Filter packets before passing them
to userspace

Physical Layer
----------

Converts media dependent data into standard(?) data What makes a
phyiscal link? Link partner + Media + Connector + PHY(?) Media:
Copper(CAT-5,CAT-6,CAT-7), Fiber(XY nm), Radio Connector: 8P8C, SFP
Standard: GMII/MII (Gigabit Media Independent Interface/Media
Independent Interface) PHY: (Microchip
KSZ9031)\[[https://www.microchip.com/wwwproducts/en/KSZ9031\\\]]

Data-Link Layer
----------

Transferring data across physical link Encapsulating data into units
called frames - why? circuit switching vs packet switching We call these
devices NIC (Network Interface Controllers) Data-Link Layer = MAC Layer

-   ??? MAC: The MAC receives data and writes it to RAM using DMA

First layer of code in Linux: network device driver (eg. dwmac-imx,
r8169) dwmac-imx = Synopsys DesignWare® Ethernet MAC IP driver + imx
specific glue

Sometimes NIC = PHY + MAC (eg. PCIE/USB cards eg. Realtek RTL8111)

Physical + Data-Link Layer = ???
----------

IEEE 802 family. IEEE 802.3 (Ethernet) family (eg. 1000BASE-T,
1000BASE-X) - pairs, lanes, line-code, cable, max distance IEEE 802.11
(WLAN) IEEE 802.15 (PAN) - Zigbee, Bluetooth

MTU, advmss and mysterious TLS handshake failures

```
ip route add 192.168.1.0/24 dev eth0 advmss 1500
```

Linux + L1 + L2
----------

**iproute2** is a collection of utilities for controlling TCP / IP
networking and traffic control in Linux.

**ifconfig** originally appeared in 4.2BSD as part of the BSD TCP/IP
suite. The ifconfig utility is used to assign an address to a network
interface and/or configure network interface parameters.

ip vs ifconfing netstat vs ss

Network Layer
----------

Delivering packets to the destination host Breaking data into fragments
small enough for transmission via data link layer

Transport Layer
----------

Provide a communication service between applications on different hosts

  [Network protocols quick start]: https://www.destroyallsoftware.com/compendium/network-protocols?share_key=97d3ba4c24d21147
  [https://www.microchip.com/wwwproducts/en/KSZ9031\\\]]: https://www.microchip.com/wwwproducts/en/KSZ9031]
