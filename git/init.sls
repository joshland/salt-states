git-pgk:
  pkg.installed:
    - name: git

{% for username, user in pillar['users'].iteritems() %}
/home/{{ username }}/.gitconfig:
  file.managed:
    - source: salt://git/gitconfig
    - template: jinja
    - context:
      full_name: {{ user['full_name'] }}
      email: {{ user['email'] }}
#    - require:
#      - user: {{ username }}
{% endfor %}
