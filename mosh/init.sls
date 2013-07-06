mosh-ppa:
  pkgrepo.managed:
    - humanname: Mosh Server PPA
    - ppa: keithw/mosh

mosh:
  pkg.installed:
    - require:
      - pkgrepo: mosh-ppa
