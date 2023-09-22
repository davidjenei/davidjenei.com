Software engineering
====================

Why is software engineering so difficult? Is it even engineering?

Must-read classics
------------------

* [How to build good software]
* [Things you should never do]
* [No Silver Bullet]
* [The Architecture of Open Source Applications]
* [Real software engineering]

Communication
-------------

> essential difficulty: invisibility

We speak human language to communicate ideas. Machines understand code.
There is a gap between the two.

> The reality of software though is not inherently embedded in space,
> and thus has no ready geometric representation.

Sometimes pictures can help in presenting ideas. But software
[visualizations] will never be fully accurate.

> it isn’t possible to visualize the design for a large software system
> well enough to understand all of its implications before building
> anything. A Philosophy of Software Design - John Ousterhout

Testing and prototyping
-----------------------

> essential difficulty: conformity and scope

It is import to understand the problem before writing code. But how well
do we understand the requirement?

We use prototyping to discover potential solutions. But there is more:
prototyping also helps us understanding the problem and identifying new
requirements. Testing, at the same time, validates the solution.
Development cycles should alternate between those. With other words,
consider exploration and consolidation phases.

Assuming that we completely understand all the requirements, software
products still exist in a constantly changing environment: users,
stakeholders and infrastructure changes over time. (software engineering
is a service industry?)

Known unknowns and unknown unknowns
-----------------------------------

> essential difficulty: changeability

How do we know that a software product is complete?

> Software is constantly subjected to pressures for change

Software is constantly changing? We need to prepare for that.

But people tend to value [known risks] over unknowns. It makes us feel
smart to think about risks others may not. As a result, we underestimate
the unexpected. We rarely hear the following during roadmap planning: we
don't need to prepare for that, let's just save those resources for the
unexpected.

> 100:10:1 method: Brainstorm 100 things that could go wrong. Pick 10 on
> that list that feel like the most likely and investigate them. Find
> the 1 critical problem you’re going to focus on.

Complexity
----------

> essential difficulty: complexity

What is software complexity? How can we measure that?

> Software is limited not by the amount of resources put into building
> it but complexity.

Solution: alternate between extending and reducing complexity.

Solution: minimalism.

> Code is not an asset, it is a liability. The more code you have, the
> more you have to optimize, debug, modernize, refactor, understand. In
> short, the more code you have — the harder it is to change. A smaller
> and simpler codebase is easier to understand, improve and extend. -
> [Paul Copplestone]

Productivity
------------

> [Programmers are most effective when they avoid writing code.]

How to measure productivity?

> Productivity varies tremendously across the profession, but it may not
> vary so much within a given company.

Maximising developer productivity is not the goal. Build things that
will be used. It's not a problem if a team builds less. Estimate feature
value and focus on delivering that. How to calculate feature value? It
depends, but it's sure that it needs to be delivered first.

How to improve productivity? Reuse.

> The best code is the code that you don't write.

Cut features that don't add value.

Top-down or bottom-up?
----------------------

Working backwards:

> "The idea is to start with the desired customer experience when
> designing new products, going so far as to draft “a press release that
> literally announces the product as if it were ready to launch and an
> FAQ anticipating the tough questions." - [Amazon working backwards]

Working bottom-up:

-   cost of change

Why software is easy to sell?
-----------------------------

-   low marginal cost - easy to copy for distribution
-   no shipping and deployment cost - don't need to build servers
    anymore
-   ambiguous requirements makes software hard to criticise

> Software is largely a service industry operating under the persistent
> but unfounded delusion that it is a manufacturing industry. — [The
> Cathedral and the Bazaar by Eric S. Raymond]

How to find a direct competitor or alternative if it is not clear what
problem the software solves?

See frameworks and [obscurantism] for more.

The main reason why software engineers earn more than other engineers
because software is easy to sell.

Does anything work?
-------------------

