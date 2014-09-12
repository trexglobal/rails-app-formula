rails-app-formula
=================

Rails app formula to prepare deployment environment



Available states
================

.. contents:::local:

``app``
-------

Installs the rails-app deploy package.

``app.config``
-----------

Prepare application configuration by setting up user, directories and config files.

``app.packages``
-------------

Installs the pre-requisite packages.
!!! Please note ``app.config`` state file is required for this package. !!!

``app.live_backup``
-----------

Setup script for performing live database backup.

``app.indexing``
-----------

Installs script for indexing.

``app.deploy_app``
------------

Setup rails-app by deploying scripts.
