docker-ppa:
  pkgrepo.managed:
    - humanname: Docker PPA
    - ppa: dotcloud/lxc-docker

lxc-docker:
  pkg.installed:
    - require:
      - pkgrepo: docker-ppa
