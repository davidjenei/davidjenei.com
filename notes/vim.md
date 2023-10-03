Vim quick start
===============

> **Go to:** [Why you should consider using Vim?] · [Navigation] ·
> [Reading terminal output] · [Working with multiple files] · [Single
> repeats] · [Compare upstream and edited version of file in split] ·
> [Macro] · [.vimrc]

Why you should consider using Vim?
----------------------------------

Normally nobody cares about the tools you use for development. I don't
either, but for some reason you are here, so I present you this list:

-   lightweight and fast
-   privacy: reports no "telemetry data"
-   universal: can be found in every UNIX-like system
-   open source: not just open core, it's actually usable without big
    tech
-   terminal workflow: use tools that are not integrated to your IDE,
    but available in the OS
-   for the curious: what gives me this warning?
-   minimalist

If you care about the things above, Vim might be for you.

Now some opinion: Most of the fancy stuff in IDEs is done by language
servers. Autocomplete is overrated, it's the automations that will save
you time.

Here is a good [article] on the history of Vim.

Navigation
----------

The excellent `vimtutor` can teach you how to navigate within a file,
switch modes and do some basic editing tasks.

My favourites:

-   Join lines
-   Open a new line and enter insert mode
-   Find closing braces
-   Fold reduce, fold more, fold reduce all
-   Delete till character
-   Change word
-   Jump to matching brace (`%`), start/end of function (`[`,`{`)

Reading terminal output
-----------------------

    ls -ail | vim -

Now check how we can use the `%` command-line range specifier.

    :help :%

You can also use Linux commands to modify buffer content.

    sort; grep; cut

> Don't forget to `trim` before `cut`!

Now insert the date in the current line.

    :help :.

Working with multiple files
---------------------------

Do some buffer magic here: `bn, bp, ls, bd`

Single repeats
--------------

Simple changes can be repeated with the `.` command.

Compare upstream and edited version of file in split
----------------------------------------------------

Then reload file that was edited outside of vim

Macro
-----

`q` as in quote?

My .vimrc
------

I try to live without plugins, but:

-   base16-colors - match colors with my terminal color scheme
-   buftabline - I don’t use tablines so let’s just display the buffers
    there.
-   vim-lsp
-   tagbar
-   ctrl-p

Happy editing!

  [Vim quick start]: #vim-quick-start
  [Why you should consider using Vim?]: #why-you-should-consider-using-vim
  [Navigation]: #navigation
  [Reading terminal output]: #reading-terminal-output
  [Working with multiple files]: #working-with-multiple-files
  [Single repeats]: #single-repeats
  [Compare upstream and edited version of file in split]: #compare-upstream-and-edited-version-of-file-in-split
  [Macro]: #macro
  [.vimrc]: #vimrc
  [article]: https://pikuma.com/blog/origins-of-vim-text-editor
