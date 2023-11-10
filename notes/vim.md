tags: #productivity #training
description: Propaganda
title: Vim

Vim quick start
===============

> **Go to:** [Why you should consider using Vim?] · [I started Vi and
> nothing works] · [Navigation] · [Reading terminal output] · [Working
> with multiple files and windows] · [Single repeats] · [Compare
> upstream and edited version of file in split] · [Macro] · [.vimrc]

Why you should consider using Vim?
----------------------------------

Normally nobody cares about the tools you use for development. I don't
either, but for some reason you visited this page. So I present you the
benefits of using Vim (compared to your favourite IDE(tm)):

-   it's lightweight and fast
-   protects your privacy: no "telemetry data"
-   available everywhere: can be found in every UNIX-like system
-   open source: not just open core, it's actually usable without big
    tech
-   compliments terminal workflow: use tools that are not integrated to
    your IDE, but available in the OS
-   for the curious: why is this line underlined with red?
-   minimalist
-   edgy

If you care about the things above (*and you have all the time in the
world*), Vim might be for you.

> the Unix philosophy "is the idea that the power of a system comes more
> from the relationships among programs than from the programs
> themselves."

Now some opinion: Most of those fancy IDE features are done by language
servers. Autocomplete is overrated, it's the automations that will save
you time.

Here is a good [article] on the history of Vim.

I started Vi and nothing works
------------------------------

    help compatible
    set nocompatible

Navigation
----------

The excellent `vimtutor` is a good starting point. Tells you how to
navigate within a file, switch modes and do some basic editing tasks.

My favourites:

-   Join lines
-   Open a new line and enter insert mode
-   Find closing braces
-   Fold reduce, fold more, fold reduce all
-   Delete till character
-   Change word
-   Jump to matching brace (`%`), start/end of function (`[`,`{`)

Insert mode
-----------

    ^H: Backspace
    ^W: Delete word
    ^U: Delete line

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

    :.!date

Do the json lookup

    https://pokeapi.co

Working with multiple files and windows
---------------------------------------

Do some buffer magic here: `bn, bp, ls, bd`

Single repeats
--------------

Simple changes can be repeated with the `.` command.

Global search and replace? Nah, search and repeat with dot.

Multiple repeats
---

Keep lines that contain string

    :v/keeeep/d

Compare upstream and edited version of file in split
----------------------------------------------------

    :% !git show main:my-file.txt

Then reload file that was edited outside of vim

Macro
-----

`q` as in quote?

GDB???
------

Yes pls.

    Termdebug

Quickfix
--

    :e $VIMRUNTIME/compiler/<Tab>

My [.vimrc][1]
--------------

I try to live without plugins, but:

-   [base16-colors] - match colors with my terminal color scheme
-   [buftabline] - I don’t use tablines so let’s just display the
    buffers there.
-   [vim-lsp]
-   [tagbar] - Universal ctags
-   [ctrl-p]
-   slime - `<c-c>v`, `<c-c><c-c>`, `<c-k><c-k>`

Read more
---------

-   [Practical Vim]

Happy editing!

  [Vim quick start]: #vim-quick-start
  [Why you should consider using Vim?]: #why-you-should-consider-using-vim
  [I started Vi and nothing works]: #i-started-vi-and-nothing-works
  [Navigation]: #navigation
  [Insert mode]: #insert-mode
  [Reading terminal output]: #reading-terminal-output
  [Working with multiple files and windows]: #working-with-multiple-files-and-windows
  [Single repeats]: #single-repeats
  [Compare upstream and edited version of file in split]: #compare-upstream-and-edited-version-of-file-in-split
  [Macro]: #macro
  [GDB???]: #gdb
  [My .vimrc]: #my-vimrc
  [Read more]: #read-more
  [.vimrc]: #vimrc
  [article]: https://pikuma.com/blog/origins-of-vim-text-editor
  [1]: https://github.com/davidjenei/dotfiles/blob/master/.vimrc
  [base16-colors]: https://github.com/chriskempson/base16-vim
  [buftabline]: https://github.com/ap/vim-buftabline
  [vim-lsp]: https://github.com/prabirshrestha/vim-lsp
  [tagbar]: https://github.com/preservim/tagbar
  [ctrl-p]: https://github.com/kien/ctrlp.vim
  [Practical Vim]: https://www.goodreads.com/it/book/show/13607232
