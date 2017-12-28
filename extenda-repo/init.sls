extenda-s3-yum-plugin-conf:
  file.managed:
    - name: /etc/yum/pluginconf.d/extenda-s3.conf
    - source: salt://files/extenda-s3.conf
    - template: jinja
    - mode: 644

extenda-s3-yum-plugin:
  file.managed:
    - name: /usr/lib/yum-plugins/extenda-s3.py
    - source: salt://files/extenda-s3.py
    - mode: 644

extenda-repo-create:
  pkgrepo.managed:
    - name: "extenda"
    - enabled: True
    - humanname: "Extenda Secure Repo"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working
