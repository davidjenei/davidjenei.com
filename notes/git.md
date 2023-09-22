Contribution guidelines
=======================

Write meaningful commit messages
--------------------------------

-   Have a subject line briefly describing what the change is
-   Limit subject line to 50 characters
-   Use body to explain problem and how the commit achieves its goal
-   Separate subject from body with a blank line
-   Wrap to body at 72 characters
-   Write summary and description in imperative mode e.g. “make xyzzy do
    frotz”

Example subject lines:

-   Rename the iVars to remove the common prefix
-   Make the cached role coherrent with the actual one
-   Fix misspelled name on about page

Sources:

-   [Writing Git commit messages]
-   [Writing Good Commit messages]
-   [5 useful tips..]
-   [Commit Patch Message Guidelines][] [Git from the bottom up]

Useful verbs for commit messages
--------------------------------

-   Add/Cut = Create/Remove a capability
-   Fix = Fix an issue e.g. bug, typo, accident, misstatement.
-   Bump = Increase the version of something e.g. dependency.
-   Make = Change the build process, or tooling, or infra.
-   Refactor
-   Reformat
-   Optimise
-   Document
-   Use X capabilities
-   Remove unused
-   Replace X with Y
-   Prevent
-   Introduce
-   Create
-   Set
-   Check

Prepare changes in a new branch
-------------------------------

Branch name format:

reason\_\_details--tag

feature/fix/enhancement/refactor/upgrade etc.

*enchance*: intensify, increase, or further improve the quality, value,
or extent of, to raise to a higher degree

*upgrade*: raise (something) to a higher standard, in particular improve
(equipment or machinery) by adding or replacing components.

Example:

feature\_\_wonderful-hallo-API

[More info]

Commands I like
---------------

**patch workflow**

     git format-patch -o /tmp/ HEAD~

Branching models
----------------

> Any organization that designs a system (defined broadly) will produce
> a design whose structure is a copy of the organization's communication
> structure. — Melvin E. Conway

**[Trunk based development]** with git

-   root level branches, no access control
-   need quick local builds
-   immediate reviews

  [Writing Git commit messages]: http://365git.tumblr.com/post/3308646748/writing-git-commit-messages
  [Writing Good Commit messages]: https://vip.wordpress.com/documentation/commit-messages/
  [5 useful tips..]: https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
  [Commit Patch Message Guidelines]: https://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines
  [Git from the bottom up]: https://jwiegley.github.io/git-from-the-bottom-up/
  [More info]: https://codeburst.io/let-the-branch-name-do-all-the-talking-in-git-e614ff85aa30
  [Trunk based development]: https://trunkbaseddevelopment.com/
