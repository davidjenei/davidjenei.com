tags: #embedded #ui

GUI on embedded Linux
===

https://medium.com/@kevmuhuri/top-five-libraries-for-creating-gui-on-embedded-linux-5ce03903be32

# WPE
[ELC 2007](https://translatedcode.wordpress.com/2016/11/03/installing-debian-on-qemus-32-bit-arm-virt-board/)
[RDK wiki: Wayland and Westeros](https://wiki.rdkcentral.com/display/RDK/WPE#WPE-WhyWesteros?)
[Igalia blog: Holepunch in WPE](https://blogs.igalia.com/magomez/2019/02/26/hole-punching-in-wpe/)
[fdo vs rdk fps](https://github.com/Igalia/meta-webkit/issues/92)

```
export GST_DEBUG="*:3"
export XDG_RUNTIME_DIR=/tmp
export WAYLAND_DISPLAY=main0

westeros --renderer libwesteros_render_dispmanx.so.0.0.0 --framerate 60 --display ${WAYLAND_DISPLAY} --enableCursor &

WPELauncher http://www.smashcat.org/av/canvas_test/
```
# QT
[QT Webengine video acceleration](https://wiki.qt.io/QtWebEngine/VideoAcceleration)
# GStreamer
[gst-omx](http://gstreamer-devel.966125.n4.nabble.com/Full-HD-with-gst-omx-on-Raspberry-Pi-td4667414.html)
