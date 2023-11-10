title: User defined types
tags: #python

User defined types
==================

> Types are defined by supported operations - Fluent Python, 2nd Edition

> Here we assume that type is a set of values and a set of functions
> that one can apply to these values. PEP 483—The Theory of Type Hints”

How can we make sure that the operation is supported?

Recipe: Fail early with duck typing
-----------------------------------

Take the object and perform the required action as soon as possible.

> Duck typing to handle a string or an iterable of strings - Fluent
> Python, 2nd Edition

    try:
        """Do something as one expected type"""
    except AttributeError:
        pass
    """Try to use it as another type"""

And write automated tests.

Recipe: Type hints from built-in ABC
------------------------------------

Recipe: If your action goes deeper, consider static protocols
-------------------------------------------------------------

To sort any object, we have to make sure that the type is
*consistent-with* a protocol.

> sorted uses the \< operator - Fluent Python, 2nd Edition

    “LT = TypeVar('LT', bound=SupportsLessThan)”

Recipe: Calling `hasattr` a lot may indicate that you need an ABC
-----------------------------------------------------------------

> Abstract base classes complement duck-typing by providing a way to
> define interfaces when other techniques like hasattr() would be clumsy
> or subtly wrong (for example with magic methods). - Python
> documentation

ABC
---

    import abc

    class Plugin(abc.ABC):

        @abc.abstractmethod
        def action(self, data):
            """Do something"""

> Concrete methods in an ABC must rely only on the interface defined by
> the ABC (i.e., other concrete or abstract methods or properties of the
> ABC).” - Fluent Python, 2nd Edition

  [User defined types]: #user-defined-types
  [Recipe: Fail early with duck typing]: #recipe-fail-early-with-duck-typing
  [Recipe: Type hints from built-in ABC]: #recipe-type-hints-from-built-in-abc
  [Recipe: If your action goes deeper, consider static protocols]: #recipe-if-your-action-goes-deeper-consider-static-protocols
  [Recipe: Calling `hasattr` a lot may indicate that you need an ABC]: #recipe-calling-hasattr-a-lot-may-indicate-that-you-need-an-abc
  [ABC]: #abc
