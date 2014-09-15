# Simple script to backup user index by exporting mongo database on reinforcement 
# This script doesn't work!
/usr/local/bin/backup_user_index:
  file:
    - managed
    - source: salt://rails-app/files/app/bin/backup_user_index
    - template: jinja
    - user: root
    - group: root
    - mode: 0755


# Simple script for indexing user on amazon
/usr/local/bin/amazon_user_index:
  file:
    - managed
    - source: salt://rails-app/files/app/bin/amazon_user_index
    - user: root
    - group: root
    - mode: 0755


# Simple script for indexing local user
/usr/local/bin/local_user_index:
  file:
    - managed
    - source: salt://rails-app/files/app/bin/local_user_index
    - user: root
    - group: root
    - mode: 0755
