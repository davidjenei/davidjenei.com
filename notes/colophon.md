title: Colophon
description: About this website
tags: #writing
maturity: 🌱

Colophon
========

> In publishing, a colophon is a brief statement containing information
> about the publication of a book such as an "imprint" (the place of
> publication, the publisher, and the date of publication). - [wiki]

This website
------------

-   has no js
-   uses handwritten css
-   the home page is under 250kb
-   has no form of hotlinking - no external css,js,font

How it works
------------

Tools I use for translating my markdown notes to static html:

-   gnu make - 200 LoC
-   lowdown - markdown translator
-   [tidy] - correct, cleanup and format html files
-   rsync - upload to the webserver
-   some unix commands to process metadata (grep, tr, sort, printf)

First I translate the markdown fragments with lowdown, then I put the
page together with inlined html fragments (navigation menu, footer, html
header etc.) With make, I can list multiple markdown parts as
prequisites that should be put on the the same html page.

    docs/%.html: docs/%.pre
    	$(call html_envelope, $*.md, $^ )

    docs/notes.html: docs/notes.pre docs/tags.pre docs/recent.pre

My metadata
-----------

As described in the [lowdown manual], the syntax follows the MMD
speficiation.

-   title
-   description
-   tags
-   maturity level: 🌱 \< 🌿 \< 🌻 - copied from [strikingloo.github.io]

TODO
----

-   automated check for dead links
-   generate RSS feed for my notebook
-   lowdown is a lovely piece of software, but maybe markdown is not for
    me

  [Colophon]: #colophon
  [This website]: #this-website
  [How it works]: #how-it-works
  [My metadata]: #my-metadata
  [TODO]: #todo
  [wiki]: https://en.wikipedia.org/wiki/Colophon_(publishing)
  [tidy]: http://www.html-tidy.org
  [lowdown manual]: https://man.archlinux.org/man/lowdown.5.en#Metadata
  [strikingloo.github.io]: https://strikingloo.github.io
