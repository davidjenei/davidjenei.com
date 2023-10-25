tags: #sw #debug
title: Debugging
description: Beyond printf

Debugging
=========

> **Go to**: [When we have source code] · [We don't have source code:
> ask the OS] · [We don't have source code: look at the binary] · [When
> we debug the OS] · [Coredump]

> **Last updated**: [%date]

When we have source code
------------------------

Fire up a debugger:

-   [GDB Tutorial]
-   Pro .gdbinit

Don't forget the nice hexdump macros. Write python scripts for parsing
buffer content (when debugging a serial protocol).

Or start tracing:

-   print debug messages

How to decide which one to use? Debugging stops the execution, printing
can only slow the execution down. Is that a problem? [See RTT]

**Race condition**:

Try compiling with -fsanitize=thread. If that is not an option, try to
reproduce the bug:

    while :; do ./testsuite "Testcase with race condition" || break; done

Cpu hogs can speed things up:

    stress -c 4

If you work in a stress-free environment:

    yes

Now in GDB:

    gdb --args ./testsuite "Race condition"

Run forever:

    set pagination off
    break exit
    commands
    run
    end

**Recover lost PC**:

Set program counter to $lr (link register).

    Thread 1 "testsuite_pvxs" received signal SIGSEGV, Segmentation fault.
    0x0000ffffec001600 in ?? ()                                                                                                
    (gdb) bt
    #0  0x0000ffffec001600 in ?? ()
    #1  0x0000ffffffffedd0 in ?? ()
    Backtrace stopped: not enough registers or memory available to unwind further
    (gdb) set $pc = $lr
    (gdb) up 2
    #2  0x0000fffff7f554c8 in non-virtual thunk to pvxs::client::SubscriptionImpl::cancel() () from /usr/lib64/libpvxs.so.1.0  

**Make aliases for long arguments**

Some machines doesn't have persistent shell history by default. Try not
to lose long commands.

    alias gdb-my-failing='gdb --args ./testsuite "MyFailingTestcase: Do this and that" '

We don't have source code: ask the OS
-------------------------------------

> The Unix kernel is a traffic cop that mediates different demands for
> time, memory, disks, and so on. - Unix Power Tools

Ask the cops.

-   strace - [What problems do people solve with strace], don't forget
    to filter with `-e`
-   logger - just print events from different processes eg. init scripts
-   stress - thermal issues, race conditions, io load, latency

> Latency, from a general point of view, is a time delay between the
> cause and the effect of some physical change in the system being
> observed. - wiki

-   lsof - file descriptor leak
-   `LD_PRELOAD`

We don't have source code: look at the binary
---------------------------------------------

-   readelf

When we debug the OS
--------------------

Add some prints:

    dev_info(&pdev->dev, "Why are we here? \n");

now `dmesg`

Catching device events:

-   `cat /proc/interrupts`
-   `udevadm info -a -n /dev/sda | less`

The `/sys`:

-   get some device info
-   control devices - pwm

Coredump
--------

Check if systemd coredump collection is enabled.

  [Debugging]: #debugging
  [When we have source code]: #when-we-have-source-code
  [We don't have source code: ask the OS]: #we-dont-have-source-code-ask-the-os
  [We don't have source code: look at the binary]: #we-dont-have-source-code-look-at-the-binary
  [When we debug the OS]: #when-we-debug-the-os
  [Coredump]: #coredump
  [GDB Tutorial]: https://developers.redhat.com/blog/2021/04/30/the-gdb-developers-gnu-debugger-tutorial-part-1-getting-started-with-the-debugger#why_another_gdb_tutorial_
  [See RTT]: https://www.segger.com/products/debug-probes/j-link/technology/about-real-time-transfer/
  [What problems do people solve with strace]: https://jvns.ca/blog/2021/04/03/what-problems-do-people-solve-with-strace/
