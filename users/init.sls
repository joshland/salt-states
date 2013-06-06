{% for username, user in pillar['users'].iteritems() %}
elbaschid:
  user.present:
    - fullname: {{ username }}
    - shell: {{ user['shell'] }}
    - home: {{ user['home'] }}
    - password: {{ user['password'] }}
  ssh_auth.present:
    - user: {{ username }} 
    - comment: {{ user['email'] }}
    - enc: {{ user['ssh_key_type'] }}
    - names:
      - {{ user['ssh_key'] }}
    - require:
      - user: {{ username }}
{% endfor %}
