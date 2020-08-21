Description
============

Cryptme is a minimal, open source secret manager (think 1Password CLI).


Installation
============

- Via gem
```bash
gem install cryptme
bundle exec cryptme
```
- Via executable
```bash
    under construction
```

| Environment | Supported? |
| ----------- | ----------- |
| macOS 10.15     |       |
| Windows   |        |
| Linux | |

Usage
====
    cryptme # lists available commands

Prefix the above command with `bundle exec` when using Bundler.
    
Contributing
============

Contributions are welcome - simply create a PR against `master` for open issues or enhancements.

Publishing
----------

    gem build cryptme.gemspec
    gem push cryptme-X.X.X.gem


Upcoming features
=================

TODO, top priority:
------
brew installation

TODO, nice to have:
-----
Feature: smarter file location
  - always keep it in ~ ? permissions issues?
  - look for .cryptme file in current directory
  - or in given directory
  - after initialization, remember location in config file

more stable writing (handle IO failures)

DONE
----
command line processing
better exception message for incorrecr password
works from different directories
copy to clipboard
cleanup spec that touches file 'newpath.txt' in root dir
bin release
enforce .cryptme file extension

Design and architecture decisions
====================
- for now, everything is decrypted at first , then encrypted before writing to disk
- never stores password on disk