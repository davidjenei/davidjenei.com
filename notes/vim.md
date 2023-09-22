# VIM shortcuts

Shortcuts I look up once in every month:

-   `gd` - jump to variable declaration
-   `%` - jump to the matching brace, or #if to #endif
-   `[{` - jump to start or end of function
-   `dt"` - delete till character "
-   `^R ^W` - word under cursor into cmdline
-   `zm` - fold more
-   `zr` - fold reduce
-   `zR` - open all
-   `q` - quote(?) record a macro to a given register, replay with @

## Demo ideas

-   using `^[` for ASCII escape
-   `.` command examples
-   reload a file that was edited outside of vim
-   redirect command output to vim, sort, grep, cut columns, etc
-   compare upstream and edited version of a file in split

## Never set `$TERM`

Why? Just don't. Leave it up to the terminal emulator.

## My case against Visual Studio Code

I want to understand the tools I use. Why am I getting this warning for
line 5? How can I add a new rule to my linter? How can I further
automate this build step?

I want to use only what I really need. Before that, I need to know what
I need. So always try IDEs and look for inspiration.

I'd rather stick with vendor neutral tools. Also I'd rather work on IDE
independent software projects.

## Some thoughts on IDEs

-   Most of the stuff is done by language servers.
-   Autocomplete is not the primary feature of an IDE. It's the
    automations.
-   vscode is at 75% market share (???) in 2022. Impressive.

## My .vimrc

I try to live without plugins, but here are my essentials:

-   base16-colors
-   lsp
-   slime - send cells to ipython
-   buftabline - I don't use tablines so let's just display the buffers
    there.

# [VI history]

  [VI history]: https://pikuma.com/blog/origins-of-vim-text-editor
