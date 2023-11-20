tags: #sw #build
title: Make
maturity: 🌿
description: Tools for building software

Make
====

> **Go to:** [Links] · [My C++ Makefile project] · [Response to Make
> critics] · [Alternatives] · [CMake] · [Autotools]

Links
-----

-   [A Tutorial on Portable Makefiles]
-   [Rules of Makefiles]
-   [Makefile Tutorial]
-   [GNU Make guidelines]
-   [BSD Makefile example]

My C++ Makefile project
-----------------------

TODO: publish it!

TODO: Highlight some interesting parts

Usecase
-------

80% declarative 20% procedural

**Task automation**

Use make to give your projects a [unified interface]

**Build system**

Response to Make critics
------------------------

**Make commands aren't documented**

> When using Make, the Makefile and other source code is all the
> documentation that is provided.

Definitely not self-documenting, but we can have something like this:

    help:
        @echo "usage: make [OPTIONS] <target>"
        @echo "  Options:"
        @echo "    > VERBOSE Show verbose output for Make rules. Default 1. Disable with 0."
        @echo "    > SANITIZER Compile with GCC sanitizer. Default none. Options: address, thread, etc."
        @echo "Targets:"
        @echo "  debug: Builds all with debug flags"
        @echo "  release: Build with optimiser"
        @echo "  test: Build test executable"

[Or autogenerate this from comments]

**Makes does not come with batteries included**

> Want to interact with a web API? You need to have cURL installed. Want
> to parse a text or configuration file? You’ll need awk or sed.

What is the alternative here? How does a tool like `invoke` solves this?
pip install requests?

To check if an executable is installed we can use something like this:

    CPPCHECK = cppcheck

    define check_exec
        @command -v $(1) >/dev/null || (echo ERROR: $(1) not found in path >&2; exit 1)
    endef

    cppcheck:
        $(call check_exec, $(CPPCHECK))
        $(CPPCHECK) $(CPPCHECKFLAGS) $(SRC) $(SRC_TESTS) $(INCLUDE)

(??? or use `$(error text…)`)

**Make does not support cross platform builds**

> Want to make the CLI cross platform? You’ll need to handle differences
> between Windows, Mac and Linux packages and their shell quirks.

Ouch. This hits hard.

**Make is hard to debug**

With this:

    print-%:
        @echo $* = $($*)

We can at least print the variables:

    djen at xps in ~/example-cpp-project
    make print-CXXFLAGS
    CXXFLAGS = -std=c++17 -I/usr/include/png++
    djen at xps in ~/example-cpp-project
    make SANITIZER=thread print-CXXFLAGS
    CXXFLAGS = -std=c++17 -I/usr/include/png++ -fsanitize=thread

**Scaling**

> In Memfault’s codebase, we have around 100 tasks, most of which are
> namespaced under general top-level modules.

We can organise code in separate files `MyModule.include` and have them
included.

Alternatives
------------

**As a task runner or project CLI**

[Invoke] with [examples]

**As a build system for cross platform targets**

CMake, Meson

CMake
-----

Is CMake really the "cpp standard"? Check out the [Rise of Meson].

[Introduction to modern CMake]

Autotools
---------

[Autotools.info]

  [Make]: #make
  [Links]: #links
  [My C++ Makefile project]: #my-c-makefile-project
  [Usecase]: #usecase
  [Response to Make critics]: #response-to-make-critics
  [Alternatives]: #alternatives
  [CMake]: #cmake
  [Autotools]: #autotools
  [A Tutorial on Portable Makefiles]: https://nullprogram.com/blog/2017/08/20/
  [Rules of Makefiles]: http://make.mad-scientist.net/papers/rules-of-makefiles/
  [Makefile Tutorial]: https://makefiletutorial.com/
  [GNU Make guidelines]: https://interrupt.memfault.com/blog/gnu-make-guidelines
  [BSD Makefile example]: https://github.com/kristapsdz/lowdown/blob/master/Makefile
  [unified interface]: https://jakemccrary.com/blog/2016/11/30/unify-your-project-interfaces/
  [Or autogenerate this from comments]: https://jakemccrary.com/blog/2018/12/27/a-more-helpful-makefile/
  [Invoke]: https://interrupt.memfault.com/blog/building-a-cli-for-firmware-projects
  [examples]: https://github.com/memfault/memfault-firmware-sdk/blob/master/tasks/gdb.py
  [Rise of Meson]: https://gms.tf/the-rise-of-meson.html
  [Introduction to modern CMake]: https://cliutils.gitlab.io/modern-cmake/
  [Autotools.info]: https://autotools.info/autoconf/canonical.html
