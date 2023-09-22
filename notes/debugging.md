# Debugging

## When we have source code

Fire up a debugger:

-   [GDB Tutorial]
-   Pro .gdbinit

Don't forget the nice hexdump macros. Write python scripts for parsing
buffer content (when debugging a serial protocol).

Or start tracing:

-   print debug messages

How to decide which one to use? Debugging stops the execution, printing can only slow the
execution down. Is that a problem? [See RTT]

## We don't have source code: go ask the OS

-   strace - [What problems do people solve with strace], don't forget
    to filter with `-e`
-   logger - just print events from different processes eg. init scripts
-   stress - thermal issues, race conditions, io load, latency

> Latency, from a general point of view, is a time delay between the
> cause and the effect of some physical change in the system being
> observed. - wiki

-   lsof - file descriptor leak
-   `LD_PRELOAD`

## We don't have source code, look at the binary

-   readelf

## When we debug the OS

Add some prints:

    dev_info(&pdev->dev, "Why are we here? \n");

now `dmesg`

Catching device events:

-   `cat /proc/interrupts`
-   `udevadm info -a -n /dev/sda | less`

The `/sys`:

-   get some device info
-   control devices - pwm

Attach debugger:

  [GDB Tutorial]: https://developers.redhat.com/blog/2021/04/30/the-gdb-developers-gnu-debugger-tutorial-part-1-getting-started-with-the-debugger#why_another_gdb_tutorial_
  [See RTT]: https://www.segger.com/products/debug-probes/j-link/technology/about-real-time-transfer/
  [What problems do people solve with strace]: https://jvns.ca/blog/2021/04/03/what-problems-do-people-solve-with-strace/
