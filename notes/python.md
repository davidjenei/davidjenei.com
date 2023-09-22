# Python

## Useful links

-   [My favourite cheatsheet]

## Zen

    >>> import this

## [Stop writing classes]

1.  if your class has two methods and one is `__init__`, it is probably
    not a class
2.  if you create an object, call one method then throw it away,
    probably you don't need that class
3.  can I write this 3 lines of code later? if yes, just do that later.
4.  if it bundles related data, that you actually use in functions, it's
    probably a class
5.  if your subclass only implements `__init__`, you probably don't need
    a new class

## Working backwards

Imagine what the user will type when uses your code. Than implement
that.

## Scripts inside modules

> I'm -1 on this and on any other proposed twiddlings of the **main**
> machinery. The only use case seems to be running scripts that happen
> to be living inside a module's directory, which I've always seen as an
> antipattern. To make me change my mind you'd have to convince me that
> it isn't. - [Source]

## Snippets from [Effective Python: 59 ways..]

**Meta classes**

Call a function automatically in a class definition:

> Another common use of metaclass is to automatically register types in
> your program. Registration is useful for doing reverse lookups, where
> you need to map a simple identifier back to a corresponding class.
>
> For example, say you want to implement your own serialized
> representation of a Python object using JSON. You need a way to take
> an object and turn it into a JSON string. Here, I do this generically
> by defining a base class that records the constructor parameters and
> turns them into a JSON dictionary.

**@property**

> For example, say you want to define a new class that represents a row
> in your customer database. You'd like a corresponding property on the
> class for each column in the database table. To do this, here I define
> a descriptor class to connect attributes to column names.

## Monkey patching

> guerrilla patch, which referred to changing code sneakily – and
> possibly incompatibly with other such patches – at runtime.

## Nice projects

-   [Tornado]

## Packaging

Pip, wheel?

[RPM + Python]

## Python and C

Cython, SWIG, pybind11?

> Cython is the most general tool. It can be used to do anything from
> making bindings from C/Cpp to Python, Python to C/Cpp, to writing
> compiled “Python-like” code in an intermediate layer that can be used
> for managing your wrappers or just writing performant code.
>
> [gyrovagueGeist]

  [My favourite cheatsheet]: https://referenceguide.dev/cheatsheet/python3.html
  [Stop writing classes]: https://www.youtube.com/watch?v=o9pEzgHorH0&feature=youtu.be
  [Source]: https://mail.python.org/pipermail/python-3000/2007-April/006793.html
  [Effective Python: 59 ways..]: https://www.goodreads.com/en/book/show/23020812
  [Tornado]: https://github.com/tornadoweb/tornado
  [RPM + Python]: https://grimoire.carcano.ch/blog/packaging-a-python-wheel-as-rpm/
  [gyrovagueGeist]: https://news.ycombinator.com/item?id=36778617
