Interview Question Breakdown: Bad C Analysis
============================================

[5 June 2017] by [Phillip Johnston]

**Updated:** 20190910

When interviewing developers, I like to use questions that are flexible
and provide many avenues for investigation and discussion. A good
interview question allows the interviewer to adjust the difficulty or
intensity based on the candidate's skill level and performance.

One of my favorite questions in this category is "Bad [C] Analysis".
This question provides a platform for discussing:

-   Basic C operations
-   How the stack works
-   What happens on the stack when you enter/exit functions
-   Undefined behavior & the impact of undefined behavior in a program
-   How optimizations affect a program

Let's dive in.

**Table of Contents:**

-   Problem Setup
-   Lines of Questioning
    -   Stack
    -   Is that output guaranteed?
    -   Optimizations
    -   Undefined Behavior
    -   Compiler Warnings
-   Overall Strategy
-   Example Source

Problem Setup
-------------

I begin the question by writing the following program on a whiteboard:

    #include <stdio.h>

    void foo(void)
    {
        int a = 5;
        int b;
    }

    void bar(void)

    {
        int x;
        printf("%d\n", x++);
    }

    int main(void)
    {
        foo();
        bar();
        bar();

        return 0;
    }

You can modify the functions to fit any variety of forms, but ultimately
you need the following base features

1.  A function which declares a variable on the stack and initializes it
2.  A different function which declares a variable on the stack and uses
    it uninitialized
3.  Call function \#1, then call function \#2 a few times

Lines of Questioning
--------------------

One the problem has been set up on the whiteboard, I start by asking the
candidate what the program will do when it's run. You'll generally get a
few types of answers:

-   "5 & 6"
    -   This is the expected answer
    -   The uninitialized variable "a" in bar grabs the value of the
        memory, which just so happens to be initialized to "5" from the
        previous function.
    -   N.B.: Since the behavior is undefined, this may not be true on
        every compiler
    -   This is true if optimizations are disabled -- a particularly
        savvy candidate may call this out up front
-   "6 & 7"
    -   Candidate didn't think about the post-increment operator
        carefully enough
-   "Some garbage value, and some garbage value + 1"
    -   This is a possibility. Ask the candidate why they think it would
        be garbage.
        -   If the candidate says optimizations, ask what might happen
            in an unoptimized case
    -   From here, you can continue the questioning by asking the
        candidate how the stack works, and what happens with the stack
        frames for `foo()` and `bar()`

If you don't believe that 5 and 6 would actually be output, here's the
result of [the program] run on [OS] X 10.14.5 with Apple clang 8.0.0
with no optimizations:

    $ ./buildresults/interview/bad_c
    5
    6

### Stack

If the candidate has trouble figuring out what the program would output,
start digging into the stack with the candidate:

-   When `int a` and `int b` are declared, where are they placed? (Onto
    the stack)
-   How does the stack work?
    -   Draw an example stack on the white board and illustrate what
        happens when `foo()` is called
    -   Demonstrate what happens to the stack when `foo()` returns
        to `main()`
    -   Demonstrate what happens to the stack when `bar()` is called
-   At this point, ask the candidate again what they'd expect the
    program to output

### Is that output guaranteed?

Once the candidate has figured out the answer, I will typically ask
whether this behavior is reliable, and what conditions they might expect
the output to vary under. I'm checking whether the candidate can see
what's happening yet (undefined behavior). Here are some potentials:

-   If the stack is handled differently (perhaps order of variables?)
-   If there are other initializations or function calls in between, the
    value on the stack may be different
-   If there is an interrupt or some other context change in the program
    flow that results in the stack being modified before
    entering `bar()`
-   The fact that it's undefined behavior means all bets are off
-   Turning on optimizations usually modifies the output

### Optimizations

After the correct answer is identified and we discuss how output can
vary, I usually ask whether the candidate would expect the program to
return the same value if optimizations were turned on. If they mentioned
optimizations earlier, I usually immediately jump to this line of
questioning.

-   What would the output be if optimizations are enabled? (garbage
    values)
-   What optimizations may be affecting the code?
    -   unused variables being discarded
    -   `foo()` may be empty after unused variable optimization, and
        that function may be stripped out completely
    -   Your stack variables may be placed into registers instead -- you
        have no guarantee that you'll pick up the previously initialized
        value depending on program flow

### Undefined Behavior

With particularly knowledgable candidates, you can dig further into the
details of undefined behavior. You can start by asking, "Why does this
even work at all?" and lead to further discussion points:

-   What does undefined behavior actually mean?
-   Undefined behavior in the C standard
-   What are the benefits of undefined behavior to compiler
    implementors?
-   What are the dangers of relying on undefined behavior for your
    program to function correctly?

### Compiler Warnings

It's important to note that that modern compilers will warn you about
the use of an uninitialized variable (depending on your warning
configuration). This may be a useful discussion area to explore with the
candidate. Would they expect a warning? Would they listen to it? Do they
see why this warning is helpful in pointing out an error?

    [6/7] Compiling C object 'interview/interview@@bad_c@exe/bad.c.o'.
    ../interview/bad.c:5:6: warning: unused variable 'a' [-Wunused-variable]
            int a = 5;
                ^
    ../interview/bad.c:6:6: warning: unused variable 'b' [-Wunused-variable]
            int b;
                ^
    ../interview/bad.c:12:17: warning: variable 'x' is uninitialized when used here [-Wuninitialized]
            printf("%d\n", x++);
                           ^
    ../interview/bad.c:11:7: note: initialize the variable 'x' to silence this warning
            int x;
                 ^
                  = 0
    3 warnings generated.

Overall Strategy
----------------

This question can take 5 minutes or an entire hour depending on the
candidate's skill level. I generally explore each of the concept areas
above unless it is clear that a developer is very talented.

If a candidate does not immediately get the answer, start by walking
through stack operations and guide the candidate to the answer.

Remember, this question is a framework: guide your interview based on
the response of your candidate, probing in areas where they seem
exceptionally skilled or particularly weak. Every candidate experience
should be different: don't follow a fixed script!

Example Source
--------------

You can find the [bad C sample source code][the program] in
the [embedded-resources Github repository].

Change Log
----------

-   **20190910:**
    -   Demoted headers for consistency across the website
    -   Added a table of contents
-   **20190627:**
    -   Changed variable naming per feedback from Jerry Fitzpatrick
    -   Added example output from running the program
    -   Added discussion point about compiler warnings

  [5 June 2017]: https://embeddedartistry.com/blog/2017/06/05/interview-question-breakdown-bad-c-analysis/
  [Phillip Johnston]: https://embeddedartistry.com/blog/author/phillip/
  [C]: https://embeddedartistry.com/fieldmanual-terms/c/
  [the program]: https://github.com/embeddedartistry/embedded-resources/blob/master/interview/bad.c
  [OS]: https://embeddedartistry.com/fieldmanual-terms/operating-system/
  [embedded-resources Github repository]: https://github.com/embeddedartistry/embedded-resources/blob/master/interview/
