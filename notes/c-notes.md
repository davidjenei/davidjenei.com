tags: #sw #c #book

Reading notes for the book *Effective C*
========================================

Operator names
--------------

     & address-of operator
     * indirection
     [] subscript
     . stucture member
     -> structure pointer
     ^ bitwise exclusive xor

Standards, coding styles and guidelines
---------------------------------------

**Korte** introduce a subset of the language in order to:

-   avoid bugs
-   increase portability
-   increase readability
-   improve security

so C can be used in safety-related systems. Usually doesn't cover coding
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

Terminology
-----------

-   **object**: storage in which you can represent values - variable +
    malloc
-   **type**: tells you the kind of object its value represent
-   **variable**: example of an object with type
-   **function**: not an object, but do have type
-   **identifier**: when you declare a variable, assign it a type and an
    identifier
-   **scope**: applies to identifiers
-   **scope** != lifetime
-   **scope**: file, block, function declaration
-   **lifetime**: applies to objects
-   **type qualifier**: `const`, `volatile`
-   **storage class specifier**: `auto`, `static`, `extern`, `register`
-   **tag**: special naming mechanism for enums, stucts and unions. not
    type name. eg.
    `enum status { ok, fail }; enum status status(void); // valid`

Misc
----

Typedef is weird, this is valid:

    typedef signed char schar_type, *schar_p, (*fp)(void);

Never declare functions with an empty parameter list in C. This is a
deprecated feature of the language that may be removed in the future.

    int fip() // C: any number, any type
    int fip() // C++: no argument

Function pointers:

    int *fip() // function type returning int* with no specified parameter
    typedef signed char (*fp)(void); // function type fp returning signed char pointer, no arguments

    typedef void fv(int), (*pfv)(int);
    void (*signal(int, void(*)(int)))(int);
    fv *signal(int, fv *);
    pfv signal(int, pfv);”

Types
-----

signed integer types - signed char, short int, int, long int, long long
int

signed integer overlow is undefined (see ABS macro), unsigned wraparound
is well-defined in C, some encryption algorithms use it, however width
depends on the implementation

and don't forget the promotion:

    unsigned short i = USHRT_MAX;
    i *= INT_MAX; /* <- signed arithmetic, overflows, produces undefined behavior */

floating point types (always signed) - float,double,long double

Constants
---------

octal: starts with a 0, optionally followed by digits 0 through 7

integer suffixes: none means `int`, U `unsinged`, L `long`, LL

floating point suffixes: none means `double` (implicit), F `float`, L
`long`,

    float x = 0.5; // Implicit double literal, converted to float

    i = x; // The value of x is converted from float to int.

    x += 2.5; // Before the addition, the value of x is converted to //
    double. Afterward, the sum is converted to float for // assignment to x.

    x = sqrt( i ); // Calculate the square root of i:
    // The argument is converted from int to double; the return
    // value is converted from double to float for assignment to x.

    long my_func() {
        ...
        return 0; // The constant 0 is converted to long, the function's return
                  // type.
     }

Implicit conversions
--------------------

-   Integer promotion - integer types smaller than int are promoted,
    result of (s1 \* s2) / s3 can be short, but perform operations in
    natural size.

-   Usual arithmetic conversion - if one type is floating point, convert
    the other. if none is floating, none signed, convert to the bigger.
    if signed can represent all values of the unsigned one

-   two-complement representation makes conversion to larger types easy
    sign extension

<!-- markdown... -->

    signed char c = -1 // ==
    unsigned int i = UINT_MAX
    // promotion, sign extension, different signedness, equal rank,
    performed as unsigned (==) operator

Assignment
----------

**lvalue**: locator value, it must designate an object. can be an
expression, as long as it references an object eg. `*(p+4)`

`str[i]` is identical to `*(str+i)`

postfix increment (p++) has higher precedence than prefix or unary

    char abc[] = "abc";
    char xyz[] = "xyz";
    char *p = abc;
    printf("%c", ++*p);

    p = xyz;
    printf("%c", *p++);” // bx

Command line argumens
---------------------

Under \*nix type systems with exec() calls, `argv[0]` will be whatever
the caller puts into the argv0 spot in the `exec()` call.

  [Reading notes for the book *Effective C*]: #reading-notes-for-the-book-effective-c
  [Operator names]: #operator-names
  [Standards, coding styles and guidelines]: #standards-coding-styles-and-guidelines
  [Terminology]: #terminology
  [Misc]: #misc
  [Types]: #types
  [Constants]: #constants
  [Implicit conversions]: #implicit-conversions
  [Assignment]: #assignment
  [Command line argumens]: #command-line-argumens
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
