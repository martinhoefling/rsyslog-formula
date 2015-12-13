{% from "rsyslog/map.jinja" import rsyslog with context %}

package_{{ rsyslog.package }}:
  pkg:
    - name: {{ rsyslog.package }}
    - installed

service_{{ rsyslog.service }}:
  service.running:
    - name: {{ rsyslog.service }}
    - enable: True
    - require:
      - pkg: package_{{ rsyslog.package }}
    - watch:
      - file: config_{{ rsyslog.config }}

config_{{ rsyslog.config }}:
  file.managed:
    - name: /etc/rsyslog.conf
    - template: jinja
    - source: salt://rsyslog/templates/rsyslog.conf.jinja
    - context:
      config: {{ salt['pillar.get']('rsyslog', {}) }}

rsyslog_{{ rsyslog.workdirectory }}:
  file.directory:
    - name: {{ rsyslog.workdirectory }}
    - user: {{ rsyslog.runuser }}
    - group: {{ rsyslog.rungroup }}
    - mode: 755
    - makedirs: True

{% for filename in salt['pillar.get']('rsyslog:custom', ["50-default.conf"]) %}
{% set basename = filename.split('/')|last %}
rsyslog_custom_{{basename}}:
  file.managed:
    - name: {{ rsyslog.custom_config_path }}/{{ basename|replace(".jinja", "") }}
    {% if basename != filename %}
    - source: {{ filename }}
    {% else %}
    - source: salt://rsyslog/files/{{ filename }}
    {% endif %}
    {% if filename.endswith('.jinja') %}
    - template: jinja
    {% endif %}
    - watch_in:
      - service: {{ rsyslog.service }}
{% endfor %}
