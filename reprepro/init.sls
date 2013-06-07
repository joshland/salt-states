reprepro:
  pkg.installed

repo-root:
  user.present

{% for dirname in ['conf', 'dists', 'incoming', 'indices', 'logs', 'pool', 'project', 'tmp'] %}
/srv/reprepro/ubuntu/{{ dirname }}:
  file.directory:
    - user: repo-root
    - group: repo-group
    - require:
      - user: repo-root
{% endfor %}
