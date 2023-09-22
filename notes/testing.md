# Testing

## Terminology

What are acceptance tests, integration tests and component tests? Before
discussing test strategy, make sure to have common understanding of
these phrases.

To discuss what is covered by eg. a component test, we need to define
what a component is. So first specify system or component context and
boundaries.

Then we can organise tests based on:

-   integration level
-   importance (the test case is this an acceptance criteria or covers
    an [ASR]?

## Test-driven development

TDD is successful because people started writing regression tests not
because X% coverage results in good code.

> TDD is a discipline for programmers - [Robert C Martin]

Not a dogma.

Sometimes we don't have the detailed architecture in front of us when
writing code. So we create new units to see what works. Then ask
ourselves if this unit is really worth having. This is an iterative
design process we do on a daily basis. But how can we write unit tests
if we don't know what units are worth writing at all?

> Test-first units leads to an overly complex web of intermediary
> objects and indirection in order to avoid doing anything that's
> "slow". - [David Heinemeier Hansson]

Some other benefits of TDD:

-   convert requirements to tests as early as possible to have a better
    understanding of them
-   do not add extra complexity just because we might need that one
    day - no test? delete code.

Perform tests on different levels: TDD != Unit tests

## What is a unit test?

> 1.  runs fast
> 2.  helps us to localise problems
>
> [Robert C. Martin: Working Effectively with Legace Code]

It's not a problem if the test covers more than one "unit". But it needs
to run fast.

> A test is not a unit test if:
>
> -   It talks to the database
> -   It communicates across the network
> -   It touches the file system
> -   It can't run at the same time as any of your other unit tests
> -   You have to do special things to your environment (such as editing
>     config files) to run it.
>
> [Michael Feather]

Yet it's important to test integrations between units. And we can use
unit test frameworks for this purpose, even though this is more than a
unit test.

## Minimal test "frameworks"

What is a test [framework]?

> [Heavy frameworks get in the way.]

How to do unit testing in a constrained environment (embedded):

-   [<https://jera.com/techinfo/jtns/jtn002>]
-   [<https://github.com/mdavidsaver/pvxs/blob/master/src/pvxs/unittest.h>]
-   [<https://eradman.com/posts/tdd-in-c.html>]

## Yet another integration test framework

Want acceptance test driven development? Try using [Robot]. Robot is a
DSL trying to be a scripting language. Decouple tests from the code as
much as possible. Describe high level tests in a special language.

This is not your favourite scripting language:

-   keywords = functions
-   test steps = function calls

Can we actually reuse keywords?

> Or there will be few heavily-used keywords, and a really long tail of
> one-time keywords, which is a pain.

Does it with work with embedded?

> Another complaint about robot framework is that when you have an
> expensive setup like a 4 minute flashing operation, you don't want to
> repeat it more than necessary. So in a file, you might make the
> expensive setup a suite-level setup, followed by the tests cases that
> depend upon it. When this file grows, you might want to refactor it
> into a multi-file test suite in it's own sub-directory. However, these
> tests no longer share a suite scope (because robot's "suite scope" is
> actually a file scope" for legacy reasons) so in practice you may need
> to tolerate 3000 line files to avoid long setups. - [elevation]

Alternative if we don't want another obscure DSL: pytest

## Dealing with different test levels

**Acceptance test**

> enable the user, customers or other authorized entity to determine
> whether to accept the system.

Acceptance test is normally black box testing. Developer test focuses on
the code. We can combine these.

**Component test**

Once we have a definition for a component, we can call it a component
test.

## Metrics

[C/C++ Metrics: Line Counting metrics]

-   LOC/SLOC
-   eLOC
-   lLOC
-   physical lines
-   number of files
-   number of classes
-   project level
-   namespace level
-   file level
-   method level

## Fuzzing

[<https://lwn.net/Articles/637151/>]

## Clean code

[Clean code and C++]

  [ASR]: https://davidjenei.com/notes/requirement.html#:~:text=ASR
  [Robert C Martin]: https://blog.cleancoder.com/uncle-bob/2013/03/06/ThePragmaticsOfTDD.html
  [David Heinemeier Hansson]: https://dhh.dk/2014/tdd-is-dead-long-live-testing.html
  [Robert C. Martin: Working Effectively with Legace Code]: https://www.goodreads.com/book/show/44919.Working_Effectively_with_Legacy_Code
  [Michael Feather]: https://www.artima.com/weblogs/viewpost.jsp?thread=126923
  [framework]: ./sw-engineering#Why%20software%20is%20easy%20to%20sell?
  [Heavy frameworks get in the way.]: https://ports.openbsd.narkive.com/ucTmZA4b/regression-testing-in-openbsd
  [<https://jera.com/techinfo/jtns/jtn002>]: https://jera.com/techinfo/jtns/jtn002
  [<https://github.com/mdavidsaver/pvxs/blob/master/src/pvxs/unittest.h>]:
    https://github.com/mdavidsaver/pvxs/blob/master/src/pvxs/unittest.h
  [<https://eradman.com/posts/tdd-in-c.html>]: https://eradman.com/posts/tdd-in-c.html
  [Robot]: https://robotframework.org/
  [elevation]: https://news.ycombinator.com/item?id=33340782
  [C/C++ Metrics: Line Counting metrics]: https://msquaredtechnologies.com/Resource-Standard-Metrics.html
  [<https://lwn.net/Articles/637151/>]: https://lwn.net/Articles/637151/
  [Clean code and C++]: https://www.youtube.com/watch?v=9ch7tZN4jeI
