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

#### Get the latest updated entities

Allow user using the method `recent_updates(args)` to get recent updates for each endpoint on searches

# Example to get recent updated organizations

```
args = {
  scope_name: 'organization',             # must
  date: '2020-05-05',                     # must
  field_ids: %w[name website permalink],  # default %[uuid created_at updated_at]
  sort: 'desc'                            # default `desc`
  before_id: 'uuid'                       # optional
  after_id: 'uuid'                        # optional
}

response = client.recent_updates(args)
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

## Autocompletes

### Allow users to filter by keyword from these endpoints

Search by keyword has been supported in "Organization", "People" and "Fund Round"

1. Example: Search in an organization by keyword

```
pry(main)> response = client.autocomplete_organizations('ekohe')
=> #<Crunchbase::Autocompletes::Client:0x00007fecb34ce1e8
 @conditions={:query=>"ekohe", :collection_ids=>"organizations"},
 @count=25,
 @entities=
  [#<Crunchbase::Models::AutocompleteEntity:0x00007fecb3976cb8
    @facet_ids=["siftery", "apptopia", "company", "rank", "builtwith", "bombora", "similarweb"],
    @identifier=["9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9", "Ekohe", "ekohe"],
    @permalink="ekohe",
    @short_description="Creating cutting-edge, useful technical solutions to move you forward -- we deliver on the promise of AI.",
    @uuid="9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9">,
   #<Crunchbase::Models::AutocompleteEntity:0x00007fecb3975980
    @facet_ids=["rank", "builtwith", "company", "siftery"],
    @identifier=["4994381c-3f6a-07bc-6ccf-a180cfbfbf60", "Ekohealth", "ekohealth"],
    @permalink="ekohealth",
    @short_description="Ekohealth is an online platform, entitling the patients having Ekohealth card to avail up to 50% discount on medical expense.",
    @uuid="4994381c-3f6a-07bc-6ccf-a180cfbfbf60">,
   #<Crunchbase::Models::AutocompleteEntity:0x00007fecb3974cb0
    @facet_ids=["siftery", "apptopia", "company", "rank", "builtwith", "bombora", "similarweb"],
    @identifier=["d21d2598-6f76-d6b4-458e-579bc9c3a36d", "EcoHealth Alliance", "ecohealth-alliance"],
    @permalink="ecohealth-alliance",
    @short_description="EcoHealth Alliance is a solutions that promote conservation and prevents pandemics.",
    @uuid="d21d2598-6f76-d6b4-458e-579bc9c3a36d">,
    ...]
pry(main)> response.entities
pry(main)> response.count
pry(main)> response.total_count
```

2. Example: Search in an people by keyword

```
pry(main)> response = client.autocomplete_people('maxime')
=> #<Crunchbase::Autocompletes::Client:0x00007fecb474f9c0
 @conditions={:query=>"maxime", :collection_ids=>"people"},
 @count=25,
 @entities=
  [#<Crunchbase::Models::AutocompleteEntity:0x00007fecb477db40
    @facet_ids=["rank"],
    @identifier=["e270e799-052d-60ba-86d4-9c0535556851", "Maxime Leufroy-Murat", "maxime-leufroy-murat"],
    @permalink="maxime-leufroy-murat",
    @short_description="Maxime Leufroy-Murat - CEO @ FG Properties",
    @uuid="e270e799-052d-60ba-86d4-9c0535556851">,
   #<Crunchbase::Models::AutocompleteEntity:0x00007fecb477ce70
    @facet_ids=["rank"],
    @identifier=["0b71cab9-43dc-4f03-9267-4dcbc191ec30", "Maxime Schwab", "maxime-schwab"],
    @permalink="maxime-schwab",
    @short_description="Co-Founder",
    @uuid="0b71cab9-43dc-4f03-9267-4dcbc191ec30">,
   #<Crunchbase::Models::AutocompleteEntity:0x00007fecb477c1f0
    @facet_ids=["rank"],
    @identifier=["527a4a8e-46e4-d808-c7df-b540bd8fedab", "Maxime Lombardini", "maxime-lombardini"],
    @permalink="maxime-lombardini",
    @short_description="Maxime Lombardini is Chief Executive Officer and Member of the board of Iliad since 2007. \r\n\r\nBefore joining Iliad, Maxime Lombardini use to...",
    @uuid="527a4a8e-46e4-d808-c7df-b540bd8fedab">,
    ...]
pry(main)> response.entities
pry(main)> response.count
pry(main)> response.total_count
```
2. Example: Search in an funding rounds by keyword

```
pry(main)> pry(main)> response = client.autocomplete_funding_rounds('facebook')
=> #<Crunchbase::Autocompletes::Client:0x00007fecb4dd66b8
 @conditions={:query=>"facebook", :collection_ids=>"funding_rounds"},
 @count=25,
 @entities=
  [#<Crunchbase::Models::AutocompleteEntity:0x00007fecb4e04950
    @facet_ids=["rank"],
    @identifier=["6fae3958-a001-27c0-fb7e-666266aedd78", "Series B - Facebook", "facebook-series-b--6fae3958"],
    @permalink="facebook-series-b--6fae3958",
    @short_description="Facebook raised $27500000 on 2006-04-01 in Series B",
    @uuid="6fae3958-a001-27c0-fb7e-666266aedd78">,
   #<Crunchbase::Models::AutocompleteEntity:0x00007fecb4e17c30
    @facet_ids=["rank"],
    @identifier=["d950d7a5-79ff-fb93-ca87-13386b0e2feb", "Series A - Facebook", "facebook-series-a--d950d7a5"],
    @permalink="facebook-series-a--d950d7a5",
    @short_description="Facebook raised $12700000 on 2005-05-01 in Series A",
    @uuid="d950d7a5-79ff-fb93-ca87-13386b0e2feb">,
   #<Crunchbase::Models::AutocompleteEntity:0x00007fecb4e16f60
    @facet_ids=["rank"],
    @identifier=["59971bc0-0935-be60-e279-a9db5e787169", "Secondary Market - Facebook", "facebook-secondary-market--59971bc0"],
    @permalink="facebook-secondary-market--59971bc0",
    @short_description="Facebook raised $120000000 on 2010-06-28 in Secondary Market",
    @uuid="59971bc0-0935-be60-e279-a9db5e787169">,
    ...]
pry(main)> response.entities
pry(main)> response.count
pry(main)> response.total_count
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
