Terminal control characters and signals
=======================================

> Caret notation is a notation for control characters in ASCII. The
> notation assigns `^A` to control-code 1, sequentially through the
> alphabet to `^Z` assigned to control-code 26 (0x1A). For the
> control-codes outside of the range 1–26, the notation extends to the
> adjacent, non-alphabetic ASCII characters.
>
> [Source]

`^C` - **SIGINT** - interrupt signal - default behaviour is to terminate
the process, can be caught or ignored, see `trap`, intention is to
shutdown gracefully

`^\` - **SIGQUIT** - dump core signal - user initiated terminate, but
not so graceful

`^Z` - **SIGSTOP** - pause - shells use this to implement job control -
send to background

     djen at xps in ~
     $ sleep 100
     ^Z
     [1]+  Stopped                 sleep 100
     djen at xps in ~
     $ jobs
     [1]+  Stopped                 sleep 100
     djen at xps in ~
     $ bg 1
     [1]+ sleep 100 &
     djen at xps in ~
     $ fg 1
     sleep 100
     ^C

`^D` - EOF

     djen at xps in ~
     $ cat
     send ^+D after this line
     send ^+D after this line

**SIGKILL** - process can't trap this, it cannot cleanup, and thus this
is a signal of last resort.

     djen at xps in ~
     $ sleep 100
     ^Z
     [1]+  Stopped                 sleep 100
     djen at xps in ~
     $ jobs -l
     [1]+ 45817 Stopped                 sleep 100
     djen at xps in ~
     $ kill -9 45817
     djen at xps in ~
     $ jobs -l
     [1]+ 45817 Killed                  sleep 100

SIGTERM vs SIGINT?

ttyUSB vs ttyACM
----------------

[What is the difference between /dev/ttyUSB and /dev/ttyACM?]

  [Source]: https://en.wikipedia.org/wiki/Caret_notation
  [What is the difference between /dev/ttyUSB and /dev/ttyACM?]: https://rfc1149.net/blog/2013/03/05/what-is-the-difference-between-devttyusbx-and-devttyacmx/
