title: Naming software abstractions
tags: #documentation
description: Bad practices
maturity: 🌱

Naming software abstractions
==

Words I don't find particularly useful when I'm trying to understand someone else's program code.

"Element"
--

I've seen a number of times programmers naming their most fundamental abstractions an
"element". Not as an extra postfix, they simply called their base abstraction
an "element".

To me this doesn't tell anything about this abstraction, other then that
these things have some form of relation to each other. It tells nothing
about the nature of this relation, or the abstraction itself. The only
thing I know that there is some connection.

Euclyd in his book have a solid justification for that. If we come up
with such fundamental concepts that form a foundation for an abstract
science like geometry then fine. But in practical engineering we rarely
do this. I think there is a good chance that we can come up with a name
that tells a bit more.

Another 'Element' example:

> Elements The most important object in GStreamer for the application
> programmer is the GstElement object. An element is the basic building
> block for a media pipeline. All the different high-level components
> you will use are derived from GstElement. Every decoder, encoder,
> demuxer, video or audio output is in fact a GstElement

> What are elements? For the application programmer, elements are best
> visualized as black boxes. On the one end, you might put something in,
> the element does something with it and something else comes out at the
> other side. For a decoder element, for example, you'd put in encoded
> data, and the element would output decoded data. In the next chapter
> (see Pads and capabilities), you will learn more about data input and
> output in elements, and how you can set that up in your application. -
> [Gstreamer]

"Base"
---

Base class? It probably should be composition instead of inheritance.

"Stub"
--

???

  ["Element"]: #element
  [Gstreamer]: https://gstreamer.freedesktop.org/documentation/application-development/basics/elements.html?gi-language=c
