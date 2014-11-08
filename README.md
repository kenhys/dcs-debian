# dcs-debian

Dcs-debian is the command line tool which uses Debian Code Search to search debian/ files.

When working on Debian ITP, lintian sometimes reports pile of warnings or errors.
In such a case, I wonder how to fix this issue. How does other packages fix it?

This is the reason why I've created dcs-debian as thin wrapper of
Debian Code Search (http://codesearch.debian.net).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dcs-debian'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dcs-debian

## Usage

Here is the usage of dcs-debian:

    $ dcs-debian
    Commands:
      dcs-debian changelog KEYWORD  #
      dcs-debian control KEYWORD    #
      dcs-debian help [COMMAND]     # Describe available commands or one specific command
      dcs-debian rules KEYWORD      #

Just type specific keyword like this:

    $ dcs-debian rules groonga
    $ dcs-debian changelog closed
    $ dcs-debian control Standards

## Contributing

1. Fork it ( https://github.com/kenhys/dcs-debian/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
