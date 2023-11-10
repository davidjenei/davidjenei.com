title: Mappings
tags: #python

Mappings
========

Dictionaries
------------

    employee = {
        "name": "Alice",
        "position": "Software Engineer",
        "skills": ["Python", "JavaScript", "SQL"],
        "contact": {
            "email": "alice@example.com",
            "phone": "555-1234"
        }
    }

You will use `dicts` even if you don't want to:

-   function keyword arguments
-   class attributes

Mapping extras: Collections
---------------------------

-   collections.ChainMap
-   collections.defaultdict
-   (ordered dict)

Recipe: EAFP - Easier to Ask for Forgiveness than Permission
------------------------------------------------------------

> This common Python coding style assumes the existence of valid keys or
> attributes and catches exceptions if the assumption proves false. This
> clean and fast style is characterized by the presence of many try and
> except statements.

how to deal with this:

-   validate structure in advance
-   `collections.defaultdict`
-   subclass `collections.userdict`

Recipe: The problem
-------------------

It's definition: mutable. It can be hard to trace back.

-   think twice, do I really need a mutable object?
-   `type.MappingProxyType`

Recipe: dict vs named tuple vs dataclass
----------------------------------------

**dict to dataclass**

    from dataclasses import dataclass
    import requests

    @dataclass
    class Pokemon:
        weight: int
        name: str
        order: int

    j = requests.get("https://pokeapi.co/api/v2/pokemon/bulbasaur").json()
    bulba = Pokemon(**{k: j[k] for k in ["weight", "name", "order"]})

  [Mappings]: #mappings
  [Dictionaries]: #dictionaries
  [Mapping extras: Collections]: #mapping-extras-collections
  [Recipe: EAFP - Easier to Ask for Forgiveness than Permission]: #recipe-eafp---easier-to-ask-for-forgiveness-than-permission
  [Recipe: The problem]: #recipe-the-problem
  [Recipe: dict vs named tuple vs dataclass]: #recipe-dict-vs-named-tuple-vs-dataclass
