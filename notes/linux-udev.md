tags: #linux #kernel

udev
====

Trigger
-------

    udevadm info -a -n /dev/sda | less
    sudo udevadm test -a add $(udevadm info -q path /dev/sda ) 2>&1 | less
    sudo udevadm control --reload

Rules
-----

    SUBSYSTEM=="net", ACTION=="add", KERNELS=="2090000.flexcan", NAME="can1"
    SUBSYSTEM=="net", ACTION=="add", KERNELS=="2094000.flexcan", NAME="can2"
    SUBSYSTEM=="net", ACTION=="add", DRIVERS=="mcp251x", KERNELS=="spi1.0", NAME="can3"
