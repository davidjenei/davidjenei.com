tags: #sw #modeling
title: Modeling
description: business-logic.jpg

System and software modeling
============================

> **Go to**: [How can we use visual modeling?] · [What level of detail?]
> · [Static models] · [Dynamic models] · [Embedded system modeling] ·
> [Resources]

> **Last updated:** [%date]

The computing world is already so complex, that we interact with it
through a great number of abstractions.

> All models are wrong, some are useful. - [George E.P. Box]

Mainstream programming languages operate with a textual content format.

> Text is an ideal medium for abstract logic. - [Maggie Appleton]

> This level of abstraction removes the physical, spatial, and embodied
> qualities that humans rely upon to understand the world around us. -
> [Maggie Appleton]

The benefits of text format still outweighs the cons. There is a gap
between code and pictures, because visuals are also abstractions.

> There is a reason why digital circuit design has shifted to use of
> HDLs - HN

What can visuals give us?

> Visuals reveal **metaphors**, **spatial meaning**, and **change over
> time** in ways that linear text can't - [Maggie Appleton]

How can we use visual modeling?
-------------------------------

**Communication**

Besides text, pictures can help us explaining ideas. We use models to
visualise thoughts and improve **communication**.

**Specification**

Use modeling as a **specification** language:

-   define component boundaries
-   describe interactions between components: eg. data flow

**Design**

Modeling can be part of the design process: **design without
implementation**.

but keep in mind (e.g. vhdl):

> At the end of the day plain text (code) is the universal truth

**Decorate**

or use modeling to **impress stakeholders**.

> And create colorful all in one models.

as decoration.

What level of detail?
---------------------

-   Sketch - describe how some part of a system works. notation?
-   Blueprint - designer writes blueprint in complex CASE tools, then
    programmer implements that
-   Programming - create models, generate code. already dead.

Explaining diagrams in text?

> What's the purpose of a diagram if need to add extensive textual
> explanation to it? Can we define what ideas are we trying to represent
> as an image?

Static models
-------------

-   Structural view
-   Does not vary with time
-   Less likely to change than the functions of the system
-   eg. class, component, block

Three types of relationships:

-   association
-   whole/part - composition and aggregation
-   generalization/specialization - inheritance

Dynamic models
--------------

-   More behavioral than structural
-   Varies with time
-   Determine sequences of interactions among objects
-   Usually starts with an external event eg. sequence, state
-   eg. communication, sequence, state chart

Stateless vs stateful dynamic models

Embedded system modeling
------------------------

**Context block diagram**

Define system and external environment boundaries.

TODO: Association examples, entity examples.

**Software context block diagram**

Define software and hardware boundaries, peripherals, IOs, etc.

Model software as one aggregate object first.

**Map Component and Deployment diagrams**

Resources
---------

-   <https://garba.org/posts/2021/uml/>
-   <https://martinfowler.com/bliki/UmlMode.html>
-   <https://buttondown.email/hillelwayne/archive/why-uml-really-died/>
-   <https://news.ycombinator.com/item?id=12879056>
-   <https://garba.org/posts/2018/arrows/>
-   <https://blog.regehr.org/archives/1653>
-   <https://news.ycombinator.com/item?id=31891226>

  [System and software modeling]: #system-and-software-modeling
  [How can we use visual modeling?]: #how-can-we-use-visual-modeling
  [What level of detail?]: #what-level-of-detail
  [Static models]: #static-models
  [Dynamic models]: #dynamic-models
  [Embedded system modeling]: #embedded-system-modeling
  [Resources]: #resources
  [George E.P. Box]: https://www.goodreads.com/quotes/7729857-essentially-all-models-are-wrong-but-some-are-useful
  [Maggie Appleton]: https://maggieappleton.com/programming-pictures
