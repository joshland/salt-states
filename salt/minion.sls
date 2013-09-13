salt-minion:
  pkg:
    - latest
  service:
    - running
    - require:
      - pkg: salt-minion
