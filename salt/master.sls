salt-master:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/salt/master

/srv/salt/projects:
  file.directory:
    - makedirs: True
    - user: root
    - group: root
    - mode: 0755

/etc/salt/master:
  file.managed:
    - source: salt://salt/master.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - require:
      - file: /srv/salt/projects

{% for name, project in pillar.projects.items() %}
{{ project.repo }}:
  git.latest:
    - rev: master
    - target: /srv/salt/projects/{{ name }}
{% endfor %}
