Description
============

Melon is a minimal, open source secret manager (think 1Password CLI).


Installation
============

Contributing
============

Contributions are welcome - simply create a PR for open issues or enhancements.


Upcoming features
=================

TODO, top priority:
command line processing DONE
better exception message for incorrecr password DONE
works from different directories DONE
copy to clipboard DONE
gem release
bin release


TODO, nice to have:
Feature: smarter file location
  - always keep it in ~ ? permissions issues?
  - look for .melon file in current directory
  - or in given directory
  - after initialization, remember location in config file
brew installation
more stable writing (handle IO failures)




Design and architecture decisions
====================
- for now, everything is decrypted at first , then encrypted before writing to disk
- never stores password on disk