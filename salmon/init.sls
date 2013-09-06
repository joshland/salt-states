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
    - user: {{ salmon_user }}
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
    - user: {{ salmon_user }}
    - cwd: /home/{{ salmon_user }}/salmon/env
    - require:
      - pip: salmon
      - user: {{ salmon_user }}

salmon upgrade:
  cmd.run:
    - user: {{ salmon_user }}
    - cwd: /home/{{ salmon_user }}/salmon/env
    - require:
      - cmd: salmon init

salmon collectstatic:
  cmd.run:
    - user: {{ salmon_user }}
    - cwd: /home/{{ salmon_user }}/salmon/env
    - require:
      - cmd: salmon upgrade

salmon start:
  cmd.run:
    - user: {{ salmon_user }}
    - cwd: /home/{{ salmon_user }}/salmon/env
    - require:
      - cmd: salmon collectstatic
{% endwith %}
