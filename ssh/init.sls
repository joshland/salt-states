openssh-client:
  pkg.installed

openssh-server:
  pkg.installed:
    - require:
      - pkg: openssh-client
  service.running:
    - name: ssh
    - require:
      - file: /etc/ssh/sshd_config
    - watch:
      - file: /etc/ssh/sshd_config

root-ssh-key:
  cmd.run:
    - name: ssh-keygen -t dsa -f /root/.ssh/id_dsa
    - unless: test -f /root/.ssh/id_dsa
    - user: root
    - group: root
    - shell: /bin/bash

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - require:
      - pkg: openssh-server

/etc/ssh/sshd_banner:
  file.managed:
    - source: salt://ssh/sshd_banner
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: openssh-server

ssh:
  service.running:
    - require:
      - file: /etc/ssh/sshd_config
      - pkg: openssh-server
