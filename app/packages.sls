# Install pre-requisite packages

require:
  app.config

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
    - source: salt://app/files/aws/s3cfg
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
    - source: salt://app/files/bin/wkhtmltopdf-linux-amd64
    - user: root
    - group: root
    - mode: 0755
    - template: jinja
