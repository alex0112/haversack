# Haversack
[![Build Status](https://travis-ci.org/alex0112/haversack.svg?branch=master)](https://travis-ci.org/alex0112/haversack) [![Maintainability](https://api.codeclimate.com/v1/badges/7ff5206188bb44910d07/maintainability)](https://codeclimate.com/github/alex0112/haversack/maintainability)


Haversack is an enumerable abstraction of a [Knapsack](https://en.wikipedia.org/wiki/Knapsack_problem).

## Usage

### Stub
...

#### Or you may add one item at a time
```ruby
item = Haversack::Item.new
haversack.push item if haversack.fits_item? item
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'haversack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install haversack


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alex0112/haversack.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
