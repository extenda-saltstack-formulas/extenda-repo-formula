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

extenda-release-centraloffice-repo-create:
  pkgrepo.managed:
    - name: "extenda-centraloffice"
    - enabled: True
    - humanname: "Extenda Centraloffice"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/release/centraloffice
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working

extenda-release-pos-repo-create:
  pkgrepo.managed:
    - name: "extenda-pos"
    - enabled: True
    - humanname: "Extenda POS"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/release/pos
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working

extenda-release-setupdata-repo-create:
  pkgrepo.managed:
    - name: "extenda-setupdata"
    - enabled: True
    - humanname: "Extenda Setupdata"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/release/setupdata
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working

extenda-develop-centraloffice-repo-create:
  pkgrepo.managed:
    - name: "extenda-centraloffice-dev"
    - enabled: True
    - humanname: "Extenda Centraloffice (dev)"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/develop/centraloffice
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working

extenda-develop-pos-repo-create:
  pkgrepo.managed:
    - name: "extenda-pos-dev"
    - enabled: True
    - humanname: "Extenda Centraloffice (dev)"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/develop/pos
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working

extenda-develop-setupdata-repo-create:
  pkgrepo.managed:
    - name: "extenda-setupdata-dev"
    - enabled: True
    - humanname: "Extenda Setupdata (dev)"
    - baseurl: https://s3-eu-west-1.amazonaws.com/extenda-packages/{{ grains["customer"] }}/develop/setupdata
    - gpgcheck: 0 #we'll change to 1 later once we get PGP signing working
