title: Requirements engineering
tags: #sw #requirement

Requirements engineering
========================

> **Go to:** [Definition] · [Why do we need requirements?] ·
> [Elicitation] · [Glossary] · [Background information] · [What makes a
> good requirement?] · [What are the types of requirements?] · [How
> detailed?] · [Format]

> **Last updated:** [%date]

Definition
----------

IEEE definition:

> [Requirements engineering][1] refers to engineered, systematic
> gathering, documentation, testing and managing of requirements.

> A [requirement] is a statement that identifies a product or processes
> operational, functional, or design characteristic or constraint, which
> is unambiguous, testable, or measurable and necessary for product or
> process acceptability.

More practical view from the development team's perspective:

> ... (software) is living manifestation of the development team’s
> collective understanding - [How to build good software]

Requirements capture the team's understanding of what the system should
do, code captures how it should be built.

Why do we need requirements?
----------------------------

-   describe what the system does (not how it does)
-   define (limit) the system scope
-   make the system testable
-   spare development cost
-   describe the system in legally binding documents

[Elicitation][2]
----------------

Requirements are not collected but mined.

Glossary
--------

We should set up a common terminology before writing requirements. And
use that consistently.

A glossary entry includes:

-   term
-   definition
-   alias
-   related terms

Background information
----------------------

It's impossible to capture every aspect of the system with requirements.
Yet we have to make decisions during the project even when we can't
point to a requirement. In these cases it helps if we can answer the
question:

-   Why are we doing this?
-   How can we measure success?

Goals should be written down and agreed on, just like requirements.

**Goals vs requirements**

-   Goals describe a desired state in the future (eg. success)
-   Goals can't be tested, lacks satisfaction criteria
-   Goals are defined at beginning, requirements are collected and
    updated over the project.
-   Goals can relate to system qualities (performance, security) or
    architectural qualities (extensibility, reusability)

What makes a good requirement?
------------------------------

> Six C: Clear, conscise, correct, coherent, complete and confirmable

and agreed on.

What are the types of requirements?
-----------------------------------

**Functional requirements**

**Non-functional requirements**

-   quality = non-functional
-   conceptual
-   design
-   implement
-   interface
-   performance
-   physical
-   legal
-   security

**Architecturally significant**

> [Architecturally significant requirements (ASR)] are those
> requirements that have a measurable effect on a computer system's
> architecture.

Highlight some requirements on which you can start designing and make
easy architectural decisions. ASRs should be easily traceable to
architectural elements.

**Levels**

-   business - always domain specific
-   system/product - more detailed
-   component - always component specific: software, hardware, material

How detailed?
-------------

[Readme driven development]

Format
------

Hypertext is underrated!

  [Requirements engineering]: #requirements-engineering
  [Definition]: #definition
  [Why do we need requirements?]: #why-do-we-need-requirements
  [Elicitation]: #elicitation
  [Glossary]: #glossary
  [Background information]: #background-information
  [What makes a good requirement?]: #what-makes-a-good-requirement
  [What are the types of requirements?]: #what-are-the-types-of-requirements
  [How detailed?]: #how-detailed
  [Format]: #format
  [1]: https://www.iem.fraunhofer.de/en/research/range-of-services/software-engineering-and-it-security/RequirementsEngineering.html
  [requirement]: https://standards.ieee.org/ieee/1220/3372/
  [How to build good software]: https://medium.com/open-government-products/how-to-build-good-software-b13b32cb53a3
  [2]: https://en.m.wikipedia.org/wiki/Requirements_elicitation
  [Architecturally significant requirements (ASR)]: https://en.wikipedia.org/wiki/Architecturally_significant_requirements
  [Readme driven development]: https://tom.preston-werner.com/2010/08/23/readme-driven-development.html
