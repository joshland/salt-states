include:
  - pip

python-pkgs:
  pkg.installed:
    - names:
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

raven:
  pip.installed:
    - require:
      - cmd: pip-command
