include:
  - base: locale

postgres-pitti-ppa:
  pkgrepo.absent:
    - ppa: pitti/postgresql
    
postgres-ppa:
  pkgrepo.managed:
    - humanname: Postgres PPA
    - name: deb http://apt.postgresql.org/pub/repos/apt {{ grains['oscodename'] }}-pgdg main
    - key_url: http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc


{% with postgres_version = salt['pillar.get']('pkgs:postgres:version') %}
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
      - file: /etc/postgresql/{{ postgres_version }}/main/postgresql.conf
      - file: /etc/postgresql/{{ postgres_version }}/main/postgresql.conf.include


/etc/postgresql/{{ postgres_version }}/main/pg_hba.conf:
  file.managed:
    - source: salt://postgresql/pg_hba.conf
    - require:
      - pkg: postgresql


/etc/postgresql/{{ postgres_version }}/main/postgresql.conf:
  file.append:
    - text: include_if_exists "/etc/postgresql/{{ postgres_version }}/main/postgresql.conf.include"
    - require:
      - pkg: postgresql

/etc/postgresql/{{ postgres_version }}/main/postgresql.conf.include:
  file.managed:
    - source: salt://postgresql/postgresql.conf.include.jinja
    - template: jinja
    - context:
      postgres_version: {{ postgres_version }}
      locale: {{ pillar['locale'] }}
    - require:
      - pkg: postgresql
      - file: /etc/postgresql/{{ postgres_version }}/main/postgresql.conf
{% endwith %}
