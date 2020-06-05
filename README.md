# Crunchbase

Crunchbase is a ruby wrapper base on Crunchbase V4 API. It provides easy to get the API data by each endpoint. [CB-v4 doc](https://app.swaggerhub.com/apis/Crunchbase/crunchbase-enterprise_api/1.0.1)

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

## Getting Started

### Configure your API certificate

```
require 'crunchbase4'

CB_CONFIG = YAML.load(File.read('crunchbase.yml'))
Crunchbase.config do |c|
  c.user_key = CB_CONFIG['user_key']
end

OR

Crunchbase.config.user_key = CB_CONFIG['user_key']
```

## Usage

### Get the organization data

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

### Get the person data

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

### Get the funding round data

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

### Get the acquisition data

```
pry(main)> client = Crunchbase::Client.new
=> #<Crunchbase::Client:0x00007f8806824c28>
pry(main)> response = client.acquisition('7638eae9-07b7-4fc6-ad20-5d99de3ff928')
=> #<Crunchbase::Models::Acquisition:0x00007fa01134da60
 @acquiree_categories=["Communities", "Internet", "Photo Sharing", "Publishing", "Search Engine", "Social Media"],
 @acquiree_funding_total=150949998,
 @acquiree_identifier="Giphy",
 @acquiree_last_funding_type="series_d",
 @acquiree_locations=["New York", "New York", "United States", "North America"],
 ...>
pry(main)> response.uuid
=> "7638eae9-07b7-4fc6-ad20-5d99de3ff928"
pry(main)> response.acquiree_funding_total
=> 150949998
```

OR if you want to get the json data, please call `response.as_json` in your project.

```
pry(main)> response.as_json
=> {:acquiree_categories=>["Communities", "Internet", "Photo Sharing", "Publishing", "Search Engine", "Social Media"],
 :acquiree_last_funding_type=>"series_d",
 :acquiree_locations=>["New York", "New York", "United States", "North America"],
 :acquiree_num_funding_rounds=>4,
 :acquiree_revenue_range=>"r_00010000",
 :acquiree_short_description=>"Giphy allows users to search, share, and discover best GIFs.",
 :acquirer_categories=>nil,
 :acquirer_funding_total=>2335700000,
 :acquirer_identifier=>"Facebook",
 :acquirer_locations=>["Menlo Park", "California", "United States", "North America"],
 :acquirer_num_funding_rounds=>15,
 :acquirer_short_description=>"Facebook is an online social networking service that enables its users to connect with friends and family.",
 :created_at=>"2020-05-15T15:44:26Z",
 :disposition_of_acquired=>"subsidiary",
 :entity_def_id=>"acquisition",
 :num_relationships=>nil,
 :rank=>1104699,
 :rank_acquisition=>79,
 :status=>"pending",
 :terms=>nil,
 :updated_at=>"2020-05-18T16:32:25Z",
 :uuid=>"7638eae9-07b7-4fc6-ad20-5d99de3ff928",
 :permalink=>"facebook-acquires-giphy--7638eae9",
 :identifier=>"Giphy acquired by Facebook",
 :announced_on=>"2020-05-15",
 :completed_on=>nil,
 :acquisition_type=>"acquisition",
 :price=>400000000,
 :short_description=>"Facebook acquires Giphy on 2020-05-15 for $400000000",
 :acquiree_funding_total=>150949998,
 :acquiree_identifier=>"Giphy",
 :acquirer_revenue_range=>"r_10000000"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Examples of API requests

```
Crunchbase.config.user_key = 'user_key'
client = Crunchbase::Client.new
response = client.organization('ekohe')
response = client.person('mark-zuckerberg')
response = client.funding_round('371c20af8aa94bcba8da0694d138f247')
response = client.acquisition('7638eae9-07b7-4fc6-ad20-5d99de3ff928')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/crunchbase4. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ekohe/crunchbase4/blob/master/CODE_OF_CONDUCT.md).


## License

Crunchbase is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Crunchbase project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ekohe/crunchbase4/blob/master/CODE_OF_CONDUCT.md).
