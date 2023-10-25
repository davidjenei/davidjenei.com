tags:  #c
title: Standards, coding styles, guidelines

Standards, coding styles and guidelines
---------------------------------------

Purposes of **coding standards**:

-   avoid bugs
-   increase portability
-   increase readability
-   improve security

The end goal is to use C in safety-related systems. Usually this doesn't cover coding
style.

Examples:

-   [MISRA] - automotive
-   [NASA JPL] - mission critical flight
-   [SEI CERT] - secure coding, network devices

**Coding style guides** cover:

-   whitespace: indentation, blank lines, placing braces and spaces
-   naming: case, local vs global variables, macros, function-like
    macros
-   long lines, long functions: 80x24
-   comment format

Examples:

-   [Linux kernel]

**Guidelines** are rules plus recommendations. Also covers style.

Examples:

-   [LLVM Coding standard]
-   [Barr group] - embedded
-   [GNU]
-   [GCC]

More:

-   [awesome-safety-critical]
-   [awesome-coding-standards]

  [Standards, coding styles and guidelines]: #standards-coding-styles-and-guidelines
  [MISRA]: https://gitlab.com/MISRA/MISRA-C/MISRA-C-2012/Example-Suite
  [NASA JPL]: https://github.com/stanislaw/awesome-safety-critical/blob/master/Backup/JPL_Coding_Standard_C.pdf
  [SEI CERT]: https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standard
  [Linux kernel]: https://www.kernel.org/doc/html/v4.10/process/coding-style.html
  [LLVM Coding standard]: https://llvm.org/docs/CodingStandards.html
  [Barr group]: https://barrgroup.com/embedded-systems/books/embedded-c-coding-standard
  [GNU]: https://www.gnu.org/prep/standards/standards.html#Writing-C
  [GCC]: https://gcc.gnu.org/codingconventions.html#CandCxx
  [awesome-safety-critical]: https://github.com/stanislaw/awesome-safety-critical/tree/master/Backup
  [awesome-coding-standards]: https://github.com/abougouffa/awesome-coding-standards
