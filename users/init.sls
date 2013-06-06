{% for username,users in pillar['users'].iteritems %}
elbaschid:
  user.present:
    - fullname: {{ username }}
    - shell: {{ pillar['users']['shell'] }}
    - home: {{ pillar['users']['home'] }}
    - password: {{ pillar['users']['password'] }}
  ssh_auth.present:
    - user: {{ username }} 
    - comment: {{ pillar['users']['email'] }}
    - enc: {{ pillar['users']['ssh_key_type'] }}
    - names:
      - {{ pillar['users']['ssh_key'] }}
    - require:
      - user: {{ username }}
{% endfor %}
