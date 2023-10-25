tags: #sw #dependency
title: Dependency management
description: Eliminate them

Dependencies and package managers
=================================

Explicitly declare and isolate dependencies
-------------------------------------------

> Never rely on implicit existence of system-wide packages

[https://12factor.net/dependencies]

Trust
-----

Managing dependencies is about managing trust. Decentralised package
hosting is not supported using most package managers. Packages may
became abandoned over time, but the key issue is security. The purpose
of a centralised system is to guarantee security.

Centralised services propose an obvious risk. The question in which
organisation we put our trust and what can we do to mitigate the risk.

Source code vs binary
---------------------

Backing up dependencies is a way to manage this. We have two options
here: save artifacts (binaries) or save the source code.

Embedded firmware: Build from scratch
-------------------------------------

-   baremetal - single repo
-   rtos - still single repo, include os sources
-   linux - distro generators + custom userspace sw

Embedded firmware: Build OS from scratch but pull packages from a feed
----------------------------------------------------------------------

-   elbe

App development: OS level package managers
------------------------------------------

-   build custom packages, declare dependencies
-   may rely on implicit existence of system packages

App development: Application level package managers
---------------------------------------------------

**Purpose**:

-   declare compile time dependencies
-   declare runtime dependencies
-   isolate dependencies (eg. virtualenv)

**Features**:

-   offline package installation
-   remote artifact repository
-   multi-arch support
-   custom build steps

[Monorepos and Polyrepos]
-------------------------

Pros:

-   simple versioning - everything is in one place
-   system configuration (what is the latest stable version of a
    component) managed centrally

Cons:

-   deal with git submodules - clone recursive, submodule update, etc.

**Challenges**

> Monorepo involves mostly challenges around scaling the organization in
> a single repo. Polyrepo involves mostly challenges with coordination.

**Transition**

> Splitting one repo is easier than combining multiple repos.

Combine polyrepos with a package manager
----------------------------------------

Specify all system component versions in a repository as code.

-   monorepo coordinates the full system build
-   can have components as submodules
-   don't need to manage a full dependency graph for the system
-   CI tests only the working configuration

Combine polyrepos with a repo management tool
---------------------------------------------

[man repo]

  [https://12factor.net/dependencies]: https://12factor.net/dependencies
  [Monorepos and Polyrepos]: https://github.com/joelparkerhenderson/monorepo-vs-polyrepo
  [man repo]: https://manpages.ubuntu.com/manpages/focal/man1/repo.1.html
