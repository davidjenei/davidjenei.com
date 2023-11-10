title: Built-in types
tags: #python

Built-in types
==============

Objects
-------

> Objects are Python’s abstraction for data - [Documentation]

Python makes no distinction between basic and derived types as other
programming languages may do. Everything is an object, a specific
instance of a category called type.

    >>> import collections
    >>> type(collections)
    <class 'module'>
    >>> type(collections.namedtuple)
    <class 'function'>
    >>> type(5)
    <class 'int'>
    >>> type([])
    <class 'list'>

Functions are [first class objects].

    >>> len("hello")
    5
    >>> len.__doc__
    'Return the number of items in a container.'

Attributes (`.__doc__`) are objects, owned by other objects. We can look
them up by name. The type of an object defines the attributes it has,
and the way we can access them.

> Every object has an identity, a type and a value. An object’s identity
> never changes once it has been created; you may think of it as the
> object’s address in memory. The ‘is’ operator compares the identity of
> two objects

Out of these, only the value of an object can change over time.

    >>> a = 5
    >>> b = 5
    >>> a is b
    True

Sometimes the language uses equal by value (implemented as a hashmap),
instead of equal by id:

    >>> d = {1: 'a', True: 'b', 1.0: 'c'}
    >>> d
    {1: 'c'}

Built-in types
--------------

    >>> help('TYPES')

-   numerics: int, bool, float, complex
-   **immutable** sequences: str, tuple, byte
-   **mutable** sequences: list
-   mappings: dict
-   set
-   misc: none, ellipsis
-   classes, instances, exceptions

Another grouping

-   container sequences: list, tuple
-   flat sequences (also containers): str, bytes

Terminology
-----------

Categories for objects with common operations:

**[Sequence]**

-   `in`,`len()`, `min()`,`max()` and ordered
-   `list`, `tuple`, `str`, `bytes`
-   `dict` is not a sequence, but subscriptable
-   `set` is not a sequence and not subscriptable

**Container**

-   can store other any objects, as opposed to *flat* types
-   with built-in types it also means iterable
-   `.__iter__`
-   not all sequences are iterable

**Mutable / Immutable**

-   can be changed after creation
-   not transitive

Recipe: Mutable argument defaults are bad
-----------------------------------------

Schoolbus from "Fluent Python". Strange things happen when bus starts
empty (passengers became an alias).

    __init__.__defaults__

Ok, but what about the basketball team getting on?

Think twice before assigning a mutable argument to a class attribute.

Recipe: Avoid mutable function arguments
----------------------------------------

> **Backlinks:** [The problem with dict]

  [Built-in types]: #built-in-types
  [Objects]: #objects
  [1]: #built-in-types-1
  [Terminology]: #terminology
  [Recipe: Mutable argument defaults are bad]: #recipe-mutable-argument-defaults-are-bad
  [Recipe: Avoid mutable function arguments]: #recipe-avoid-mutable-function-arguments
  [Documentation]: https://docs.python.org/3/reference/datamodel.html#:~:text=Objects%20are%20Python%27s%20abstraction%20for,a%20type%20and%20a%20value.
  [first class objects]: https://en.wikipedia.org/wiki/First-class_function
  [Sequence]: https://docs.python.org/3/library/stdtypes.html#common-sequence-operations
  [The problem with dict]: ./python-mappings.md
