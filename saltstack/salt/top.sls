# -*- Top File -*-
#
#  
#
base:
  'pxeboot*':
    - match: pcre
    - tools
    - firewall
    - dnsmasq
    - sysctl
