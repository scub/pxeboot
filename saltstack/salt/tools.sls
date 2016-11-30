# -*- Tools -*-
#
# The purpose of this state is to provide some basic
# tooling not provided through the default bento image.
#
# ft=yaml

tools_vim_nox:
  pkg.installed:
    - name: vim-nox

tools_tcpdump:
  pkg.installed:
    - name: tcpdump

tools_tmux:
  pkg.installed:
    - name: tmux

tools_cpio:
  pkg.installed:
    - name: cpio
