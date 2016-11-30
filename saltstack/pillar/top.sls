base:
  'pxeboot*':
    - schedule.highstate.hourly
    - pxeboot
