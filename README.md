# Ruby basiq-sdk

[![Build Status](https://travis-ci.com/Warshavski/basiq-sdk.svg?branch=develop)](https://travis-ci.com/Warshavski/basiq-sdk)

Ruby SDK for interacting with [BASIQ REST API](https://api.basiq.io/reference).

Basiq provides a collection of APIs to help you build powerful financial solutions for a wide range of use cases.

## Introduction

Before you can start using any of the available Basiq APIs there are a few things you will need to do first.

 - [Sign-up](https://dashboard.basiq.io/login) to the Basiq API service
 - Grab your API key for your application (via the [Developer Dashboard](https://dashboard.basiq.io/))
 - Once you have successfully obtained an API key, you can start using any of the available Basiq APIs.

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

Basiq SDK is a set of tools you can use to easily communicate with Basiq API.
It encapsulates all API requests and data transformation.
The SDK is organized to mirror the HTTP API's functionality and hierarchy.
The top level object needed for SDKs functionality is the `Basiq::Client` object which requires your API key to be instantiated.

The API of the SDK is manipulated using `Basiq::Query` and `Basiq::Entities`.
Different queries return different entities, but the mapping is not one to one.

Some of the methods support adding filters to them.
The filters are created using the `Basiq::Query` class.
After instantiating the class, you can invoke methods in the form of comparison(field, value).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/warshavski/basiq-sdk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
