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

### The first step is to build an API client

```
pry(main)> client = Crunchbase::Client.new
```

### Get the organization data

```
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

Or, if you want to use json data, please call `response.as_json` in your project.

### Get the person data

```
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

### Get the funding round data

```
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

### Get the acquisition data

```
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

### Get the press reference data

```
pry(main)> response = client.press_reference('0171b30e-9cf8-4ad5-8288-2993e4308e0f')
=> #<Crunchbase::Models::PressReference:0x00007fce2d33dbc0
 @activity_entities=["Facebook", "General Atlantic", "KKR", "Reliance Industries", "Vista Equity Partners"],
 @author=nil,
 @created_at="2020-06-05T17:41:10Z",
 @entity_def_id="press_reference",
 @identifier="Jio Platforms to receive $1.2b from Abu Dhabi’s sovereign investment firm",
 @posted_on="2020-06-05",
 @publisher="Tech in Asia",
 @thumbnail_url="https://cdn.techinasia.com/wp-content/uploads/2016/07/Flickr_-_World_Economic_Forum_-_Ambani.jpg",
 @title="Jio Platforms to receive $1.2b from Abu Dhabi’s sovereign investment firm",
 @updated_at="2020-06-05T17:41:10Z",
 @url="https://ift.tt/3cByFh1",
 @uuid="0171b30e-9cf8-4ad5-8288-2993e4308e0f">
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
