tag: #linux
title: Not working nftables ruleset
maturity: 🌱

# Not working nftables ruleset

Why :80 and :443 ports are not accessible outside of my local network?

## Nftables

```
$ sudo nft -n -a list ruleset
table ip wg-quick-proton-de { # handle 21
        chain preraw { # handle 1
                type filter hook prerouting priority -300; policy accept;
                iifname != "proton-de" ip daddr 10.2.0.2 fib saddr type != 2 drop # handle 4
        }

        chain premangle { # handle 2
                type filter hook prerouting priority -150; policy accept;
                meta l4proto 17 meta mark set ct mark # handle 6
        }

        chain postmangle { # handle 3
                type filter hook postrouting priority -150; policy accept;
                meta l4proto 17 meta mark 0x0000ca6c ct mark set meta mark # handle 5
        }
}
table inet filter { # handle 22
        chain output { # handle 1
                type filter hook output priority 0; policy accept;
                tcp sport { 80, 443 } meta mark set 0x0000ca6c # handle 3
        }
}
```

## Routing table

`ip -4 rule add not fwmark 51820 table 51820 `

```
$ sudo ip route show table all
default dev proton-de table 51820 scope link
default via 192.168.1.1 dev end0 onlink
192.168.1.0/24 dev end0 proto kernel scope link src 192.168.1.250
local 10.2.0.2 dev proton-de table local proto kernel scope host src 10.2.0.2
local 127.0.0.0/8 dev lo table local proto kernel scope host src 127.0.0.1
local 127.0.0.1 dev lo table local proto kernel scope host src 127.0.0.1
broadcast 127.255.255.255 dev lo table local proto kernel scope link src 127.0.0.1
local 192.168.1.250 dev end0 table local proto kernel scope host src 192.168.1.250
broadcast 192.168.1.255 dev end0 table local proto kernel scope link src 192.168.1.250
local ::1 dev lo proto kernel metric 0 pref medium
local fe80::214:2dff:fe00:0 dev end0 proto kernel metric 0 pref medium
fe80::/64 dev end0 proto kernel metric 256 pref medium
multicast ff00::/8 dev end0 proto kernel metric 256 pref medium
multicast ff00::/8 dev proton-de proto kernel metric 256 pref medium
```

## Figure


![figure](https://i.stack.imgur.com/gKSNU.jpg)
