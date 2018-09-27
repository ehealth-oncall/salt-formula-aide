{% from "aide/map.jinja" import aide_map with context %}

aide:
  pkg.installed:
    - name: aide
  cmd.run:
    - name: 'aide --init'
    - unless: 'test -f {{ salt['pillar.get']('aide:lookup:define.DBDIR_RO') }}/aide.db.gz'
    - require:
      - pkg: aide
  file.managed:
    - name: /etc/aide.conf
    - source: salt://aide/files/aide.conf
    - template: jinja
    - user: root
    - group: root
    - mode: 0600
    - require:
      - pkg: aide
    - context:
      aide_map: {{ aide_map }}
