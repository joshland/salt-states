include:
  - pip

virtualenv-command:
  pip.installed:
    - name: virtualenv
    - require:
      - cmd: pip-command

{% for build in pillar['builds'] %}
{% with project_dir = ['/var', 'www', pillar['client'], pillar['project']]|join("/") %}
{{ project_dir }}/virtualenvs/{{ build }}:
  virtualenv.managed:
    - no_site_packages: True
    - require:
      - pip: virtualenv-command

{{ project_dir }}/virtualenvs/{{ build }}/bin/activate:
  file.append:
    - text:
      - export DJANGO_CONF="conf.{{ build }}"

{{ project_dir }}/run/{{ build }}:
  file.directory:
    - makedirs: True
    - user: www-data
    - group: www-data
    - mode: 0755
    - recurse:
      - user
      - group
      - mode

{{ project_dir }}/logs/{{ build }}:
  file.directory:
    - makedirs: True
    - user: www-data
    - group: www-data
    - mode: 0755
    - recurse:
      - user
      - group
      - mode

{{ project_dir }}/media/{{ build }}:
  file.directory:
    - makedirs: True
    - user: www-data
    - group: www-data
    - mode: 0755
    - recurse:
      - user
      - group
      - mode
{% endwith %}
{% endfor %}
