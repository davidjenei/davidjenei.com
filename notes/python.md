tags: #python
title: Python
description: Zen and philosophy

Python
======

Zen
---

    >>> import this

[Stop writing classes][1]
-------------------------

1.  if your class has two methods and one is `__init__`, it is probably
    not a class
2.  if you create an object, call one method then throw it away,
    probably you don't need that class
3.  can I write this 3 lines of code later? if yes, just do that later.
4.  if it bundles related data, that you actually use in functions, it's
    probably a class
5.  if your subclass only implements `__init__`, you probably don't need
    a new class

Working backwards
-----------------

Imagine what the user will type when uses your code. Then implement
that.

[Scripts inside modules][2]
---------------------------

> I'm -1 on this and on any other proposed twiddlings of the **main**
> machinery. The only use case seems to be running scripts that happen
> to be living inside a module's directory, which I've always seen as an
> antipattern. To make me change my mind you'd have to convince me that
> it isn't.

Monkey patching
---------------

> guerrilla patch, which referred to changing code sneakily – and
> possibly incompatibly with other such patches – at runtime.

Nice projects
-------------

-   [Tornado]

Packaging
---------

Pip, wheel?

[RPM + Python]

Python and C
------------

Cython, SWIG, pybind11?

> Cython is the most general tool. It can be used to do anything from
> making bindings from C/Cpp to Python, Python to C/Cpp, to writing
> compiled “Python-like” code in an intermediate layer that can be used
> for managing your wrappers or just writing performant code.
>
> [gyrovagueGeist]

  [Python]: #python
  [The purpose of these notes]: #the-purpose-of-these-notes
  [Zen]: #zen
  [Stop writing classes]: #stop-writing-classes
  [Working backwards]: #working-backwards
  [Scripts inside modules]: #scripts-inside-modules
  [Monkey patching]: #monkey-patching
  [Nice projects]: #nice-projects
  [Packaging]: #packaging
  [Python and C]: #python-and-c
  [1]: https://www.youtube.com/watch?v=o9pEzgHorH0&feature=youtu.be
  [2]: https://mail.python.org/pipermail/python-3000/2007-April/006793.html
  [Tornado]: https://github.com/tornadoweb/tornado
  [RPM + Python]: https://grimoire.carcano.ch/blog/packaging-a-python-wheel-as-rpm/
  [gyrovagueGeist]: https://news.ycombinator.com/item?id=36778617
