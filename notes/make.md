tags: #sw #build
title: Make
maturity: 🌿
description: Tools for building software

Make
====

> **Go to:** [Links] · [Usecase]· [Response to Make
> criticism]  · [My C++ Makefile project] · [Alternatives] · [CMake] · [Autotools]

Links
-----

-   [A Tutorial on Portable Makefiles]
-   [Rules of Makefiles]
-   [Makefile Tutorial]
-   [GNU Make guidelines]
-   [BSD Makefile example]

Usecase
-------

What is a `Makefile?` It's a logic program that is both declarative and
procedural. Usually 80% declarative and 20% procedural. But why both? To understand
this, we should look into the primary usecase for make: software compilation.
Software compilation means running a series of instructions depending on what
files have changed to produce other files. We can use declarative programming
to specify what is effected by a file change, and use procedural programming to
describe what needs to be done to create certain files.

**Build system**

`make` is suitable for your project as a build system: if you don't need a meta build system.

If you:

* are building software for POSIX only.
* need to build only a reasonable amount of artifacts
* want to reduce complexity without introducing another complicated tool
* when your build system doesn't need to execute hundreds of different commands to build your artifacts

But avoid `make` if:

* you want spaces in filenames

**Task automation**

In genaral `make` is probably suitable for you project as a task automation tool.
Give your projects a [unified interface], save frequently used commands to
execute repetitive tasks quickly.

Good things:

* available everywhere in POSIX
* old
* human friendly documentation
* use any shell command easily
* fine tune everything quickly

Bad things:

* `$$$$` hell
* `.PHONY` is ugly
* can be invoked recursively
* mental model needs some practice: combining procedural and declarative is hard

Is this the right tool the job?
---

First we have to define a scope to work in. If the problem requires deep understanding of the assembly code,
we need to have deep understanding of the compilers. If all your interaction with the OS can be solved with the help of cmake modules and you don't care about what happens in the background that is also a valid problem scope.

Make is suitable your task if you want to solve it with multiple tools following the UNIX philosophy.

Response to Make criticism
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

That is correct.

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

If your project is less complex then the Linux kernel, there is chance that you can handle it.

My C++ Makefile project
-----------------------

Features:

* set individual gcc args for objects - private variable
* generate dep files - build object when header changed
* build executable variants - target specific variable
* linters, coverage, formatter, line count
* help

Portable Makefiles?
---

Notable GnuMake features:

* patsubst
* pattern rules
* define, call

Portable syntaxes:

* `!=`

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
  [Response to Make criticism]: #response-to-make-criticism
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
