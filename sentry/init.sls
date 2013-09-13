include:
  - pip
  - virtualenv

sentry-user:
  user.present:
    - name: sentry
    - shell: /bin/bash
    - home: /home/sentry

sentry-env:
  virtualenv.managed:
    - runas: sentry
    - cwd: /home/sentry/sentry-app
    - require:
      - user: sentry-user

sentry:
  pip.installed:
    - name: sentry[postgres]
    - bin_env: /home/sentry/sentry-app/sentry-env
    - require:
      - cmd: pip-command
      - virtualenv: sentry-env
