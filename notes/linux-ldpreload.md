tags: #linux

Override symbols with `LD_PRELOAD`
==================================

Override syslog implementation
------------------------------

    void syslog(int priority, const char *format, ...) { }

Compile
-------

    gcc -fPIC -shared -ldl -o noop-syslog.so noop-syslog.c
    LD_PRELOAD=noop-syslog.so

Make without Makefile
---------------------

    CFLAGS=-Itlpi-dist/lib LDFLAGS="-Ltlpi-dist" LDLIBS="-l:libtlpi.a" make hello-world
