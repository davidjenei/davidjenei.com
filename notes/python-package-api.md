title: Packages, modules, files
tags: #python
description: Virtualenvs and others

[For Python packages, file structure != API]
--------------------------------------------

    # tekst/__init__.py

    __all__ = ['Token', 'tokenize', ...]

    from .tokenizer import Token, tokenize


  [For Python packages, file structure != API]: https://benhoyt.com/writings/python-api-file-structure/
