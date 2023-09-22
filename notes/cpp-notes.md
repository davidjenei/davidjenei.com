Reading notes for *A Tour of C++*
=================================

Resources
---------

-   A Tour of C++
-   Scott Meyers: Effective C++ in an Embedded Environment
-   [Yale Datastructes and Programming Notes]
-   [C++ Stories]
-   [Fluent C+]

Intro
-----

statically typed - every entity must be known to the compiler at its
point of use

Initialisation
--------------

Use curly brace if in doubt. Except with `auto`. Prefer using = with
`auto`.

int i1 = 7.8 // i1 becomes 7 int i2 { 7.8 } // error: floating-point to
integer conversion

Use `auto` except when:

-   make type clearly visible to readers
-   we want to be explicit about range or precision (eg. double rather
    than float)

Scope
=====

-   Local scope = Functions scope in C + lamdba
-   Class scope
-   Namespace scope

Constants
=========

The value of `const` can be calculated runtime, but the value of
`constexpr` not.

constexpr double square(double x) { return x\*x; } constexpr double d1 =
square(var);	 // Error const double d1 = square(var);		 // OK!

Range-based for statement
=========================

int v\[\] = { 1, 2, 3, 4, 5}; for (auto x: v) cout \<\< x \<\< '\\n';

Reference
=========

Similar to pointer, but:

-   can be used without prefix `*` to access the referred value
-   cannot be made to refer different object after initialisation

We use reference to ensure that we do not copy the object. Use const to
make sure that we do not modify either.

double sum(const vector<double>&);

nullptr

int count(const char\* p, char x){ if(p==nullptr) // ensure that
dereferencing p is valid return 0; int count = 0; for (; \*p!=0; ++p) if
(\*p==x) ++count; return count; }

Tests
=====

Just like for statements, if statements can introduce a variable and
test it

if (auto n = v.size(); n!=0){ // we get here if n!=0 }

The most common case is for testing a variable against 0 or nullptr. To
do that simply leave out the condition.

if (auto n = v.size()){ // we get here if n!=0 }

Initialization
==============

Initialization is not assignment. Initialization = make unassigned
memory piece point to a valid object Assignment = Left must be lvalue.

int x = 7; int &r { x }; // bind r to x r = 7;

int &r2; // error r2 = 99; // ???

But you can use `=` for initialising reference;

int &r = x; // this is not a form of value copy

The basic semantics of argument passing and function value return are
that of initialization.

  [Yale Datastructes and Programming Notes]: http://www.cs.yale.edu/homes/aspnes/classes/223/notes.html#cplusplus
  [C++ Stories]: https://www.cppstories.com/p/start-here/
  [Fluent C+]: https://www.fluentcpp.com/posts/
