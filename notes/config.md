Configuration management
========================

Order of precedence for resolving arguments
-------------------------------------------

1.  Command line.
2.  Config file thats name is declared on the command line.
3.  Environment vars
4.  Local config file
5.  Global config file

Specifying configuration files
------------------------------

**Specify as argument or flag**

`man hostname`:

> When called with one argument or with the --file option, the commands
> set the host name or the NIS/YP domain name.

**Look for a specific filename**

`man make`:

> make executes commands in the makefile to update one or more target
> names, where name is typically a program. If no -f option is present,
> make will look for the makefiles GNUmakefile, makefile, and Makefile,
> in that order.

Use if it's project configuration that needs version control. Otherwise
prefer explicit over implicit and expect file path.

**Load from default path**

`man podman`:

> CONFIGURATION FILES containers.conf
> (/usr/share/containers/containers.conf,
> /etc/containers/containers.conf,
> $HOME/.config/containers/containers.conf)

Use if it's specific for a system. Don't forget to ship a default
configuration file. Add flags that can be used to skip all
initializations (by giving the name "none").

Command line options
--------------------

Terminology: positional arguments and options(flags)

[Frequently used Unix options]

[clig.dev]

[The art of command line]

  [Frequently used Unix options]: http://www.catb.org/~esr/writings/taoup/html/ch10s05.html
  [clig.dev]: https://clig.dev/#foreword
  [The art of command line]: https://github.com/jlevy/the-art-of-command-line
