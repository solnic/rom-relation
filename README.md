# Ruby Object Mapper

[![Gem Version](https://badge.fury.io/rb/rom-relation.png)][gem]
[![Build Status](https://travis-ci.org/rom-rb/rom-relation.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/rom-rb/rom-relation.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/rom-rb/rom-relation.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/rom-rb/rom-relation/badge.png?branch=master)][coveralls]

[gem]: https://rubygems.org/gems/rom-relation
[travis]: https://travis-ci.org/rom-rb/rom-relation
[gemnasium]: https://gemnasium.com/rom-rb/rom-relation
[codeclimate]: https://codeclimate.com/github/rom-rb/rom-relation
[coveralls]: https://coveralls.io/r/rom-rb/rom-relation

The mapper supports mapping data from any data source into Ruby objects
based on mapper definitions. It uses [axiom](https://github.com/dkubb/axiom),
a relational algebra library which will give us the ability to talk to
different data sources and even performing cross-database joins.

## Status

Currently rom-relation is going through a refactor. Mapper part is being extracted
into rom-mapper and the way relations and associations are handled is going to
change.

## Community

* [Google mailing list](https://groups.google.com/forum/?fromgroups#!forum/rom-rb)
* [#rom-rb](http://irclog.whitequark.org/rom-rb) channel on freenode
