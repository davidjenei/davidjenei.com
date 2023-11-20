tags: #linux #automotive
description: CAN networking in Linux
title: CAN

Controller Area Network
=======================

Linux CAN subsystem
-------------------

-   [Presentation from AGL2017] - Quick start
-   [ISO TP mainlined since 5.10]

Userspace
---------

-   [canutils] ofc
-   [scapy] - good doc for understading protocol layers
-   [collection of can bus packages and tools](https://gist.github.com/jackm/f33d6e3a023bfcc680ec3bfa7076e6960)

Clear DTC, tested on C4:

     from scapy.layers import can
     from scapy.contrib import cansocket, isotp
     from scapy.contrib.automotive.uds import UDS, UDS_TP, UDS_ER, UDS_CDTCI
     from scapy.contrib.automotive import uds

     socket = isotp.ISOTPNativeSocket('can0', sid=0x6a8, did=0x688,
     basecls=UDS)

     req = UDS() / UDS_TP()
     req = UDS() /
     UDS_CDTCI(groupOfDTCHighByte=0xff,groupOfDTCMiddleByte=0xff,groupOfDTCLowByte=0xff)
     #req = UDS() / UDS_ER(resetType=0x01)

     resp = socket.sr1(req)
     resp.show()

Hardware
--------

-   [Supported hardware]
-   My weapon: PCAN-USB - good old SJA1000
-   TODO: firmware update

> 1 	Not connected / optional +5V 2 	CAN-L 3 	GND 6 	GND 7 	CAN-H 9 	Not
> connected / optional +5V

Virtual CAN, bridges and network namespaces
-------------------------------------------

Network namespaces support CAN interfaces since version 4.12 and the
iproute2 package supports the creation of virtual CAN bridge interfaces.

It is possible to create virtual CAN bridges and attach one end of these
interfaces to the target containers. Then we can use cangw from the
can-utils package to install routing rules and forward messages from the
physical interfaces to the virtual ones. Utilising the existing kernel
infrastructure to route and filter CAN messages appears to be more
efficient than using a custom implementation running in userspace.
Additionally, application developers can use the regular SocketCAN
interface to read CAN messages and we do not need to use custom
userspace (and often inefficient) tools to route CAN messages.

    #!/usr/bin/env python3

    import json
    import sys
    from subprocess import check_output
    from subprocess import CalledProcessError
    from subprocess import STDOUT
    import logging
    import logging.handlers

    phy_cans = ('vcan0','can1','can2','can3')

    #logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)
    log = logging.getLogger(__name__)
    log.setLevel(logging.DEBUG)
    handler = logging.handlers.SysLogHandler(address = '/dev/log')

    formatter = logging.Formatter('%(module)s.%(funcName)s: %(message)s')
    handler.setFormatter(formatter)
    log.addHandler(handler)

    def _call_cmd(cmd):
        log.debug(' '.join(cmd))
        ret = check_output(cmd,stderr=STDOUT,timeout=1)
        return ret

    def vxcan_name(name, phy_if):
        return name + '-' + phy_if

    def rm_vxcan(provider, phy_if):
        devicename = vxcan_name(provider['name'],phy_if)
        cmd = [ "ip", "link", "del", devicename ]
        _call_cmd(cmd)

    def add_vxcan(provider, phy_if):
        devicename = vxcan_name(provider['name'],phy_if)
        peername = phy_if
        namespace = provider['network-container-name'] + '-ns'
       
        cmd = [ "docker", "inspect", "-f", "{{.State.Pid}}", provider['network-container-name']]
        pid = _call_cmd(cmd).strip().decode('ascii')
      
        cmd = [ "mkdir","-p", "/var/run/netns"]
        _call_cmd(cmd)
      
        cmd = [ "ln","-f", "-s", "/proc/" + pid + "/ns/net", "/var/run/netns/" + namespace]
        _call_cmd(cmd)

        cmd = [ "ip", "link", "add", devicename, "type", "vxcan", "peer", "name", peername, 
                "netns",namespace ]
        _call_cmd(cmd)

        for filter in provider['filters']:
            if filter['source'] == phy_if:
                cmd = [ "cangw", "-A", "-s", filter['source'], 
                      "-d", devicename, "-e", "-f", filter["filter"]]
                _call_cmd(cmd) 

        cmd = [ "ip", "link", "set", devicename ,"up" ]
        _call_cmd(cmd)

        cmd = [ "ip", "netns", "exec", namespace ,"ip","link","set", peername,"up" ]
        _call_cmd(cmd)
            
    def main():

        if len(sys.argv) != 2:
            log.error("Usage: can-routing <config JSON>")
            sys.exit(1)

        with open(sys.argv[1]) as file:
            conf = json.load(file)
        
        for provider in conf['providers']:
            for can in phy_cans: 
                 try:
                     rm_vxcan(provider, can)
                 except CalledProcessError as e:
                     log.debug(e.output.decode('ascii').strip())
                     log.debug("Unable to remove {} from {}, continue..."
                              .format(can, provider['name']))
                 try:
                     add_vxcan(provider, can)
                     log.info('{} interface installed for {}'
                              .format(can,provider['network-container-name']))
                 except CalledProcessError as e:
                     log.fatal(e.output.decode('ascii').strip())
                     log.fatal("Unable to add {} for {}".format(can,provider['name']))

    if __name__ == "__main__":
        main()

Config:

    {
        "version": "1.0",
        "providers": [
                    {
                        "name": "public",
                        "network-container-name": "public",
                        "filters": [
                            {
                                "source": "vcan0",
                                "filter": "0:0"
                            },
                            {
                                "source": "can0",
                                "filter": "0:0"
                            },
                            {
                                "source": "can1",
                                "filter": "18FEF5B4:1FFFFFF0"
                            }
                        ]
                     }]
    }

  [Presentation from AGL2017]: https://wiki.automotivelinux.org/_media/agl-distro/agl2017-socketcan-print.pdf
  [ISO TP mainlined since 5.10]: https://elixir.bootlin.com/linux/v5.10-rc1/source/net/can/isotp.c
  [canutils]: https://github.com/linux-can/can-utils
  [scapy]: https://github.com/secdev/scapy/blob/master/doc/scapy/layers/automotive.rst
  [Supported hardware]: https://elixir.bootlin.com/linux/v5.10-rc1/source/drivers/net/can
