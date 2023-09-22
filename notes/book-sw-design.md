# Reading notes for ["A Philosophy of Software Design" from John Ousterhout]

Why is it important to make software less complicated?

Software engineering still remains a human activity in the present day.
But the human brain has limited capacity. This is in contrast to
software, which is seemingly unconstrained: computers can execute code
regardless of it's complexity. There is no limitation what we can do,
software lacks any fundamental laws like physics.

> “This means that the greatest limitation in writing software is our
> ability to understand the systems we are creating”

Also there is a significant difference when we compare software
engineering to other engineering activities. It's very easy to change
software.

> The incremental approach works for software because software is
> malleable enough to allow significant design changes partway through
> implementation

...

> “The overall complexity of a system (C) is determined by the
> complexity of each part p (cp) weighted by the fraction of time
> developers spend working on that part (tp). Isolating complexity in a
> place where it will never be seen is almost as good as eliminating the
> complexity entirely.”

...

> “Complexity is caused by two things: **dependencies and obscurity.**”

...

> A dependency exists when a given piece of code cannot be understood
> and modified in isolation; the code relates in some way to other code,
> and the other code must be considered and/or modified if the given
> code is changed.”

...

> “Every time you write a new class you create dependencies around the
> API for that class.”

Examples on dependencies:

-   network protocols - if you modify the sender, you should modify the
    receiver
-   function signature and implementation
-   class definitions in a component

Obscurity and dependencies are connected. When it's not clear that a
certain code segment depends on another, it adds complexity.

What can we done to eliminate complexity? We break down the system to
components. Components hide complexity behind an interface.

> “One of the most important techniques for managing software complexity
> is to design systems so that developers only need to face a small
> fraction of the overall complexity at any given time. This approach is
> called modular design”

In most cases components represent an entity in the system.

> This is the essence of abstraction (finding a simple way to think
> about a complex entity)”

But abstractions has a cost.

> “The cost of a module (in terms of system complexity) is its
> interface.”

What makes an abstraction cheap?

> “The best modules are deep: they have a lot of functionality hidden
> behind a simple interface.”

**Classes** and complexity:

The conventional wisdom is that classes should be small, because it will
be easy to read.

> “The extreme of the “classes should be small” approach is a syndrome I
> call classitis, which stems from the mistaken view that “classes are
> good, so more classes are better.”

**Methods** and complexity:

> “However, length by itself is rarely a good reason for splitting up a
> method. In general, developers tend to break up methods too much.
> Splitting up a method introduces additional interfaces, which add to
> complexity.”

> Typically this means that the child method is relatively
> general-purpose: it could conceivably be used by other methods besides
> the parent. If you make a split of this form and then find yourself
> flipping back and forth between the parent and child to understand how
> they work together, that is a red flag (“Conjoined Methods”)
> indicating that the split was probably a bad idea.

> A pass-through method is one that does nothing except pass its
> arguments to another
>
> Decorator classes also use a lot of passthrough methods, it's easy to
> overuse them.

**Exceptions** and complexity:

> “However, if you are having trouble figuring out what to do for the
> particular situation, there’s a good chance that the caller won’t know
> what to do either. Generating an exception in a situation like this
> just passes the problem to someone else and adds to the system’s
> complexity.”

**Comments** and complexity:

> “The overall idea behind comments is to capture information that was
> in the mind of the designer but couldn’t be represented in the code.

**TDD** and complexity:

> “The problem with test-driven development is that it focuses attention
> on getting specific features working, rather than finding the best
> design”

**Hiding errors** and complexity:

> “Thus, the best alternative is for NFS to mask the errors and hang
> applications.”

  ["A Philosophy of Software Design" from John Ousterhout]: https://www.goodreads.com/en/book/show/39996759
