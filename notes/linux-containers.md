tags: #linux #containers

# Podman, slirp4netrns and source IP

`podman run` [man](https://docs.podman.io/en/latest/markdown/podman-run.1.html)

> port_handler=slirp4netns: Use the slirp4netns port forwarding, it is slower
> than rootlesskit but preserves the correct source IP address. This port
> handler cannot be used for user-defined networks.

`podman-compose` by default creates separate nw namespaces for my rootless
containers. But I need a valid source IP to:

* disable authentiaction when connecting from my home network

workaround: use one pod

    podman pod create -p 80:80 -p 443:443 --network
    slirp4netns:port_handler=slirp4netns

# Terminal commands

[bocker: Docker implemented in 100 lines of
bash](https://github.com/p8952/bocker)
