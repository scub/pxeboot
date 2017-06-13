# -*- Firewall -*-
#
# The purpose of this state is to setup our Forwarding rules
# to provide a simple NAT for PXE booting nodes.
#
# ft=yaml

# Masquerade traffic not bound to 10.11.0.0/16
# iptables -t nat -A POSTROUTING -d ! 10.11.0.0/16 -j MASQUERADE
firewall_add_masquerade_forward:
  iptables.append:
    - table: nat
    - chain: POSTROUTING
    - destination: '! 10.11.0.0/16'
    - jump: 'MASQUERADE'

# Add global forwards to 192.168.0.0/16 
# iptables -t filter -A FORWARD -d 192.168.0.0/16 -j ACCEPT
firewall_add_global_dest_forward:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - destination: '10.11.0.0/16'
    - jump: 'ACCEPT'

# Add global forwards from 192.168.0.0/16
# iptables -t filter -A FORWARD -s 192.168.0.0/16 -j ACCEPT
firewall_add_global_source_forward:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - source: '10.11.0.0/16'
    - jump: 'ACCEPT'

# Add global rejects for other forwards
firewall_add_global_forward_reject:
  iptables.append:
    - table: filter
    - chain: FORWARD
    - jump: 'REJECT'
