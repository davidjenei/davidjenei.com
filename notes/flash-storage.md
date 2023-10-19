tags: #embedded

eMMC vs SD
==========

> Embedded MultiMediaCard, usually referred to as eMMC or e.MMC, is a
solid-state storage standard derived from the MMC standard. MMC is a
JEDEC standard.
>
> [Toradex: eMMC](https://developer.toradex.com/knowledge-base/emmc-linux)

SD started as a derivative standard from MMC. SD is covered by patents.

- card type memories can suffer from connector issues

NOR vs NAND
===========

> NOR and NAND are raw storage devices. The main difference between NAND
> and NOR is that NOR allows random access, doesn't need error correction
> as well as has higher cost-per-bit. NAND on the other side can only be
> read in pages, some bits in a page may be wrong and need to be corrected
> by an error correction mechanism.
>
> eMMC Flash combines NAND memory with a built-in controller.
>
> [Toradex: What you should know about
> flash](https://www.toradex.com/blog/what-you-should-know-about-flash-storage)

Bit densitiy
============

SLC, pSLC, MLC, TLC, etc.

Sandisk industrial
==================

CMD56

Health Status is an estimated percent life used based on the amount of
TBW1 the NAND memory has experienced relative to the SD card device TBW
ability. Values reported in hexadecimal in 1% increments with 0x01
representing 0.0% to 0.99% used. A value of 0x64 indicates 99 to 99.99%
of the ability have been used. The SD card storage device may
accommodate writes in excess of the 100% expected life limit. Note that
although this is possible, entry into a read only mode could occur upon
the next write cycle.

Note: 32 byte one-time programmable product string

Micron
======

TLC/QLC percentage utilizations acquired from data block offset\[8\].
User data is stored in TLC/QLC NAND area.

SLC percentage utilizations acquired from data block offset\[9\]. FW
system blocks and some internal cache buffers are deployed to SLC
configured range.
