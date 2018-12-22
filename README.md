# Haversack

Haversack is an enumerable abstraction of a [Knapsack](https://en.wikipedia.org/wiki/Knapsack_problem).

## Usage

```ruby
require 'haversack'

## Basic Usage:
haversack = Sack.new(capacity: 10, weight: 10)
items     = Array.new(10) { Haversack::Item.new(weight: 1, size: 1) }

haversack.contents = items

## Haversack provides constraints upon what items may be set as the knapsack contents:
too_large = Array.new(haversack.capacity + 1) { Haversack::Item.new }
haversack.contents = too_large # => Haversack::KnapsackCapacityExceededError

## Or you may add one item at a time
item = Haversack::Item.new
haversack.push item if haversack.will_fit? item
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

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/haversack.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
