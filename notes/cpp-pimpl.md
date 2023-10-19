tags: #cpp

Pointer to implementation pattern
=================================

Alternative names: compilation firewall, opaque pointer, d-pointer (as
in data).

Pack everything that is private into a forward declared class.

Origins
-------

This is a variant of the `Handle/Body` idiom:

> A group of [DesignPatterns], in which the implementation of something
> (the "body") is separated from its interface by means of a level of
> indirection (the "handle"). Client code operates on the handle, which
> then operates on the body; either by simply forwarding/delegating
> requests or by adapting a protocol.

**Problem**: headers serve as interfaces, but also a declaration site
for potential implementation details.

Methods must be declared inside the class. Classes without methods are
useless, so class definitions usually appear in header files. This means
private data and private methods are also visible in the header.

**Related problem**: virtual functions can be used as interfaces but
this is a runtime object oriented concept. There is a tension between
this and generic programming. As an example we can't have function
templates as virtual functions. See [Type Erasure] and [Static
Interfaces].

**Solution**: Pack everything that is private into a forward declared
class. The compiler can work without having a full type declaration,
only the size of the pointer is needed. There is no need to recompile
the unit if the implementation changes.

-   when implementation changes, no need to recompile users - reduce
    compilation times
-   long term stable header files - maintain binary compatibility
-   module files do not contain implementation details

> For instance, Nokia’s “Qt Development Frameworks” department (formerly
> Trolltech) has carried out profound changes to the widget rendering at
> least twice during the development of their “Qt 4” class library
> without the need to so much as relink programs using Qt 4.
> [https://wiki.qt.io/D-Pointer]

Header:

    class Parser {
    public:
        Parser(const char *params);
        ~Parser();

        void parse(const char *input);

        // Other methods related to responsibility of the class
        ...

    private:
        Parser(const Parser&);              // noncopyable
        Parser& operator=(const Parser&);   //

        class Impl;     // Forward declaration of the implementation class
        Impl *impl_;    // PIMPL
    };

Source:

    // Include all headers the implementation requires

    // The actual implementation definition:
    class Parser::Impl {
    public:
        Impl(const char *params) {
            // Actual initialization
            ...
        }

        void parse(const char *input) {
            // Actual work
            ...
        }
    };

    // Create an implementation object in ctor
    Parser::Parser(const char *params)
    : impl_(new Impl(params))
    {}

    // Delete the implementation in dtor
    Parser::~Parser() { delete impl_; }

    // Forward an operation to the implementation
    void Parser::parse(const char *input) {
        impl_->parse(input);
    }

    // Forward other operations to the implementation
    ...

Pros and cons
-------------

Pros:

-   breaks compile time dependencies
-   help maintaining binary compatibility

Cons:

-   extra memory allocation
-   extra indirection
-   more boilerplate
-   debugging
-   semantics of `const` change

Potential issue: const
----------------------

In C/C++ `const` is shallow.

     SomeThing & Class::someThing() const {
          return d->someThing;
     }

`this` is `const Class*` and `d` is `Class::Private * const`

[Solution][]: overload `operator*()` and `operator->()` and forward
constness to `*d`

Solution 2: access `d` through an overloaded function which returns
`const` if needed.

Potential issue: Copyable and moveable object boilerplate
---------------------------------------------------------

Using `std::unique_ptr` pointer seems like a good choice to avoid using
raw pointers and also expresses the intent that the implementation is
exclusively owned by the pointer.

But forward declaration and `std::unique_ptr` doesn't play well. We need
to define the implementation before generating the default special
members, because `unique_ptr`'s destructor requires a complete type, so
we need to define the destructor in the implementation file.

This prevents the compiler from generating default move constructor and
move assignement. If we need a copyable class we need even more
boilerplate.

And this violates rule of zero. [Potential workaround].

Potential issue: Back pointer (q-pointer)
-----------------------------------------

Often a function in the pimpl must call a function in the visible class,
usually because the called function is public or virtual.

Potential issue: Extra memory allocation
----------------------------------------

Custom allocator, `aligned_storage`. See [Fast Pimpl]

[What should be put into the private implementation]
----------------------------------------------------

**Only private data**

This a good start, we can get rid of the includes needed for the
implementation.

**Only the private methods**

And leave some private members. See [Priv]. Less boilerplate, more
speed.

**All private members**

Client code shouldn't care about implementation. Full isolation.

Future
------

-   [Modules] - c++20
-   Operator dot - c++23?

  [DesignPatterns]: https://wiki.c2.com/?HandleBodyPattern
  [Type Erasure]: https://www.artima.com/articles/on-the-tension-between-object-oriented-and-generic-programming-in-c
  [Static Interfaces]: https://www.fluentcpp.com/2017/05/16/what-the-crtp-brings-to-code/
  [https://wiki.qt.io/D-Pointer]: https://wiki.qt.io/D-Pointer
  [Solution]: https://marcmutz.wordpress.com/translated-articles/pimp-my-pimpl-reloaded/
  [Potential workaround]: https://oliora.github.io/2015/12/29/pimpl-and-rule-of-zero.html
  [Fast Pimpl]: https://www.cppstories.com/2018/01/pimpl/#fast-pimpl
  [What should be put into the private implementation]: https://herbsutter.com/gotw/_100/
  [Priv]: https://yairchu.github.io/posts/the-priv-idiom
  [Modules]: https://en.cppreference.com/w/cpp/language/modules
