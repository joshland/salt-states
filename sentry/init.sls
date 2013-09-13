include:
  - pip

sentry:
  pip.installed:
    - name: sentry[postgres]
    - require:
      - cmd: pip-command
