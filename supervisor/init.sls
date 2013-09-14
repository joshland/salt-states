supervisor:
  pip.installed

/etc/supervisor/supervisord.conf:
  file.managed:
    - template: jinja
    - require:
      - pip: supervisor
