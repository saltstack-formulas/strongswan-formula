# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set topdir = tpldir.split('/')[0] %}
{%- from tpldir ~ "/map.jinja" import strongswan with context %}
{%- from tpldir ~ "/macros.jinja" import files_switch with context %}

{%- set connections = salt['pillar.get']('strongswan:conn', {}) %}

include:
  - .install

ipsec-global-options:
  file.managed:
    - name: {{ strongswan.config.global_options }}
    - source: {{ files_switch(
                    salt['config.get'](
                        topdir ~ ':tofs:files:ipsec-global-options',
                        ['ipsec.conf.jinja']
                    )
              ) }}
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - context:
      dropin_dir: {{ strongswan.config.dropin_options }}
      connections: {{ connections }}

{% if connections %}
ipsec-dropin-options:
  file.directory:
    - name: {{ strongswan.config.dropin_options }}
    - user: root
    - group: root
    - clean: True
{% endif %}

