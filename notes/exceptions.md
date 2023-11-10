title: Exceptions
tags: #cpp
description: The case against exceptions

The case against exceptions
===========================

Google style guide
------------------

<https://google.github.io/styleguide/cppguide.html#Exceptions>

> We do not use C++ exceptions.

Joel
----

<https://www.joelonsoftware.com/2003/10/13/13/>

> They are invisible in the source code. Looking at a block of code,
> including functions which may or may not throw exceptions, there is no
> way to see which exceptions might be thrown and from where. This means
> that even careful code inspection doesn’t reveal potential bugs.

> They create too many possible exit points for a function. To write
> correct code, you really have to think about every possible code path
> through your function. Every time you call a function that can raise
> an exception and don’t catch it on the spot, you create opportunities
> for surprise bugs caused by functions that terminated abruptly,
> leaving data in an inconsistent state, or other code paths that you
> didn’t think about.

Complexity
----------

> However, if you are having trouble figuring out what to do for the
> particular situation, there’s a good chance that the caller won’t know
> what to do either. Generating an exception in a situation like this
> just passes the problem to someone else and adds to the system’s
> complexity.

Reliability
-----------

<https://joeduffyblog.com/2016/02/07/the-error-model/>

> For these reasons, most reliable systems use return codes instead of
> exceptions. They make it possible to locally reason about and decide
> how best to react to error conditions. But I’m getting ahead of
> myself. Let’s dig in.

> For C++, the real solution is easy to predict, and rather
> straightforward: for robust systems programs, don’t use exceptions.
> That’s the approach Embedded C++ takes, in addition to numerous
> realtime and mission critical guidelines for C++, including NASA’s Jet
> Propulsion Laboratory’s. C++ on Mars sure ain’t using exceptions
> anytime soon.

> The entire C++ ecosystem uses exceptions. To obey the above guidance,
> you must avoid significant parts of the language and, it turns out,
> significant chunks of the library ecosystem. Want to use the Standard
> Template Library? Too bad, it uses exceptions. Want to use Boost? Too
> bad, it uses exceptions. Your allocator likely throws bad_alloc. And
> so on. This even causes insanity like people creating forks of
> existing libraries that eradicates exceptions. The Windows kernel, for
> instance, has its own fork of the STL that doesn’t use exceptions.
> This bifurcation of the ecosystem is neither pleasant nor practical to
> sustain.

C++ dynamic exception specification
-----------------------------------

> The use of dynamic-exception-specifications is deprecated.

  [The case against exceptions]: #the-case-against-exceptions
  [Google style guide]: #google-style-guide
  [Joel]: #joel
  [Complexity]: #complexity
  [Reliability]: #reliability
  [C++ dynamic exception specification]: #c-dynamic-exception-specification
