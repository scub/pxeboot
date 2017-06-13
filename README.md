PXE Server
----------

PXE Environment meant to assist with preseed testing. Relatively few moving parts, we utilize [dnsmasq-formula](https://github.com/saltstack-formulas/dnsmasq-formula) and [sysctl-formula](https://github.com/saltstack-formulas/sysctl-formula) from [saltstack-formulas](https://github.com/saltstack-formulas)

Dnsmasq is exposed over rfc 1918 space ```(10.11.0.0/24)``` using VirtualBox's ```Internal Network``` adapter on the ```intnet``` network. When configuring your VirtualBox PXE stub, you will want to set it up such that its only interface is bound to the ```intnet``` network.

To stand it up, make sure you initialize the submodules before using the Vagrantfile.

```
git submodule update --init --recursive
vagrant up --provision
```

Bootable images should be provided through the ```tftpboot/netboot``` directory, I would highly recommend using [Debian's](https://wiki.debian.org/PXEBootInstall#Provide_the_boot_image) [netboot](https://www.debian.org/distrib/netinst#netboot) image to start.
