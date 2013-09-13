include:
  - pip

sentrypostgres:
  pip.installed:
    - require:
      - cmd: pip-command
