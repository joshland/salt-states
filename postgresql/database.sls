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
    - encoding: {{ pillar['locale'] }}
    - lc_collate: {{ pillar['locale'] }}
    - lc_ctype: {{ pillar['locale'] }}
    - require:
      - service: postgresql
      - postgres_user: {{ config['user'] }}


{% for extension in config.get('extensions', []) %}
{{ extension }}:
  postgres_extension.present:
    - maintainance_db: {{ name }}
    - require:
      - service: postgresql
      - postgres_user: {{ config['user'] }}
      - postgres_database: {{ name }}
{% endfor %}
{% endfor %}
