saltstack-ppa:
  pkgrepo.managed:
    - humanname: Salt Stack PPA
    - name: deb http://ppa.launchpad.net/saltstack/salt/ubuntu {{ grains['oscodename'] }} main
    - dist: {{ grains['oscodename'] }}
    - keyid: 4759FA960E27C0A6
    - keyserver: keyserver.ubuntu.com
