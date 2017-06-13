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
    dhcp-option: '3,10.11.0.1'

    # DHCP Ranges
    dhcp-range: 'net:pxe,10.11.0.2,10.11.0.254,255.255.0.0,10.11.255.255,2d'

    # Boot PXELINUX Image
    dhcp-boot:  'net:pxe,pxelinux.0'


# saltstack-formulas/nginx-formula
#
#  Configure and enable nginx to serve our preseed
# files.
#
nginx:
  ng:
    service:
      enable: True

    server:
      config:
        worker_processes: 4
        pid: /run/nginx.pid
        events:
          worker_connections: 768
        http:
          sendfile: 'on'
          include:
            - /etc/nginx/mime.types
            - /etc/nginx/conf.d/*.conf
            - /etc/nginx/sites-enabled/*

    servers:
      managed:
        pxeboot:
          enabled: True
          overwrite: True # overwrite an existing server file or not
          config:
            - server:
              - server_name: 10.11.0.1
              - listen:
                - 10.11.0.1:80
              - index:
                - index.html
                - index.htm
              - location /:
                - root:
                  - '/srv/www'
