x11vnc:
  pkg.installed

run-x11vnc:
  cmd.run:
    - name: /usr/bin/x11vnc -reopen -forever -display :0 -bg
    - unless: pgrep x11vnc
    - user: root
    - group: root
    - require:
      - pkg: x11vnc
