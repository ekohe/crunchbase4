# Crunchbase

A Ruby Library for Crunchbase API v4 -  [CB-v4 Doc](https://app.swaggerhub.com/apis/Crunchbase/crunchbase-enterprise_api/1.0.1)

[![Gem Version](https://badge.fury.io/rb/crunchbase4.svg)](https://badge.fury.io/rb/crunchbase4)
[![Build Status](https://travis-ci.org/encoreshao/crunchbase4.svg?branch=master)](https://travis-ci.org/encoreshao/crunchbase4)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crunchbase4', github: 'ekohe/crunchbase4'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install crunchbase4

## Usage

## Configure your API certificate

```
require 'crunchbase4'

CB_CONFIG = YAML.load(File.read('crunchbase.yml'))
Crunchbase.config do |c|
  c.user_key = CB_CONFIG['user_key']
end

OR

Crunchbase.config.user_key = CB_CONFIG['user_key']
```

## Get the organization data

```
pry(main)> client = Crunchbase::Client.new
pry(main)> response = client.organization('ekohe')
=> #<Crunchbase::Models::Organization:0x00007fbc5cfdf2f8
 @categories=["Apps", "Artificial Intelligence", "Big Data", "E-Commerce", "Enterprise Software", "FinTech", "iOS", "Retail", "UX Design"],
 @category_groups=["Apps", "Artificial Intelligence", "Commerce and Shopping", "Data and Analytics", "Design", "Financial Services", "Mobile", "Platforms", "Science and Engineering", "Software"],
 @company_type="for_profit",
 @contact_email="info@ekohe.com",
 @created_at="2013-05-14T14:28:38Z",
 ...
 ...>
pry(main)> response.name
=> "Ekohe"
pry(main)> response.permalink
=> "ekohe"
```

OR if you want to get the json data, please call `response.as_json` in your project.

## Get the person data

```
pry(main)> client = Crunchbase::Client.new
pry(main)> response = client.person('mark-zuckerberg')
=> #<Crunchbase::Models::Person:0x00007ffbf201d178
 @aliases=["Zuck"],
 @born_on="1984-05-14",
 @created_at="2007-05-26T04:51:46Z",
 @entity_def_id="person",
 @entity_id="mark-zuckerberg",
 @facebook="https://www.facebook.com/zuck",
 @facet_ids=["investor", "rank"],
 @first_name="Mark",
 @gender="male",
...>
pry(main)> response.name
=> "Mark Zuckerberg"
pry(main)> response.permalink
=> "mark-zuckerberg"
```

OR if you want to get the json data, please call `response.as_json` in your project.

```
pry(main)> response.as_json
=> {:born_on=>"1984-05-14",
 :created_at=>"2007-05-26T04:51:46Z",
 :died_on=>nil,
 :entity_def_id=>"person",
 :facebook=>"https://www.facebook.com/zuck",
 :facet_ids=>["investor", "rank"],
 :first_name=>"Mark",
 :gender=>"male",
 :identifier=>"Mark Zuckerberg",
 :image_id=>"v1448830269/gzcifut4c2xah95x0ewd.jpg",
 :image_url=>"https://res.cloudinary.com/crunchbase-production/image/upload/v1448830269/gzcifut4c2xah95x0ewd.jpg",
 :investor_stage=>["seed"],
 :investor_type=>["investment_partner", "angel"],
 :last_name=>"Zuckerberg",
 :layout_id=>"investor",
 ....>
```

## Get the funding round data

```
pry(main)> client = Crunchbase::Client.new
=> #<Crunchbase::Client:0x00007f8806824c28>
pry(main)> response = client.funding_round('371c20af-8aa9-4bcb-a8da-0694d138f247')
=> #<Crunchbase::Models::FundingRound:0x00007f8806b55ca8
 @announced_on="2013-06-30",
 @closed_on=nil,
 @created_at="2020-04-02T12:17:59Z",
 @entity_def_id="funding_round",
 @funded_organization_categories=nil,
 @funded_organization_description="Facebook is an online social networking service that enables its users to connect with friends and family.",
 @funded_organization_funding_stage="ipo",
 @funded_organization_funding_total=2335700000,
 @funded_organization_identifier="Facebook",
 @funded_organization_location=["Menlo Park", "California", "United States", "North America"],
 @funded_organization_revenue_range="r_10000000",
 ....>
pry(main)> response.name
=> "Secondary Market - Facebook"
pry(main)> response.uuid
=> "371c20af-8aa9-4bcb-a8da-0694d138f247"
```

OR if you want to get the json data, please call `response.as_json` in your project.

```
pry(main)> response.as_json
=> {:created_at=>"2020-04-02T12:17:59Z",
 :entity_def_id=>"funding_round",
 :funded_organization_categories=>nil,
 :funded_organization_description=>"Facebook is an online social networking service that enables its users to connect with friends and family.",
 :funded_organization_funding_stage=>"ipo",
 :funded_organization_funding_total=>2335700000,
 :funded_organization_identifier=>"Facebook",
 :funded_organization_location=>["Menlo Park", "California", "United States", "North America"],
 :funded_organization_revenue_range=>"r_10000000",
 :identifier=>"Secondary Market - Facebook",
 :image_id=>"rde5yhdgakaqryj6zpu6",
 :investor_identifiers=>["Jean-Brice Abrial"],
 :is_equity=>false,
 :lead_investor_identifiers=>nil,
 :num_partners=>nil,
 :num_relationships=>nil,
 :permalink=>"facebook-secondary-market--371c20af",
 :pre_money_valuation=>nil,
 :rank=>1881995,
 :rank_funding_round=>21406,
 :updated_at=>"2020-04-02T12:17:59Z",
 :uuid=>"371c20af-8aa9-4bcb-a8da-0694d138f247",
 :name=>"Secondary Market - Facebook",
 :announced_on=>"2013-06-30",
 :closed_on=>nil,
 :investment_stage=>nil,
 :investment_type=>"secondary_market",
 :money_raised=>nil,
 :target_money_raised=>nil,
 :num_investors=>1,
 :short_description=>"Facebook raised an undisclosed amount on 2013-06-30 in Secondary Market"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/crunchbase4. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ekohe/crunchbase4/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Crunchbase project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ekohe/crunchbase4/blob/master/CODE_OF_CONDUCT.md).
