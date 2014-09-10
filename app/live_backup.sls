# Simple script for getting database backup from live system
# !!! Important - this script requires s3cmd installed and setup !!!

/usr/local/bin/trex_get_live_db.sh:
  file:
    - managed
    - source: salt://app/files/app/bin/trex_get_live_db.sh
    - user: root
    - group: root
    - mode: 0755
    - require:
      - pkg: s3cm
