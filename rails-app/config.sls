# Create app user
app:
  user.present:
    - fullname: Application User
    - shell: /bin/bash
    - home: /srv
    - uid: 4000
    - gid_from_name: True


# Setup directory for config files
/srv:
  file.directory:
    - user: app
    - group: app
    - mode: 0755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: app

/srv/shared:
  file.directory:
    - user: app
    - group: app
    - mode: 0755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: app

/srv/shared/config:
  file.directory:
    - user: app
    - group: app
    - mode: 0755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: app
      - file: /srv/shared

# RED-1823 Setup bin directory 
/srv/shared/bin:
  file.directory:
    - user: {{ pillar['rails-app']['user'] }}
    - group: {{ pillar['rails-app']['user'] }}
    - mode: 0755
    - makedirs: True
    - source: salt://rails-app/files/app/shared/bin
    - recurse:
      - user
      - group
      - mode
    - require:
      - user: {{ pillar['rails-app']['user'] }}
      - file: /srv/shared

/srv/shared/log/index:
  file.directory:
    - user: app
    - group: app
    - mode: 0755
    - makedirs: True
    - require:
        - user: app


# Create backup directory
/srv/shared/backup/mongo:
  file.directory:
    - user: app
    - group: app
    - mode: 0755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - require:
        - user: app


# Setup config files for unicorn, database, application, amazon_s3
/srv/shared/config/unicorn.rb:
  file:
    - managed
    - source: salt://rails-app/files/app/config/unicorn.rb
    - user: app
    - group: app
    - mode: 0755
    - require:
       - file: /srv/shared/config
       - user: app

/srv/shared/config/database.yml:
  file:
    - managed
    - source: salt://rails-app/files/app/config/database.yml
    - user: app
    - group: app
    - mode: 0755
    - template: jinja
    - require:
       - file: /srv/shared/config
       - user: app

/srv/shared/config/application.yml:
  file:
    - managed
    - source: salt://rails-app/files/app/config/application.yml
    - user: app
    - group: app
    - mode: 0755
    - template: jinja
    - require:
       - file: /srv/shared/config
       - user: app

/srv/shared/config/amazon_s3.yml:
  file:
    - managed
    - source: salt://rails-app/files/app/config/amazon_s3.yml
    - user: app
    - group: app
    - mode: 0755
    - template: jinja
    - require:
       - file: /srv/shared/config
       - user: app
