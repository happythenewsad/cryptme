Description
============

Cryptme is a minimal, open source secret manager (think 1Password CLI).


Installation
============
    gem install cryptme
    
Contributing
============

Contributions are welcome - simply create a PR for open issues or enhancements.

Publishing
----------

    gem build cryptme.gemspec
    gem push cryptme-X.X.X.gem


Upcoming features
=================

TODO, top priority:
------

cleanup spec that touches file 'newpath.txt' in root dir
bin release


TODO, nice to have:
-----
Feature: smarter file location
  - always keep it in ~ ? permissions issues?
  - look for .cryptme file in current directory
  - or in given directory
  - after initialization, remember location in config file
enforce .cryptme file extension
brew installation
more stable writing (handle IO failures)

DONE
----
command line processing
better exception message for incorrecr password
works from different directories
copy to clipboard

Design and architecture decisions
====================
- for now, everything is decrypted at first , then encrypted before writing to disk
- never stores password on disk