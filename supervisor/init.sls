supervisor:
  pip.installed

/etc/supervisord.conf:
  file.managed:
    - template: jinja
    - require:
      - pip: supervisor
