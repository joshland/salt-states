python-pkgs:
  pkg.installed:
    - names:
      - python-setuptools
      - python-dev
      - build-essential

python-imaging-deps:
  pkg.installed:
    - names:
      - libtiff4-dev
      - libjpeg8-dev
      - zlib1g-dev
      - libfreetype6-dev
      - liblcms1-dev
      - libwebp-dev

pip-command:
  cmd.run:
    - name: easy_install pip
    - unless: test -f /usr/local/bin/pip
    - require:
      - pkg: python-pkgs

/root/.pip/pip.conf:
  file.managed:
    - source: salt://python/pip.conf
    - user: root
    - group: root
