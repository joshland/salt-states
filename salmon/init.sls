include:
  - virtualenv

{% with salmon_user="salmon-user" %}
{{ salmon_user }}:
  user.present:
    - fullname: Salmon User
    - shell: /bin/bash
    - home: /home/{{ salmon_user }}

/home/{{ salmon_user }}/salmon:
  file.directory:
    - user: {{ salmon_user }}
    - require:
      - user: {{ salmon_user }}

/home/{{ salmon_user }}/salmon/env:
  virtualenv.managed:
    - runas: {{ salmon_user }}
    - system_site_packages: False
    - require:
      - user: {{ salmon_user }}

salmon:
  pip.installed:
    - bin_env: /home/{{ salmon_user }}/salmon/env
    - user: {{ salmon_user }}
    - require:
      - user: {{ salmon_user }}

salmon init:
  cmd.run:
    - name: source /home/{{ salmon_user }}/salmon/env/bin/activate && salmon init
    - shell: /bin/bash
    - unless: test -f /home/{{ salmon_user }}/.salmon/conf.py
    - user: {{ salmon_user }}
    - cwd: /home/{{ salmon_user }}/salmon/env
    - require:
      - pip: salmon
      - user: {{ salmon_user }}

/home/{{ salmon_user }}/.salmon/checks.yaml:
  file.managed:
    - source: salt://salmon/checks.yaml
    - user: {{ salmon_user }}
    - group: {{ salmon_user }}
    - require:
      - cmd: salmon init

salmon upgrade:
  cmd.run:
    - name: source /home/{{ salmon_user }}/salmon/env/bin/activate && salmon upgrade --noinput
    - shell: /bin/bash
    - user: {{ salmon_user }}
    - cwd: /home/{{ salmon_user }}/salmon/env
    - require:
      - cmd: salmon init

salmon collectstatic:
  cmd.run:
    - name: source /home/{{ salmon_user }}/salmon/env/bin/activate && salmon collectstatic --noinput
    - shell: /bin/bash
    - user: {{ salmon_user }}
    - cwd: /home/{{ salmon_user }}/salmon/env
    - require:
      - cmd: salmon upgrade

salmon start:
  cmd.run:
    - name: source /home/{{ salmon_user }}/salmon/env/bin/activate && salmon start
    - shell: /bin/bash
    - user: {{ salmon_user }}
    - cwd: /home/{{ salmon_user }}/salmon/env
    - require:
      - cmd: salmon collectstatic
{% endwith %}
