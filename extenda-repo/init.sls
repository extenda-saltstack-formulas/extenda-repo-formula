{% if pillar.extenda_repo is defined and pillar.extenda_repo.channels is defined %}
  {% set channels = pillar.extenda_repo.channels %}
{% else %}
  {% set channels = ['release', 'develop'] %}
{% endif %}

{% set products = ['centraloffice', 'pos', 'eps', 'setupdata', 'selfscan','storeagent'] %}

extenda-s3-yum-plugin-conf:
  file.managed:
    - name: /etc/yum/pluginconf.d/extenda-s3.conf
    - source: salt://extenda-repo/files/extenda-s3.conf
    - template: jinja
    - mode: 644

extenda-s3-yum-plugin:
  file.managed:
    - name: /usr/lib/yum-plugins/extenda-s3.py
    - source: salt://extenda-repo/files/extenda-s3.py
    - mode: 644

{% for channel in channels %}
  {% for product in products %} 
extenda-release-{{ product }}-repo-create-{{ channel }}:
  pkgrepo.managed:
    - name: "extenda-{{ product }}-{{ channel }}"
    - enabled: True
    - humanname: "Extenda {{ product }} ({{ channel }})"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/{{ channel }}/{{ product }}
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working
  {% endfor %}
{% endfor %}
