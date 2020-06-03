# Crunchbase4

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/crunchbase4`. To experiment with that code, run `bin/console` for an interactive prompt.

[Crunchbase v4 API Document](https://app.swaggerhub.com/apis/Crunchbase/crunchbase-enterprise_api/1.0.1)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crunchbase4'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install crunchbase4

## Usage

## Configure your amazon certificate

```
require 'crunchbase4'

CB_CONFIG = YAML.load(File.read('crunchbase.yml'))
Crunchbase4.config do |c|
  c.user_key = CB_CONFIG['user_key']
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/encoreshao/crunchbase4. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/encoreshao/crunchbase4/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Crunchbase4 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/encoreshao/crunchbase4/blob/master/CODE_OF_CONDUCT.md).
