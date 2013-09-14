include:
  - supervisor

x11vnc:
  pkg.installed

/etc/supervisor/conf.d/xvnc.conf:
  file.managed:
    - source: salt://xvnc/xvnc.conf
    - user: root
    - group: root

xvnc:
  supervisor.running:
    - require:
      - file: /etc/supervisor/conf.d/xvnc.conf
      - pkg: x11vnc
      - service: supervisor
