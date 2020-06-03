# Crunchbase4

A Ruby Library for Crunchbase API v4 -  [CB-v4 Doc](https://app.swaggerhub.com/apis/Crunchbase/crunchbase-enterprise_api/1.0.1)

[![Gem Version](https://badge.fury.io/rb/crunchbase4.svg)](https://badge.fury.io/rb/crunchbase4)
[![Build Status](https://travis-ci.org/encoreshao/crunchbase4.svg?branch=master)](https://travis-ci.org/encoreshao/crunchbase4)
[![Coverage Status](https://coveralls.io/repos/github/encoreshao/crunchbase4/badge.svg)](https://coveralls.io/github/encoreshao/crunchbase4)

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

## get the organization data

```
pry(main)> client = Crunchbase4::Client.new
pry(main)> response = client.organization('ekohe')
=> #<Crunchbase4::Entities::Organization:0x00007fbc5cfdf2f8
 @acquirer_identifier=nil,
 @aliases=nil,
 @categories=["Apps", "Artificial Intelligence", "Big Data", "E-Commerce", "Enterprise Software", "FinTech", "iOS", "Retail", "UX Design"],
 @category_groups=["Apps", "Artificial Intelligence", "Commerce and Shopping", "Data and Analytics", "Design", "Financial Services", "Mobile", "Platforms", "Science and Engineering", "Software"],
 @closed_on=nil,
 @company_type="for_profit",
 @contact_email="info@ekohe.com",
 @created_at="2013-05-14T14:28:38Z",
 @delisted_on=nil,
 @demo_days=nil,
 @description=
 ...>
pry(main)> response.name
=> "Ekohe"
pry(main)> response.permalink
=> "ekohe"
```

OR if you want to get the json data, please call `response.as_json` in your project.


## get the person data

```
pry(main)> client = Crunchbase4::Client.new
pry(main)> response = client.person('mark-zuckerberg')
=> #<Crunchbase4::Entities::Person:0x00007ffbf201d178
 @aliases=["Zuck"],
 @born_on="1984-05-14",
 @created_at="2007-05-26T04:51:46Z",
 @description=
  "Mark Zuckerberg is the founder and CEO of Facebook, which he started in his college dorm room in 2004 with roomates Dustin Moskovitz and Chris Hughes and from New York.\r\n\r\nZuckerberg is responsible for setting the overall direction and product strategy for the company. He leads the design of Facebook's service and development of its core technology and infrastructure. Mark studied computer science at Harvard University before moving the company to Palo Alto, California.\r\n\r\nEarlier in life, Zuckerberg developed a music recommendation system called Synapse and a peer-to-peer client called Wirehog. However, he abandoned both to pursue new projects.\r\n\r\nZuckerberg attended Harvard University and studied computer science before founding Facebook.\r\n\r\nWhile at Harvard, Zuckerberg created Facemash, a website that compared students' dorm photos side-by-side in a fashion similar to HOT or NOT. Harvard administration was not amused, and Zuckerberg faced subsequent disciplinary action. Less than three months later, he launched Facebook.\r\n\r\nIn September 2010, Zuckerberg donated $100 million to the Newark Public School System to help renovate and revamp the system.\r\n\r\nZuckerberg won the 2007 Crunchie Award for 'Best Startup CEO.' He was the Time Magazine 2010 Person Of The Year. He also won the 2012 Crunchie Award for CEO of the year.",
 @died_on=nil,
 @entity_def_id="person",
 @entity_id="mark-zuckerberg",
 @facebook="https://www.facebook.com/zuck",
 @facet_ids=["investor", "rank"],
 @first_name="Mark",
 @gender="male",
 @identifier="Mark Zuckerberg",
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
 :linkedin=>nil,
 :location_group_identifiers=>["San Francisco Bay Area", "Silicon Valley", "West Coast", "Western US"],
 :location_identifiers=>["Palo Alto", "California", "United States", "North America"],
 :middle_name=>nil,
 :num_articles=>31046,
 :num_current_advisor_jobs=>4,
 :num_current_jobs=>7,
 :num_event_appearances=>6,
 :num_exits=>nil,
 ....>
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
