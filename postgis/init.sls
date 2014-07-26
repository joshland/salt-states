include:
  - postgresql

postgis-packages:
  pkg.installed:
    - names:
      - postgis
      - postgresql-{{ salt['pillar.get']('pkgs:postgres:version') }}-postgis-{{ salt['pillar.get']('pkgs:postgis:version') }}
