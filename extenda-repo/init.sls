{% if pillar.extenda_repo is defined and pillar.extenda_repo.channels is defined %}
{% set channels = pillar.extenda_repo.channels %}
{% else %}
{% set channels = ['release', 'develop'] %}
{% endif %}

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
extenda-release-centraloffice-repo-create-{{ channel }}:
  pkgrepo.managed:
    - name: "extenda-centraloffice-{{ channel }}"
    - enabled: True
    - humanname: "Extenda Centraloffice ({{ channel }})"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/{{ channel }}/centraloffice
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working

extenda-release-pos-repo-create-{{ channel }}:
  pkgrepo.managed:
    - name: "extenda-pos-{{ channel }}"
    - enabled: True
    - humanname: "Extenda POS ({{ channel }})"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/{{ channel }}/pos
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working

extenda-release-setupdata-repo-create-{{ channel }}:
  pkgrepo.managed:
    - name: "extenda-setupdata-{{ channel }}"
    - enabled: True
    - humanname: "Extenda Setupdata ({{ channel }})"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/{{ channel }}/setupdata
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working
{% endfor %}
