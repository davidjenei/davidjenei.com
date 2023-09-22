System and software modeling
============================

Purpose of modeling
-------------------

Using pictures to present ideas can help us explain them more
effectively. We use models to visualise thoughts and improve
**communication**.

Use modeling as a **specification** language:

-   define component boundaries
-   describe interactions between components: eg. data flow

or use modeling to consider **design without implementation**.

but keep in mind:

> There is a reason why digital circuit design has shifted to use of
> HDLs

<!---->

> At the end of the day plain text (code) is the universal truth

or use modeling to **impress stakeholders**.

> And create colorful all in one models.

as decoration.

Why modeling software?
----------------------

Mainstream programming languages operate in different content format.
There is a **gap** between code and pictures.

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

-   [https://garba.org/posts/2021/uml/]
-   [https://martinfowler.com/bliki/UmlMode.html]
-   [https://buttondown.email/hillelwayne/archive/why-uml-really-died/]
-   [http://mason.gmu.edu/\~hgomaa/swe760/SWE760-6-Dynamic-Interaction-Modeling-RT.pdf]
-   [https://news.ycombinator.com/item?id=12879056]
-   [https://garba.org/posts/2018/arrows/]
-   [https://blog.regehr.org/archives/1653]
-   [https://news.ycombinator.com/item?id=31891226]

  [https://garba.org/posts/2021/uml/]: https://garba.org/posts/2021/uml/
  [https://martinfowler.com/bliki/UmlMode.html]: https://martinfowler.com/bliki/UmlMode.html
  [https://buttondown.email/hillelwayne/archive/why-uml-really-died/]: https://buttondown.email/hillelwayne/archive/why-uml-really-died/
  [http://mason.gmu.edu/\~hgomaa/swe760/SWE760-6-Dynamic-Interaction-Modeling-RT.pdf]:
    http://mason.gmu.edu/~hgomaa/swe760/SWE760-6-Dynamic-Interaction-Modeling-RT.pdf
  [https://news.ycombinator.com/item?id=12879056]: https://news.ycombinator.com/item?id=12879056
  [https://garba.org/posts/2018/arrows/]: https://garba.org/posts/2018/arrows/
  [https://blog.regehr.org/archives/1653]: https://blog.regehr.org/archives/1653
  [https://news.ycombinator.com/item?id=31891226]: https://news.ycombinator.com/item?id=31891226
