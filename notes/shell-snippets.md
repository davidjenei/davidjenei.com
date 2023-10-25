title: Shell snippets
description: Scripts but smaller
tags: #shell #terminal

Shell snippets
==============

Set
---

Export variables automatically:

    set -a
    source .env
    set +a

Fail pipe:

    set -o pipefail

Heredocs
--------

    cat << EOF > file.txt
    The current working directory is: $PWD
    You are logged in as: $(whoami)
    EOF

Debug pipes
---

    tee

  [Shell snippets]: #shell-snippets
  [Set]: #set
  [Heredocs]: #heredocs
