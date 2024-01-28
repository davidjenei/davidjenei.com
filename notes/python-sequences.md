title: Sequences
tags: #python

Sequences
=========

Tuple
-----

The immutable sequence. Primary usecases:

A record:

    >>> name, age, _ = ('Alice', 30, 'Software engineer')
    >>> name
    'Alice'
    >>> age
    30

A list that never changes:

    >>> suits = ('diamonds', 'clubs', 'hearts', 'spades')
    >>> suits.
    suits.count(  suits.index(

But it's not transitive, references might point to mutable objects.

**Named tuple**

Tuple factory function. Create tuples that look like a dict: look up members
using their names instead of indexes. When unpacking a record, we may mix up
the order.

Read more about [named tuples](https://miguendes.me/everything-you-need-to-know-about-pythons-namedtuples)

Unpacking iterables
-------------------

Unpacking:

    >>> name, age, *_ = ('Alice', 30, 'Software engineer', 'Budapest')

Pattern matching with sequences
-------------------------------

Python 3.10!

<https://github.com/gvanrossum/patma/tree/3ece6444ef70122876fd9f0099eb9490a2d630df>

    match points:
    case []:
        print("No points")
    case [Point(0, 0)]:
        print("The origin")
    case [Point(x, y)]:
        print(f"Single point {x}, {y}")
    case [Point(0, y1), Point(0, y2)]:
        print(f"Two on the Y axis at {y1}, {y2}")
    case _:
        print("Something else")


  [Sequences]: #sequences
  [Tuple]: #tuple
  [Unpacking iterables]: #unpacking-iterables
  [Pattern matching with sequences]: #pattern-matching-with-sequences
