# MCLI
[![codecov](https://codecov.io/gh/thomas07vt/mcli/branch/master/graph/badge.svg)](https://codecov.io/gh/thomas07vt/mcli)

Creating command line tools is a :cake: . This gem is basically a wrapper around the ruby ```OptionParser``` class. It turns your ruby objects into parsers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mcli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mcli

## Usage

1. Require MCLI

```ruby
require 'mcli'
```

2. Create a ```MCLI::Command``` subclass

```ruby
class MyCommand < MCLI::Command
end
```

3. Call the Command Runner

```ruby
MCLI.run
```

### Examples

#### Arguments

```ruby
#args.rb
```
```ruby
#!/usr/bin/env ruby
require 'mcli'

class Args < MCLI::Command
  register_as :args

  def run
    puts "The passed args are: #{args.inspect}"
  end
end

MCLI.run
```

```bash
$ ./args.rb args first second
The passed args are: ["first", "second"]
```

##### Options with aliases

```ruby
#options.rb
```
```ruby
#!/usr/bin/env ruby
require 'mcli'

class Options < MCLI::Command
  register_as :options
  option :say, alias: :s

  def run
    puts "Saying: #{options[:say]}"
  end
end

MCLI.run
```

```bash
$ ./options.rb options --say 'hello'
Saying: hello
$ ./options.rb options -s 'hello'
Saying: hello
```

##### Options with defaults

```ruby
#options.rb
```
```ruby
#!/usr/bin/env ruby
require 'mcli'

class Options < MCLI::Command
  register_as :options
  option :say, alias: :s, default: 'hello'

  def run
    puts "Saying: #{options[:say]}"
  end
end

MCLI.run
```

```bash
$ ./options.rb options --say hi
Saying: hi
$ ./options.rb options -s hi
Saying: hi
$ ./options.rb options
Saying: hello
```

##### Required Options

```ruby
#options.rb
```
```ruby
#!/usr/bin/env ruby
require 'mcli'

class Options < MCLI::Command
  register_as :options
  option :say, alias: :s, required: true

  def run
    puts "Saying: #{options[:say]}"
  end
end

MCLI.run
```

```bash
$ ./options.rb options --say hi
Saying: hi
$ ./options.rb options -s hi
Saying: hi
$ ./options.rb options
mcli/lib/mcli/command.rb:25:in `block in parse': missing argument:  (OptionParser::MissingArgument)
  mcli/lib/mcli/command.rb:23:in `map'
  mcli/lib/mcli/command.rb:23:in `parse'
  mcli/lib/mcli/command.rb:62:in `block in call'
  mcli/lib/mcli/command.rb:60:in `tap'
  mcli/lib/mcli/command.rb:60:in `call'
  mcli/lib/mcli.rb:17:in `run'
  from options.rb `<main>'

```

##### Boolean Options

```ruby
#options.rb
```
```ruby
#!/usr/bin/env ruby
require 'mcli'

class Options < MCLI::Command
  register_as :options
  option :heads, alias: :h, boolean: true

  def run
    puts "Heads: #{options[:heads]}"
  end
end

MCLI.run
```

```bash
$ ./options.rb options --heads
Heads: true
$ ./options.rb options --no-heads
Heads: false
```

##### Capturing all arguments

```ruby
#capture.rb
```
```ruby
#!/usr/bin/env ruby
require 'mcli'

class Options < MCLI::Command
  register_as :capture
  capture_all!

  def run
    puts "#{arg.inspect}"
  end
end

MCLI.run
```

```bash
$ ./capture.rb capture --toast=cool one two -a ok three
["--toast=cool", "one", "two", "-a", "ok", "three"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thomas07vt/mcli.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
