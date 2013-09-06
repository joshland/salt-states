python-setuptools:
  pkg.installed

pip-command:
  cmd.run:
    - name: easy_install pip
    - unless: test -f /usr/local/bin/pip
    - require:
      - pkg: python-setuptools

/root/.pip/pip.conf:
  file.managed:
    - source: salt://pip/pip.conf
    - user: root
    - group: root
