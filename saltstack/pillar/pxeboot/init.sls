# -*- coding: utf-8 -*-
# vim: ft=yaml

# saltstack-formulas/sysctl-formula
#
# Enable IP Forwarding to allow PXE booting
# boxes to NAT out through the PXE server.
#
sysctl:
  lookup:
    pkg: procps
    config:
      location: '/etc/sysctl.d'
  params:
    net.ipv4.ip_forward:
      value: 1
      config: net.conf

# saltstack-formulas/dnsmasq-formula
#
# Enable TFTP and configure DHCP to boot off
# the share.
#
dnsmasq:
  dnsmasq_conf: salt://dnsmasq/files/dnsmasq.conf
  dnsmasq_hosts: salt://dnsmasq/files/dnsmasq.hosts
  dnsmasq_cnames: salt://dnsmasq/files/dnsmasq.cnames
  dnsmasq_conf_dir: salt://dnsmasq/files/dnsmasq.d

  settings:
    port: 53
    domain: 'rawr.us.local'
    interface:
      - eth1
      - lo

    # Enable TFTP for PXE
    enable-tftp:      True
    log-dhcp:         True
    tftp-root:        '/srv/tftpboot/netboot'

    # DHCP Host Filter (PXE Whitelist) 
    dhcp-host: "08:00:27:*:*:*,net:pxe"

    # DHCP Configuration 
    dhcp-lease-max:   254
    # Provide us as the Gateway
    dhcp-option: '3,192.168.101.1'

    # DHCP Ranges
    dhcp-range: 'net:pxe,192.168.101.2,192.168.101.254,255.255.0.0,192.168.255.255,2d'

    # Boot PXELINUX Image
    dhcp-boot:  'net:pxe,pxelinux.0' 
