Description
============

Cryptme is a minimal, open source secret manager (think 1Password CLI). Other secrets/password management solutions exist, and may be the right choice for you. This one favors simplicity; it attempts to do one thing well, with source code simple enough for an interested individual to quickly understand.


Installation
============

- Via gem
```bash
gem install cryptme
bundle exec cryptme
```

Usage
====
    cryptme # lists available commands

Prefix the above command with `bundle exec` when using Bundler.
    
Contributing
============

Contributions are welcome - simply create a PR against `master` for open issues or enhancements.

Publishing (gem)
----------

    gem build cryptme.gemspec
    gem push cryptme-X.X.X.gem

Publishing (macOS executable, under construction)
----
- install [ruby-packer](https://github.com/pmq20/ruby-packer) as `rubyc`
- rubyc bin/cryptme
- CRYPTME_VERSION=`cat lib/VERSION` mv a.out "cryptme-${CRYPTME_VERSION}"

Integration testing with Docker (under construction)
-----
- install Docker
- `CRYPTME_VERSION=`cat lib/VERSION`  docker build -t cryptme_integration_test --build-arg CRYPTME_EXECUTABLE="cryptme-${CRYPTME_VERSION}" . --no-cache`
- `docker run cryptme_integration_test`
- docker 
- The default docker file will simply call `cryptme`, then exit. Verify that exit code is 0, or modify the dockerfile to start `cryptme` interactively

Upcoming features
=================

TODO, top priority:
------
- setup CI
- installation by executable, Linux & Windows
- improve error messaging and signal handling

TODO, nice to have:
-----
Feature: smarter file location
  - always keep it in ~ ? permissions issues?
  - look for .cryptme file in current directory
  - or in given directory
  - after initialization, remember location in config file

more stable writing (handle IO failures)


Design and architecture decisions
====================
- for now, everything is decrypted at first , then encrypted before writing to disk
- never stores password on disk