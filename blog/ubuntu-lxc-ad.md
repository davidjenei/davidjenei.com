title: Join Ubuntu 18.04 LXC container to Active Directory

Join Ubuntu 18.04 LXC container to Active Directory
===================================================

An Active Directory service can help you manage user accounts effectively
even on Linux hosts. If you need a shared workstation with
a multiple users and already have a domain controller in your network,
you can join your servers to the domain instead of recreating accounts
and different access levels on each host manually.

There are plenty of tutorials out there how to do this on a Linux
machine. But if you prefer running [LXC
containers](https://linuxcontainers.org) as workstations rather than
regular VMs, you may need to change a few things like tweaking the
**uid/gid mapping**.

This short tutorial will show you how to join a newly created LXC container
to an Active Directory and how to configure SSH to login with your
domain account.

I will assume that you already:

- have a running Active Directory in your network
- have an administrator account for the AD server
- installed LXC on your Linux host

Let's start with launcing a new lxc container:

    lxc launch ubuntu:18.04 ad-join-test
    Creating ad-join-test
    Starting ad-join-test

Get a shell inside:

    lxc exec ad-join-test -- /bin/bash
    root@ad-join-test:~#

On Ubuntu or similar distros, we can use [System Security Services
Daemon](https://wiki.ubuntu.com/Enterprise/Authentication/sssd) (sssd)
for connecting to remote authentication providers. The documentation
recommends using an automated tool to configure it and here I am going
to use the
[realm](http://manpages.ubuntu.com/manpages/bionic/man8/realm.8.html)
command-line tool for quick enrollment.

But first we need to install realmd and a few more packages:

    root@ad-join-test:~# apt update && apt install realmd sssd-tools
    sssd libnss-sss libpam-sss adcli packagekit

Now we can try to discover our realm:

    root@ad-join-test:~# realm discover eilabs.local

In case of no answer here, make sure that you can resolve the name of
domain controller:

    root@ad-join-test:~# nslookup -type=srv _ldap._tcp.eilabs.local

> I couldn't resolve the domain name of my domain controller in the
> first place, because we used .local as top level domain, which is
> [nowadays intended to use in multicast
> DNS](https://github.com/systemd/systemd/issues/8852), so I had to
> change the systemd-resolver configuration.

If realm can discover the ldap service, use your administrator account
to join. Realm is a silent program, so I am going to use --verbose to
see the details of the process:

    root@ad-join-test:~# realm join eilabs.local --user=david.jenei --verbose

Now try to check connection to the domain controller and look up your
user passwd entry:

    root@ad-join-test:~# getent passwd david.jenei@eilabs.local

If you try to login now, you see that the system is using the `pam_sss`
module now as it should, but there is this error in the auth.log.

    pam_sss(login:auth): received for user david.jenei@eilabs.local: 4 (System error)

Changing the [debug log level in the
sssd](https://docs.pagure.org/SSSD.sssd/users/troubleshooting.html)
reveals that there is problem with the uid. If you would like see the
error message, put the debug directive under your domain's section in
the sssd configuration (/etc/sssd/sssd.conf) and restart sssd.

Here you can see, that my uid is way out of range, and the default id
mapping in sssd can't map those into the allocated uid map:

    root@ad-join-test:~# cat /proc/self/uid_map
             0     100000      65536
    root@ad-join-test:~# getent passwd david.jenei@eilabs.local
    david.jenei@eilabs.local:*:1149001181:1149000513:Jenei,
        David:/home/david.jenei@eilabs.local:/bin/bash

Add these lines to the sssd configuration for your domain to limit idmap
range and to **map uid/gid into the available space**.

    ldap_id_mapping = True
    ldap_idmap_range_min = 10000
    ldap_idmap_range_max = 50000
    ldap_idmap_range_size = 1000

I also changed the backup homedir line to a new home directory format
and enabled login without fully qualified names:

    use_fully_qualified_names = False
    override_homedir = /home/%d/%u

If you restart sssd after changing the configuration, it will fail,
because we also need to manually clear the cache:

    root@ad-join-test:~# rm -rf /var/lib/sss/db/*

Restart sssd service and login with your account:

    root@ad-join-test:~# systemctl restart sssd
    root@ad-join-test:~# login
    ad-join-test login: david.jenei
    Password:
    Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-88-generic x86_64)

Run pam-auth-update and enable home directory creation on login. Next
time you login, your home directory will be created automatically.

    root@ad-join-test:~# pam-auth-update

Finally edit /etc/ssh/sshd\_config and enable password login:

    PasswordAuthentication yes

Restart the ssh daemon and now you can use SSH with your AD user name to
login to your container.

    root@ad-join-test:~# systemctl restart sshd
    root@ad-join-test:~# ssh david.jenei@localhost

For more information, you can check out the details of uid mapping in
LXD
[here](https://ubuntu.com/blog/custom-user-mappings-in-lxd-containers%5D). 
