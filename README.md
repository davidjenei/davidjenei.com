davidjenei.com 👋
=================

Minimal static site generator for my personal website [davidjenei.com].

Uses:

-   [lowdown] - A simple markdown translator
-   [GNU make] - I want those wildcards
-   [20 line css]
-   no js

and my notes written in markdown.

How it works
------------

Uses the remarkable `cat` command to append `html` fragments to my
markdown notes, then invoke `lowdown` to translate that to html.

Helper targets will `rsync` results to my server or build customised
docs (resume).

Missing features
----------------

-   RSS: will do
-   generated index files: won't do
-   generated pdf from resume: won't do, I'll use my favourite browser

My workflow
-----------

Coming soon.

  [davidjenei.com 👋]: #davidjeneicom-
  [How it works]: #how-it-works
  [Missing features]: #missing-features
  [My workflow]: #my-workflow
  [davidjenei.com]: https://davidjenei.com
  [lowdown]: https://github.com/kristapsdz/lowdown
  [GNU make]: https://www.gnu.org/software/make/
  [20 line css]: ./style.css
