include:
  - base: postgresql

{% for name,config in salt['pillar.get']('postgresql:databases', {}).iteritems() %}
{{ config['user'] }}:
  postgres_user.present:
    - createdb: True
    - createuser: False
    - superuser: False
    - password: {{ config['password'] }}
    - require:
      - service: postgresql


{{ name }}:
  postgres_database.present:
    - owner: {{ config['user'] }}
    - encoding: UTF8
    - lc_collate: {{ pillar['locale'] }}
    - lc_ctype: {{ pillar['locale'] }}
    - require:
      - service: postgresql
      - postgres_user: {{ config['user'] }}


{% for extension in config.get('extensions', []) %}
postgres_extension_{{ extension }}:
  cmd.run:
    - name: psql -c "CREATE EXTENSION {{ extension }};"
    - user: postgres
    - onlyif: test -z `psql -c "select extname from pg_extension;" | grep {{ extension }}`
    - shell: /bin/bash
    - require:
      - service: postgresql
      - postgres_user: {{ config['user'] }}
      - postgres_database: {{ name }}
{% endfor %}
{% endfor %}
