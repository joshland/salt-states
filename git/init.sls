{% for user in pillar['users'] %}
/home/{{ user['username'] }}/.gitconfig
  file.managed:
    - source: salt://git/gitconfig
    - context:
      - full_name: {{ user['full_name'] }}
      - email: {{ user['email'] }}
    - require:
      - user: {{ user['username'] }}
{% endfor %}
