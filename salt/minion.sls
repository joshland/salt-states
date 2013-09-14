salt-minion:
  pkg:
    - latest
  service:
    - running
    - require:
      - pkg: salt-minion
    - watch:
      - file: /etc/salt/minion

/etc/salt/minion:
  file.managed:
    - source: salt://salt/minion.jinja
    - template: jinja
