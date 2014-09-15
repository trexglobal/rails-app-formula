# Set app env
/etc/profile.d/app.sh:
  file:
    - managed
    - user: root
    - group: root
    - mode: 755
    - source: salt://app/files/profile/app.sh
    - template: jinja


# Invoke ruby/rake command
/usr/local/bin/apprun:
  file:
    - managed
    - source: salt://app/files/app/bin/apprun
    - template: jinja
    - user: root
    - group: root
    - mode: 0755


# Setup logrotate
/etc/logrotate.d/app:
  file:
    - managed
    - user: root
    - group: root
    - mode: 440
    - source: salt://app/files/app/etc/logrotate.d/app


# Setup script for email notifications
/usr/local/bin/notify:
  file:
    - managed
    - source: salt://app/files/app/bin/notify
    - template: jinja
    - user: root
    - group: root
    - mode: 0755
