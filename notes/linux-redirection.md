tags: #linux #terminal
title: Bash redirections
description: A life without netcat

Bash redirections
=================

     echo Hello world! | (exec 3<>/dev/tcp/termbin.com/9999; cat >&3; cat <&3;
     exec 3<&-)

> If host is a valid hostname or Internet address, and port is an
> integer port number or service name, Bash attempts to open the
> corresponding TCP socket

1.  open new descriptor

    > The redirection operator `[n]<>word` causes the file whose name is
    > the expansion of word to be opened for both reading and writing on
    > file descriptor n

2.  redirect `cat` output to socket

3.  redirect response to `cat` input

    > If \>&- or \<&- is preceded by {varname}, the value of varname
    > defines the file descriptor to close.

4.  close

[Manual]

  [Bash redirections]: #bash-redirections
  [Manual]: https://www.gnu.org/software/bash/manual/html_node/Redirections.html
