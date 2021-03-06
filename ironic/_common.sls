{%- from "ironic/map.jinja" import api,conductor, system_cacerts_file with context %}
{%- if api.get("enabled", False) %}
  {%- set ironic, service_name = api, 'api' %}
{%- elif conductor.get('enabled', False) %}
  {%- set ironic, service_name = conductor, 'conductor' %}
{%- endif %}

ironic_common_pkgs:
  pkg.installed:
    - name: 'ironic-common'
    - install_recommends: False

/etc/ironic/ironic.conf:
  file.managed:
  - source: salt://ironic/files/{{ ironic.version }}/ironic.conf
  - template: jinja
  - require:
    - pkg: ironic_common_pkgs

{%- if ironic.message_queue.get('ssl',{}).get('enabled', False) %}
rabbitmq_ca_ironic_{{ service_name }}:
{%- if ironic.message_queue.ssl.cacert is defined %}
  file.managed:
    - name: {{ ironic.message_queue.ssl.cacert_file }}
    - contents_pillar: ironic:{{ service_name }}:message_queue:ssl:cacert
    - mode: 0444
    - makedirs: true
{%- else %}
  file.exists:
   - name: {{ ironic.message_queue.ssl.get('cacert_file', system_cacerts_file) }}
{%- endif %}
{%- endif %}

{%- if ironic.database.get('ssl',{}).get('enabled', False) %}
mysql_ca_ironic_{{ service_name }}:
{%- if ironic.database.ssl.cacert is defined %}
  file.managed:
    - name: {{ ironic.databse.ssl.cacert_file }}
    - contents_pillar: ironic:{{ service_name }}:database:ssl:cacert
    - mode: 0444
    - makedirs: true
{%- else %}
  file.exists:
   - name: {{ ironic.database.ssl.get('cacert_file', system_cacerts_file) }}
{%- endif %}
{%- endif %}
