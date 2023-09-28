Requirements engineering
========================

> [Requirements engineering] refers to engineered, systematic gathering,
> documentation, testing and managing of requirements.

What is a requirement?
----------------------

> A [requirement] is a statement that identifies a product or processes
> operational, functional, or design characteristic or constraint, which
> is unambiguous, testable, or measurable and necessary for product or
> process acceptability.

ok IEEE, thank you.

> Code captures the development team's [collective understanding] on how
> to build something

Requirements capture the team's understanding of what the system should
do.

Why do we need requirements?
----------------------------

-   describe what the system does (not how it does)
-   define (limit) the system scope
-   make the system testable
-   spare development cost
-   describe the system in legally binding documents

[Elicitation]
-------------

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

  [Requirements engineering]: https://www.iem.fraunhofer.de/en/research/range-of-services/software-engineering-and-it-security/RequirementsEngineering.html
  [requirement]: https://standards.ieee.org/ieee/1220/3372/
  [collective understanding]: https://www.csc.gov.sg/articles/how-to-build-good-software
  [Elicitation]: https://en.m.wikipedia.org/wiki/Requirements_elicitation
  [Architecturally significant requirements (ASR)]: https://en.wikipedia.org/wiki/Architecturally_significant_requirements
  [Readme driven development]: https://tom.preston-werner.com/2010/08/23/readme-driven-development.html
