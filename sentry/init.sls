include:
  - pip

sentrypostgres:
  pip.installed:
    - require:
      - cmd: pip-command
      - pkgrepo: postgres-ppa
