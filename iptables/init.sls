iptables:
  pkg.installed

/etc/iptables.rules:
  file.managed:
    - user: root
    - group: root
    - mode: 640
    - source: salt://iptables/iptables.rules
    - template: jinja
    - watch:
      - pkg: iptables

iptables-load:
  cmd.wait:
    - name: /sbin/iptables-restore < /etc/iptables.rules
    - watch:
      - file: /etc/iptables.rules
