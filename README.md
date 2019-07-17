# Ruby basiq-sdk

Basiq SDK is a set of tools you can use to easily communicate with Basiq API.
It incapsulates all API requests and data trasformation.
The SDK is organized to mirror the HTTP API's functionality and hierarchy.
The top level object needed for SDKs functionality is the `Basiq::Client` object which requires your API key to be instantiated.

The API of the SDK is manipulated using `Basiq::Query` and `Basiq::Entities`.
Different queries return different entities, but the mapping is not one to one.

Some of the methods support adding filters to them.
The filters are created using the `Basiq::Query` class.
After instantiating the class, you can invoke methods in the form of comparison(field, value).

Work in progress...

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'basiq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install basiq

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/basiq-sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