> My own experience, validated by Cockburn’s thesis and Frederick Brooks
> in No Silver Bullet, is that software development projects succeed
> when the key people on the team share a common vision, what Brooks
> calls “[conceptual integrity].” This doesn’t arise from any particular
> methodology, and can happen in the absence of anything resembling a
> process. -- [Why don't software development methodologies work]

Use the feedback engine effectively. Cost of change is effected by the
length of the feedback loop.

> -   avoid mutable states
> -   stop using unsafe languages -- \[Glenn Vanderburg - Real Software
>     Engineering\]

Recognise that software engineering is a team activity. The team needs
to share a "common vision" that includes:

-   shared principles - how to do things?
-   shared mental models - what to do?

> having the right shared principles and shared mental models is the
> difference between a joyful experience on a team or not.

Iterative and incremental
-------------------------

Development cycles alternate between:

-   extending and reducing complexity
-   exploring and refining requirements
-   prototyping and testing
-   developing and releasing

What is the goal? Feedback loop on different scales.

> 1.  A software system can best be designed if the testing is
>     interlaced with the designing instead of being used after the
>     design.
> 2.  A simulation which matches the requirements contains the control
>     which organizes the design of the system.
> 3.  Through successive repetitions of this process of interlaced
>     testing and design the model ultimately becomes the software
>     system itself. – Alan Perlis

How big an increment should be?

Ship as soon as possible. Because shipping means more feedback.

> Shipping early, frequently, and on a cadence allows you to shorten the
> time to feedback and accelerate getting you to where you really need
> to be.
>
> -- [Brendan O'Leary - What I learned at GitLab that I don't want to
> forget]

Why are we doing these iterations? To get feedback on our decisions.

Architecture
------------

Architecture is a buzzword? Equals software design? It is team
responsibility, everyone can do that on a certain level.

> Remember that the builder has the inventive and creative
> responsibility for the implementation; so the architect suggests, not
> dictates. -- [The Mythical Man-Month]

But communicating ideas during software design is hard. Separated
architects perform worse, it is best done by a team.

Minimalism in software engineering
----------------------------------

[Inspiration]

-   store everything in text
-   unautomate
-   the beauty of small
-   pair down ideas, just in case syndrome

Minimalism improves quality:

> Size is the best predictor of code quality
>
> A long paper trail of software engineering studies has shown that many
> internal code metrics (such as methods per class, depth of inheritance
> tree, coupling among classes etc.) are correlated with external
> attributes, the most important of which is bugs. What the authors of
> this paper show is that when they introduce a second variable, namely,
> the total size of the program, into the statistical analysis and
> control for it, the correlation between all these code metrics and
> bugs disappears. However, this paper uncovers a strong association
> between most code metrics and the size of the code, both of which
> together lead to the externally observable attributes like bugs -
> [Source]

Faulty reward functions
-----------------------

AI agents fail miserably when trained with [misspecified the reward
functions]. This also applies to software engineering: it possible to
end up in a disaster with 100% test coverage and consistent semantic
versioning.

Try to recognise seemingly faulty reward functions: increasing
complexity. Recommended literature: [What did AUTOSAR do?]

[Choose boring technology]
--------------------------

> Let’s say every company gets about three innovation tokens. You can
> spend these however you want, but the supply is fixed for a long
> while. You might get a few more after you achieve a certain level of
> stability and maturity, but the general tendency is to overestimate
> the contents of your wallet

Selecting dependencies is art
-----------------------------

> The Not-Invented-Here Syndrome is considered a classic management
> pathology, in which a team refuses to use a technology that they
> didn’t create themselves.

But at the same time:

> Find the dependencies — and eliminate them. - [In defense of not
> invented here syndrome]

Characteristics of Software engineering
---------------------------------------

From [We are not special]

**Consistency**

A software component rarely specifies tolerancy and it does not wear out
(unlike most physical components). Connection to the real physical world
can be explicitly declared and controlled.

**Velocity**

Commonly heard: Why don't we fix this hardware issues from software?
Software is malleable. Software can be changed fast. Also changes can be
reversed easily.

This leads to ever chainging requirements? If it is possible, then why
not? How much does it cost to build a prototype?

**Constraints**

Less hard constraints. If it is a hard constraint, software engineers
turn to standards and real-time.

The [Rational design process] is a
[caricature][Real software engineering] for all engineering disciplines,
real world software engineering is just one adaptation.

[Your Coding Philosophies are Irrelevant]
-----------------------------------------

Ultimately it's your application/system/product that needs to work.

  [How to build good software]: https://www.csc.gov.sg/articles/how-to-build-good-software
  [Things you should never do]: https://www.joelonsoftware.com/2000/04/06/things-you-should-never-do-part-i/
  [No Silver Bullet]: https://blog.acolyer.org/2016/09/06/no-silver-bullet-essence-and-accident-in-software-engineering/
  [The Architecture of Open Source Applications]: http://aosabook.org/en/index.html
  [Real software engineering]: https://www.youtube.com/watch?v=RhdlBHHimeM
  [visualizations]: ./modeling.md
  [known risks]: https://news.ycombinator.com/item?id=23613569
  [Paul Copplestone]: https://paul.copplest.one/knowledge/tech/mental-models.html#less-is-more
  [Programmers are most effective when they avoid writing code.]: https://www.johndcook.com/blog/2009/12/23/why-programmers-are-not-paid-in-proportion-to-their-productivity/
  [Amazon working backwards]: https://www.nytimes.com/2021/02/13/business/dealbook/amazon-working-backwards.html
  [The Cathedral and the Bazaar by Eric S. Raymond]: http://www.catb.org/~esr/writings/cathedral-bazaar/magic-cauldron/ar01s03.html
  [obscurantism]: https://en.wikipedia.org/wiki/Obscurantism
  [conceptual integrity]: https://wiki.c2.com/?ConceptualIntegrity
  [Why don't software development methodologies work]: https://typicalprogrammer.com/why-dont-software-development-methodologies-work
  [Brendan O'Leary - What I learned at GitLab that I don't want to forget]:
    https://blog.boleary.dev/what-i-learned-at-gitlab-that-i-dont-want-to-forget/
  [The Mythical Man-Month]: https://en.wikipedia.org/wiki/The_Mythical_Man-Month
  [Inspiration]: https://mnmlist.com/archives/
  [Source]: https://blog.vivekhaldar.com/post/10669678292/size-is-the-best-predictor-of-code-quality
  [misspecified the reward functions]: https://openai.com/blog/faulty-reward-functions/
  [What did AUTOSAR do?]: https://www.reddit.com/r/embedded/comments/leq366/how_much_of_a_modern_carbuilt_from_the_year_2000/gmiq6d0/
  [Choose boring technology]: https://mcfunley.com/choose-boring-technology
  [In defense of not invented here syndrome]: https://www.joelonsoftware.com/2001/10/14/in-defense-of-not-invented-here-syndrome/
  [We are not special]: https://www.hillelwayne.com/post/we-are-not-special/
  [Rational design process]: https://users.ece.utexas.edu/~perry/education/SE-Intro/fakeit.pdf
  [Your Coding Philosophies are Irrelevant]: https://prog21.dadgum.com/142.html
