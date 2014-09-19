# Install pre-requisite packages


app_pkgs:
  pkg.installed:
    - names:
      - pdftk
      - libfontconfig
      - libfontconfig1
      - s3cmd

/srv/.s3cfg:
  file:
    - managed
    - source: salt://rails-app/files/app/config/s3cfg
    - user: app
    - group: app
    - mode: 0750
    - template: jinja
    - require:
      - pkg: s3cmd
      - user: app



/usr/bin/wkhtmltopdf:
  file:
    - managed
    - source: salt://rails-app/files/app/bin/wkhtmltopdf-linux-amd64
    - user: root
    - group: root
    - mode: 0755
    - template: jinja


# Setup unicorn
/etc/init/unicorn.conf:
  file:
    - managed
    - source: salt://rails-app/files/unicorn/etc/init/unicorn.conf
    - user: root
    - group: root
    - mode: 0744

/etc/sudoers.d/unicorn:
  file:
    - managed
    - source: salt://rails-app/files/unicorn/etc/sudoers.d/unicorn
    - user: root
    - group: root
    - mode: 0440

unicorn:
  service:
    - name: monit
    - running
    - enable: True
    - restart: True

/etc/monit/conf.d/unicorn:
  file:
    - managed
    - source: salt://rails-app/files/unicorn/etc/monit/conf.d/unicorn
    - user: root
    - group: root
    - mode: 0444

unicorn_monit_restart:
  service:
    - name: monit
    - running
    - enable: True
    - restart: True
    - require:
      - file: /etc/monit/conf.d/unicorn
    - watch:
      - file: /etc/monit/conf.d/unicorn
