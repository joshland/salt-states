include:
  - pip
  - virtualenv

sentry-user:
  user.present:
    - name: sentry
    - shell: /bin/bash
    - home: /home/sentry

/home/sentry/sentry-app/sentry-env:
  virtualenv.managed:
    - runas: sentry
    - require:
      - user: sentry-user

{{ pillar['sentry']['user'] }}:
  postgres_user.present:
    - password: {{ pillar['sentry']['password'] }}

{{ pillar['sentry']['database'] }}:
  postgres_database.present:
    - encoding: UTF-8
    - owner: {{ pillar['sentry']['user'] }}
    - template: template1
    - require:
      - postgres_user: {{ pillar['sentry']['user'] }}

sentry:
  pip.installed:
    - name: sentry[postgres]
    - bin_env: /home/sentry/sentry-app/sentry-env
    - require:
      - cmd: pip-command
      - virtualenv: /home/sentry/sentry-app/sentry-env
