reprepro:
  pkg.installed

repo-root:
  user.present

{% for dirname in ['conf', 'dists', 'incoming', 'indices', 'logs', 'pool', 'project', 'tmp'] %}
/srv/reprepro/ubuntu/{{ dirname }}:
  file.directory:
    - makedirs: True
    - user: repo-root
    - group: repo-root
    - require:
      - user: repo-root
{% endfor %}

/srv/reprepro/ubuntu/conf/distributions:
  file.managed:
    - source: salt://reprepro/distributions
    - user: repo-root
    - group: repo-root
    - require:
      - file: /srv/reprepro/ubuntu/conf

/srv/reprepro/ubuntu/conf/options:
  file.managed:
    - source: salt://reprepro/options
    - user: repo-root
    - group: repo-root
    - require:
      - file: /srv/reprepro/ubuntu/conf
