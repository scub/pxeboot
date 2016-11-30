# -*- coding: utf-8 -*-
# vim: ft=yaml

# Run highstate every hour
schedule:
  highstate:
    function: state.highstate
    minutes: 60
    maxrunning: 1


