Software architecture
=====================

This document provides a comprehensive architectural overview of the
system, using a number of different architectural views to depict
different aspects of the system. It is intended to capture and convey
the significant architectural decisions which have been made on the
system.

Goals and constraints
---------------------

The following list of key requirements and system constraints have a
significant impact on the software architecture.

Goals are clear objectives for what you want your end state to be.
Constraints are given conditions, or circumstances the solution must
satisfy.

Scenarios
---------

This section defines the most important scenarios that represent
significant central functionality.

A scenario is an instance of a use case: it is one path through the flow
of events for the use case.

Diagrams: use-case

Logical view
------------

The logical view is concerned with the functionality that the system
provides to end-users.

Diagrams: class, state

Process view
------------

The process view deals with the dynamic aspects of the system, explains
the system processes and how they communicate, and focuses on the run
time behavior of the system. The process view addresses concurrency,
distribution, integrator, performance, and scalability, etc.

Diagrams: sequence, communication, activity

Useful links
------------

- [https://www.cloudcomputingpatterns.org]
- [https://docs.microsoft.com/en-us/azure/architecture/guide/]
- [http://aosabook.org/en/index.html]

  [https://www.cloudcomputingpatterns.org]: https://www.cloudcomputingpatterns.org
  [https://docs.microsoft.com/en-us/azure/architecture/guide/]: https://docs.microsoft.com/en-us/azure/architecture/guide/
  [http://aosabook.org/en/index.html]: http://aosabook.org/en/index.html
