postgres-ppa:
  pkgrepo.managed:
    - hummanname: Martin Pitt's Postgres PPA
    - ppa: pitti/postgresq

{% with postgres_version = salt['pillar.get']('pkgs:postgres:version', '9.2') %}
postgresql:
  pkg.installed:
    - names:
      - postgresql-{{ postgres_version }}
      - postgresql-server-dev-{{ postgres_version }}
  service.running:
    - require:
      - pkg: postgresql
    - watch:
      - file: /etc/postgresql/{{ postgres_version }}/main/pg_hba.conf


/etc/postgresql/{{ postgres_version }}/main/pg_hba.conf:
  file.managed:
    - source: salt://postgresql/pg_hba.conf
    - require:
      - pkg: postgresql


/etc/postgresql/{{ postgres_version }}/main/postgresql.conf:
  file.managed:
    - source: salt://postgresql/postgresql.conf.jinja
    - template: jinja
    - context:
      postgres_version: {{ postgres_version }}
    - require:
      - pkg: postgresql

postgres-template:
  file.managed:
    - name: /etc/postgresql/{{ pillar['pkgs']['postgres']['version'] }}/main/make_template1_utf8.sh
    - source: salt://postgresql/make_template1_utf8.sh
    - user: postgres
    - group: postgres
    - mode: 755
  cmd.run:
    - name: bash /etc/postgresql/{{ pillar['pkgs']['postgres']['version'] }}/main/make_template1_utf8.sh
    - user: postgres
    - cwd: /var/lib/postgresql
    - unless: psql -U postgres -l|grep template1 |grep UTF8
    - require:
      - file: postgres-template
      - service: postgresql
{% endwith %}
