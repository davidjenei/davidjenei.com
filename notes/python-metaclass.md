title: Metaclasses
description: Snippets from Effective Python: 59 ways..
tags: #python

# Metaclasses

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


