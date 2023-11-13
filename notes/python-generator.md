title: Iterables, generators, yield
tags: #python
maturity: 🌿

Iterables
=========

Iterator
--------

    >>> a = [1, 2, 3, 4, 5]
    >>> iterator = iter(a)
    >>> type(iterator)
    <class 'list_iterator'>
    >>> next(iterator)
    1
    >>> next(iterator)
    2

Generator
---------

A generator is an iterator: it's just a shortcut in Python.

    def fibo(stop):
        a, b = 0, 1
        while a < stop:
            yield a
            a, b = b, a+b

`yield` is like `return`, but the function is stateful.

    >>> g = fibo(10)
    >>> next(g)
    0
    >>> next(g)
    1
    >>> next(g)
    1
    >>> next(g)
    2

Generator expression
--------------------

Syntactic sugar for generators.

    (num ** 2 for num in range(10))

Comprehensions
--------------

Pythonic way to create new collections from existing ones (iterables) or
iterators. Typically we use this to filter, map or reduce data.

**List comprehension**

    import requests
    res = requests.get("https://pokeapi.co/api/v2/pokemon/bulbasaur").json()
    [a["ability"]["name"] for a in res["abilities"]]

**Set comprehension**

    {n for n in fibo(10)}

**Dict comprehension**

Recipe: Build a deck of cards with comprehensions
-------------------------------------------------

> From "Fluent Python"

  [Iterables]: #iterables
  [Iterator]: #iterator
  [Generator]: #generator
  [Generator expression]: #generator-expression
  [Comprehensions]: #comprehensions
  [Recipe: Build a deck of cards with comprehensions]: #recipe-build-a-deck-of-cards-with-comprehensions
