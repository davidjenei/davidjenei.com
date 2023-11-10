title: Logging practices
tags: #sw

Logging practices
=================

> **Go to**: [Log things that happened] · [Know when to use each log
> level] · [Separate actions and parameters] · [Consider adding
> correlation IDs] · [Include version information] · [Use consistent log
> format] · [Pay attention to readability]

Log things that happened
------------------------

In production, log after an action happened, not before. Make sure to
log all exceptions otherwise we might lose an event.

    do_calibration()
    echo "Auto-calibration completed"

Sometimes it's useful to log the start of a long running operation. In these
situations, make it clear that the message came before the event. Use
gerund and ellipsis (...):

    echo "Starting auto-calibration..."
    do_calibration()
    echo "Auto-calibration has completed"

In development or debug, log before.

Define log levels
-----------------

Ensure that the team agrees on what each log level means. Here is an
example for log level definitions:

**INFO**: Level for regular events. Use this to log that something has just
interacted with the software component, or we did something that has a
direct effect on others. Normally an info event belongs to the
components external interface.

Sometimes we can also log internal events, that change the software
behaviour significantly (caused by a combination of external events)

**DEBUG**: Level for describing internal behaviour and technical
details.

**WARNING**: Level for unusual events, that has no unexpected effect on
the outside world. The software worked according to the specification,
just not on the happy path.

**ERROR**: Level for unexpected events. Things that are:

-   not in the specification or it's not specified how we should deal
    with this
-   something bad happened that is out of our control (os error)
-   the software is not behaving as intended (internal error)

There is a chance that we can recover for now, but an error usually
requires some action later.

Separate actions and parameters
-------------------------------

Log messages consist of two parts:

-   hard-coded text - that should be unique in the code
-   parameters - that provide context

Keeping parameters separate from actions make it easirer to filter later
on.

Common parameters are:

-   log level
-   timestamp
-   tag
-   thread id

Use log formatters to separate parameters from the text:

    [info][2023-11-08 15:23:45.678][MyLogger][thread 12345] This is an example log message

Try separating message specific parameters too:

    Received response: {response.status_code} - {response.text}

Consider adding correlation IDs
-------------------------------

Certain events might generate more than one log message. Using a
correlation ID can help us in connecting a sequence of actions.

Include version information
---------------------------

Don't forget to log the version information on startup.

Use consistent log format
-------------------------

Reuse the same log formatter.

Pay attention to readability
----------------------------

Log messages are typically written with the expectation that humans will
read them. Use tabulation if the format allows that.

  [Logging practices]: #logging-practices
  [Log things that happened]: #log-things-that-happened
  [Define log levels]: #define-log-levels
  [Separate actions and parameters]: #separate-actions-and-parameters
  [Consider adding correlation IDs]: #consider-adding-correlation-ids
  [Include version information]: #include-version-information
  [Use consistent log format]: #use-consistent-log-format
  [Pay attention to readability]: #pay-attention-to-readability
  [Know when to use each log level]: #know-when-to-use-each-log-level
