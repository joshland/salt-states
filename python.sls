python-pkgs:
  pkg.installed:
    - names:
      - python-setuptools

easy_install pip:
  cmd.run:
    - unless: test -f /usr/local/bin/pip
    - require:
      - pkg: python-pkgs
