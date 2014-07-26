{{ pillar['locale'] }}:
  locale.system

/etc/default/locale:
  file.append:
    - text:
      - LC_ALL={{ pillar['locale'] }}
      - LANG={{ pillar['locale'] }}
      - LC_CTYPE={{ pillar['locale'] }}
      - LC_COLLATE={{ pillar['locale'] }}
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: source /etc/profile
    - user: root
    - require:
        - file: /etc/default/locale
