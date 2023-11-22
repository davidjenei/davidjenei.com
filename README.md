davidjenei.com 👋
=================

Minimal static site generator for my personal website [davidjenei.com].

Uses:

-   [lowdown] - A simple markdown translator
-   [GNU make]
-   [~20 line css] - Copied from the fantastic [barf](https://barf.bt.ht)
-   no js

and my notes written in markdown.

How it works
------------

Uses `lowdown` to translate markdown documents to html. Then some
remarkable unix utilities combine that with inline `html` fragments to build
the pages.

Collects #tags from markdown preambles.

Helper targets will help: `rsync` results to my server or build customised
docs (resume).

Missing features
----------------

-   RSS: will do
-   generated pdf from resume: won't do, I'll use my favourite browser

My workflow
-----------

Coming soon.

> Notes hierarchy: 🌱 < 🌿 < 🌻.
> Copied from strikingloo.github.io

  [davidjenei.com 👋]: #davidjeneicom-
  [How it works]: #how-it-works
  [Missing features]: #missing-features
  [My workflow]: #my-workflow
  [davidjenei.com]: https://davidjenei.com
  [lowdown]: https://github.com/kristapsdz/lowdown
  [GNU make]: https://www.gnu.org/software/make/
  [~20 line css]: ./style.css
