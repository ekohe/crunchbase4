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

### Entity

####  Get the organization data

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

#### Get the person data

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

#### Get the funding round data

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

#### Get the acquisition data

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

#### Get the press reference data

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

#### Get the investment data

```
pry(main)> response = client.investment('1368da0c-07b0-46ef-9a86-b518367e60d6')
=> #<Crunchbase::Models::Investment:0x00007f8c15105830
 @announced_on="2013-06-30",
 @created_at="2020-04-02T12:17:59Z",
 @entity_def_id="investment",
 @funding_round_identifier="Secondary Market - Facebook",
 @funding_round_money_raised=nil,
 @identifier="Jean-Brice Abrial investment in Secondary Market - Facebook",
 @investor_identifier="Jean-Brice Abrial",
 @investor_stage=["early_stage_venture", "seed"],
 @investor_type=["angel"],
 @is_lead_investor=nil,
 @money_invested=1500000.0,
 @name="Jean-Brice Abrial investment in Secondary Market - Facebook",
 @organization_identifier="Facebook",
 @partner_identifiers=nil,
 @permalink="jean-brice-abrial-invested-in-facebook-secondary-market--371c20af--1368da0c",
 @updated_at="2020-04-02T12:17:59Z",
 @uuid="1368da0c-07b0-46ef-9a86-b518367e60d6">
```

### Search

* Search query parameters for each endpoint

```
{
  "field_ids": [],
  "query": [],
  "order": [],
  "limit": 0
}
```

#### Search organizations by query conditions and order

* Step1: Needs to build the query conditions

```
query_data = {
  'field_ids' => %w[
    name
    website
    uuid
    short_description
    company_type
  ],
  'order' => [
    {
      'field_id' => 'company_type',
      'sort' => 'asc'
    }
  ],
  'query' => [
    {
      'type' => 'predicate',
      'field_id' => 'funding_total',
      'operator_id' => 'between',
      'values' => [
        {
          'value' => 1_000_000,
          'currency' => 'usd'
        },
        {
          'value' => 10_000_000,
          'currency' => 'usd'
        }
      ]
    },
    {
      'type' => 'predicate',
      'field_id' => 'facet_ids',
      'operator_id' => 'includes',
      'values' => %w[company investor]
    }
  ],
  'limit' => 4
}
```

* Use `client` to send a request and parse response

```
pry(main)> response = client.search_organizations(query_data)
=> #<Crunchbase::Searches::Client:0x00007fdfc1ad6eb8
 @conditions=
  {"field_ids"=>["name", "website", "uuid", "short_description", "company_type"],
   "order"=>[{"field_id"=>"company_type", "sort"=>"asc"}],
   "query"=>
    [{"type"=>"predicate", "field_id"=>"funding_total", "operator_id"=>"between", "values"=>[{"value"=>1000000, "currency"=>"usd"}, {"value"=>10000000, "currency"=>"usd"}]},
     {"type"=>"predicate", "field_id"=>"facet_ids", "operator_id"=>"includes", "values"=>["company", "investor"]}],
   "limit"=>4},
 @count=4,
 @entities=
  [#<Crunchbase::Models::Organization:0x00007fdfc1b06460
    @company_type="for_profit",
    @name="360VUZ",
    @short_description="360VUZ is an immersive virtual video mobile app that enables users to teleport from their smartphone in 360°",
    @uuid="cb32a4d7-2bd0-1727-a055-63aa6a545380",
    @website="http://www.360VUZ.com">,
   #<Crunchbase::Models::Organization:0x00007fdfc1b05b78
    @company_type="for_profit",
    @name="HATCHER+",
    @short_description="Hatcher+ is a data-driven venture investment platform.",
    @uuid="a0ed41b8-8031-adad-dbb3-2e8f8e1e6848",
    @website="https://h2.hatcher.com">,
   #<Crunchbase::Models::Organization:0x00007fdfc1b05290
    @company_type="for_profit",
    @name="Merck",
    @short_description="Merck is a biopharmaceutical company that offers medicines and vaccines for various diseases.",
    @uuid="2f9b212a-d3aa-a8c2-6317-516127c8ba88",
    @website="http://www.merck.com">,
   #<Crunchbase::Models::Organization:0x00007fdfc1b049a8
    @company_type="for_profit",
    @name="Archistar.ai",
    @short_description="World-first artificial intelligence helping professionals find development sites, assess for feasibility and generate architectural designs",
    @uuid="3be8b43a-1143-4e26-8ecb-660a5a78edc5",
    @website="https://archistar.ai/">],
 @entity_type="organization",
 @kclass_name=Crunchbase::Models::Organization,
 @total_count=44871>
```

- Get all entities:     `response.entities`
- Get total count:      `response.total_count`
- Get entities count:   `response.count`

#### Search people by query conditions and order

* Step1: Needs to build the query conditions

```
query_data = {
  'field_ids' => %w[
    first_name
    last_name
    uuid
    permalink
    name
  ],
  'order' => [
    {
      'field_id' => 'last_name',
      'sort' => 'asc',
      'nulls' => 'last'
    }
  ],
  'query' => [
    {
      'type' => 'predicate',
      'field_id' => 'first_name',
      'operator_id' => 'contains',
      'values' => [
        'Maxime'
      ]
    },
    {
      'type' => 'predicate',
      'field_id' => 'last_name',
      'operator_id' => 'contains',
      'values' => [
        'Guilbot'
      ]
    }
  ],
  'limit' => 5
}
```

* Use `client` to send a request and parse response

```
pry(main)> response = client.search_people(query_data)
=> #<Crunchbase::Searches::Client:0x00007f9acca12d18
 @conditions=
  {"field_ids"=>["first_name", "last_name", "uuid", "permalink", "name"],
   "order"=>[{"field_id"=>"last_name", "sort"=>"asc", "nulls"=>"last"}],
   "query"=>
    [{"type"=>"predicate", "field_id"=>"first_name", "operator_id"=>"contains", "values"=>["Maxime"]}, {"type"=>"predicate", "field_id"=>"last_name", "operator_id"=>"contains", "values"=>["Guilbot"]}],
   "limit"=>5},
 @count=1,
 @entities=[#<Crunchbase::Models::Person:0x00007f9acca43418 @first_name="Maxime", @last_name="Guilbot", @name="Maxime Guilbot", @permalink="maxime-guilbot", @uuid="90f4c92e-3479-1f6e-6470-b2ae78805839">],
 @entity_type="person",
 @kclass_name=Crunchbase::Models::Person,
 @total_count=1>
pry(main)> response.entities
=> [#<Crunchbase::Models::Person:0x00007f9acca43418 @first_name="Maxime", @last_name="Guilbot", @name="Maxime Guilbot", @permalink="maxime-guilbot", @uuid="90f4c92e-3479-1f6e-6470-b2ae78805839">]
pry(main)> response.total_count
=> 1
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

## Changelogs

You can click [Changelog](https://github.com/ekohe/crunchbase4/blob/master/CHANGELOG.md) to view all historical changes.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/crunchbase4. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ekohe/crunchbase4/blob/master/CODE_OF_CONDUCT.md).

## License

Crunchbase is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Crunchbase project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ekohe/crunchbase4/blob/master/CODE_OF_CONDUCT.md).
