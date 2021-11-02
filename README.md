# Crunchbase

Crunchbase is a ruby wrapper based on Crunchbase V4 API. it provides easy to get the API data by each endpoint. [CB v4 DOC](https://app.swaggerhub.com/apis/Crunchbase/crunchbase-enterprise_api/1.0.1)

[![Gem Version](https://badge.fury.io/rb/crunchbase4.svg)](https://badge.fury.io/rb/crunchbase4)
[![Build Status](https://travis-ci.org/ekohe/crunchbase4.svg?branch=master)](https://travis-ci.org/ekohe/crunchbase4)

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

#### Configure your certificate for API

```ruby
require 'crunchbase'

config = YAML.load(File.read('spec/crunchbase.yml'))
Crunchbase.config.user_key = config['user_key']
Crunchbase.config.debug = config['debug'] || false # If you want to know the request information, can set the debug = true
```

#### If you want to use it in Rails Application, simple way to create a file `crunchbase.rb` in `config/initializers`

- and put the above info(https://github.com/ekohe/crunchbase4#configure-your-certificate-for-api) into the new file


## Usage

#### Class: `Client` for API

```
pry(main)> client = Crunchbase::Client.new
```

#### API request for endpoint we completed

- [Entity](https://github.com/ekohe/crunchbase4#entity)
  - Organization
    - fields
    - cards: [raised_investments, participated_funds, child_organizations, participated_investments, investors, parent_organization, raised_funding_rounds, ipos, event_appearances, raised_funds, acquiree_acquisitions, acquirer_acquisitions, parent_ownership, jobs, founders, child_ownerships, participated_funding_rounds, press_references, headquarters_address]
  - Person
    - fields
  - FundingRound
    - fields
- [Searches](https://github.com/ekohe/crunchbase4#search)
- [Autocompletes](https://github.com/ekohe/crunchbase4#autocompletes)
- [Deleted Entities](https://github.com/ekohe/crunchbase4#deleted-entities)

```ruby
<!-- Examples of organization and single card -->
response                = client.organization('ekohe')
ipos                    = client.organization('ekohe', card_id: 'ipos')
fund                    = client.organization('ekohe', card_id: 'fund')
ownership               = client.organization('ekohe', card_id: 'ownership')
founders                = client.organization('ekohe', card_id: 'founders')
investors               = client.organization('ekohe', card_id: 'investors')
jobs                    = client.organization('ekohe', card_id: 'jobs')
headquarters_address    = client.organization('ekohe', card_id: 'headquarters_address')
top_2_press_references  = client.organization('ekohe', card_id: 'press_references', limit: 2)

<!-- Examples to get the funding rounds of the organization through paging -->
response = client.organization(
  'facebook', card_id: 'participated_funding_rounds',
  limit: 5,
  order: 'announced_on:desc',
  after_id: '3cdfcecd-5377-439b-acab-cefcf6fe21a5'
)

<!-- Examples of person and single card -->

response = client.person('mark-zuckerberg')
response = client.person('mark-zuckerberg', card_id: 'participated_investments')
response = client.funding_round('3cdfcecd-5377-439b-acab-cefcf6fe21a5')
response = client.funding_round('3cdfcecd-5377-439b-acab-cefcf6fe21a5', card_id: 'investors')
response = client.acquisition('7638eae9-07b7-4fc6-ad20-5d99de3ff928')
response = client.fund('aeaac12b-df56-7039-40f9-f1992f88e20e')
response = client.ownership('4506d9ce-85d3-4a8f-89cd-07a225359d55')

<!-- Get the JSON response of entity -->

response.as_json

<!-- Search -->
client.search_organizations(query_data)
client.search_people(query_data)
client.search_funding_rounds(query_data)
client.recent_updates({
                        scope_name: 'organization',
                        field_ids: %w[name website permalink],
                        date: '2020-05-05',
                        limit: 100
                      })

<!-- Autocompletes -->
response = client.autocomplete('ekohe')
response = client.autocomplete('ekohe', collection_ids: 'organizations')
response = client.autocomplete('ekohe', collection_ids: 'organizations', limit: 3)
response = client.autocomplete('encore', collection_ids: 'people')
response = client.autocomplete('facebook', collection_ids: 'funding_rounds')
response = client.autocomplete('facebook', collection_ids: 'press_references')

<!-- Deleted Entities -->
response = client.deledeted_entities(collection_ids: 'organizations')
response = client.deledeted_entities(collection_ids: 'people')
response = client.deledeted_entities(collection_ids: 'funding_rounds')
```

#### Module: Utils

* We return all the original data from CrunchBase without any conversion. So you want to use the converted data, you can use this tool to convert.

```ruby
pry(main)> Crunchbase::Utils.constants
=> [:QUERY_OPERATORS,
 :COMPANY_TYPES,
 :FACET_IDS,
 :IPO_STATUS,
 :FUNDING_STAGES,
 :FUNDING_TYPES,
 :CURRENCY_ENUM,
 :DATE_PRECISIONS,
 :LAYOUT_IDS,
 :NUM_EMPLOYEES_ENUM,
 :OPERATING_STATUS,
 :PROGRAM_TYPES,
 :REVENUE_RANGES,
 :SCHOOL_METHODS,
 :SCHOOL_TYPES,
 :STATUS,
 :STOCK_EXCHANGE_SYMBOLS]
pry(main)> Crunchbase::Utils::COMPANY_TYPES
=> {"for_profit"=>"For Profit", "non_profit"=>"Non-profit"}
```

### Entity

####  Get the organization data

```ruby
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

##### Get the person data

```ruby
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

##### Get the funding round data

```ruby
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
##### Get the fund data

```ruby
pry(main)> response = client.fund('aeaac12b-df56-7039-40f9-f1992f88e20e')
=> #<Crunchbase::Models::Fund:0x00007ffa6a5a4080
 @announced_on="2017-04-03",
 @created_at="2017-04-04T04:40:49Z",
 @entity_def_id="fund",
 @image_id="v1491280776/azwvvy68ap2o29ffcnn7.png",
 @investor_identifiers=["Betaworks", "Craig Newmark Philanthropies", "Democracy Fund", "Facebook", "Ford Foundation", "Knight Foundation", "Mozilla", "Tow Foundation"],
 @money_raised=14000000,
 @name="The News Integrity Initiative Fund I",
 @num_investors=8,
 @owner_identifier="The News Integrity Initiative",
 @permalink="the-news-integrity-initiative-raised-the-news-integrity-initiative-fund-i--aeaac12b",
 @short_description="The News Integrity Initiative raises new  The News Integrity Initiative Fund I on 2017-04-03",
 @started_on=nil,
 @updated_at="2018-02-12T22:18:54Z",
 @uuid="aeaac12b-df56-7039-40f9-f1992f88e20e">
pry(main)> response.name
=> "The News Integrity Initiative Fund I"
pry(main)> response.uuid
=> "aeaac12b-df56-7039-40f9-f1992f88e20e"
```

##### Get the acquisition data

```ruby
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

##### Get the press reference data

```ruby
pry(main)> response = client.press_reference('0171b30e-9cf8-4ad5-8288-2993e4308e0f')
=> #<Crunchbase::Models::PressReference:0x00007fd6faf97800
 @activity_entities=
  [#<Crunchbase::Models::Organization:0x00007fd6fb41d9d8
    @aliases=nil,
    @description=nil,
    @identifier=[],
    @legal_name=nil,
    @linkedin=nil,
    @name="Facebook",
    @permalink="facebook",
    @permalink_aliases=nil,
    @rank_org=nil,
    @rank_org_company=nil,
    @short_description=nil,
    @twitter=nil,
    @uuid="df662812-7f97-0b43-9d3e-12f64f504fbb",
    @website=nil>,
   #<Crunchbase::Models::Organization:0x00007fd6fb42f2c8
    @aliases=nil,
    @description=nil,
    @identifier=[],
    @legal_name=nil,
    @linkedin=nil,
    @name="General Atlantic",
    @permalink="general-atlantic",
    @permalink_aliases=nil,
    @rank_org=nil,
    @rank_org_company=nil,
    @short_description=nil,
    @twitter=nil,
    @uuid="8b8d96f8-9dfe-b27a-8f57-7d266a051dc9",
    @website=nil>,
   #<Crunchbase::Models::Organization:0x00007fd6fb42da18
    @aliases=nil,
    @description=nil,
    @identifier=[],
    @legal_name=nil,
    @linkedin=nil,
    @name="Kohlberg Kravis Roberts",
    @permalink="kkr",
    @permalink_aliases=nil,
    @rank_org=nil,
    @rank_org_company=nil,
    @short_description=nil,
    @twitter=nil,
    @uuid="6c93ebd7-3558-5603-daaf-074652d0e1bb",
    @website=nil>,
   #<Crunchbase::Models::Organization:0x00007fd6fb42c168
    @aliases=nil,
    @description=nil,
    @identifier=[],
    @legal_name=nil,
    @linkedin=nil,
    @name="Reliance Industries",
    @permalink="reliance-industries-84fd",
    @permalink_aliases=nil,
    @rank_org=nil,
    @rank_org_company=nil,
    @short_description=nil,
    @twitter=nil,
    @uuid="7ba47aa0-0e01-4101-a74d-67a8205584fd",
    @website=nil>,
   #<Crunchbase::Models::Organization:0x00007fd6fb43e868
    @aliases=nil,
    @description=nil,
    @identifier=[],
    @legal_name=nil,
    @linkedin=nil,
    @name="Vista Equity Partners",
    @permalink="vista-equity-partners",
    @permalink_aliases=nil,
    @rank_org=nil,
    @rank_org_company=nil,
    @short_description=nil,
    @twitter=nil,
    @uuid="4d096273-ae5d-d4c3-a411-20a42514d2ce",
    @website=nil>],
 @author=nil,
 @created_at="2020-06-05T17:41:10Z",
 @entity_def_id="press_reference",
 @identifier=["0171b30e-9cf8-4ad5-8288-2993e4308e0f", "Jio Platforms to receive $1.2b from Abu Dhabi’s sovereign investment firm"],
 @posted_on="2020-06-05",
 @publisher="Tech in Asia",
 @thumbnail_url="https://cdn.techinasia.com/wp-content/uploads/2016/07/Flickr_-_World_Economic_Forum_-_Ambani.jpg",
 @title="Jio Platforms to receive $1.2b from Abu Dhabi’s sovereign investment firm",
 @updated_at="2020-06-05T17:41:10Z",
 @url="https://ift.tt/3cByFh1",
 @uuid="0171b30e-9cf8-4ad5-8288-2993e4308e0f">
```

##### Get the investment data

```ruby
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

##### Get the ownership data

```ruby
pry(main)> response = client.ownership('4506d9ce-85d3-4a8f-89cd-07a225359d55')
=> #<Crunchbase::Models::Ownership:0x00007fbf2fdb78b0
 @created_at="2015-03-04T20:04:23Z",
 @entity_def_id="ownership",
 @identifier=["4506d9ce-85d3-4a8f-89cd-07a225359d55", "Facebook owns Instagram", "facebook-owns-instagram--4506d9ce"],
 @name="Facebook owns Instagram",
 @ownee_identifier="Instagram",
 @owner_identifier="Facebook",
 @ownership_type="subsidiary",
 @permalink="facebook-owns-instagram--4506d9ce",
 @updated_at="2018-02-13T01:18:10Z",
 @uuid="4506d9ce-85d3-4a8f-89cd-07a225359d55">
pry(main)> response.name
=> "Facebook owns Instagram"
pry(main)> response.uuid
=> "4506d9ce-85d3-4a8f-89cd-07a225359d55"
```

### Search

* Search query parameters for each endpoint

```ruby
{
  "field_ids": [],
  "query": [],
  "order": [],
  "limit": 0
}
```

##### Get the latest updated entities

Allow user using the method `recent_updates(args)` to get recent updates for each endpoint on searches

* Example to get recent updated organizations

```ruby
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

##### Search organizations by query conditions and order

* building the query conditions

```ruby
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

```ruby
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

- Get entities: response.entities
- Get total count: response.total_count
- Get entities count: response.count

##### Search people by query conditions and order

* building the query conditions

```ruby
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

```ruby
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

### Autocompletes

##### Allow users to filter by keyword from these endpoints

Search by keyword has been supported in "Organization", "People" and "Fund Round"

* Search in an organization by keyword

```ruby
pry(main)> response = client.autocomplete('ekohe', collection_ids: 'organizations')
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

* Search in an people by keyword

```ruby
pry(main)> response = client.autocomplete('maxime', collection_ids: 'people')
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

* Search in an funding rounds by keyword

```ruby
pry(main)> response = client.autocomplete('facebook', collection_ids: 'funding_rounds')
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

### Deleted Entities

* Get deleted entities by collection_ids

```ruby
pry(main)> response = client.deleted_entities
=> #<Crunchbase::DeletedEntities::Client:0x00007fa9196b6498
 @conditions={:collection_ids=>"organizations"},
 @count=1000,
 @entities=
  [#<Crunchbase::Models::DeletedEntity:0x00007fa9197f9df0 @deleted_at="2020-06-06T11:51:34Z", @entity_def_id="organization", @identifier=[], @uuid="31e5d1dd-3a7d-4c8c-b7dc-4780d391bbc3">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa9197f8fb8 @deleted_at="2020-06-06T10:43:10Z", @entity_def_id="organization", @identifier=[], @uuid="31d2ba51-ef94-4039-a6fc-22e5c1f0ed80">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa9197f86a8 @deleted_at="2020-06-05T18:32:20Z", @entity_def_id="organization", @identifier=[], @uuid="3f105ec3-606c-4779-85c8-29ec78d67d2d">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91981fd48 @deleted_at="2020-06-05T15:01:59Z", @entity_def_id="organization", @identifier=[], @uuid="e66d053a-86fa-4f5f-9c98-1d4b3ed0778d">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91981f438 @deleted_at="2020-06-05T13:17:39Z", @entity_def_id="organization", @identifier=[], @uuid="014de711-a0b0-4e29-a8ce-5f8c2696d9af">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91981eb28 @deleted_at="2020-06-05T13:09:11Z", @entity_def_id="organization", @identifier=[], @uuid="8b3102a2-04cc-4fb2-85cb-b2aa55662291">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91981e218 @deleted_at="2020-06-05T11:47:50Z", @entity_def_id="organization", @identifier=[], @uuid="62ae4ffc-a999-4c09-8c42-eef26be606aa">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91981d908 @deleted_at="2020-06-05T11:47:34Z", @entity_def_id="organization", @identifier=[], @uuid="7aa08989-f6ef-427c-96ac-7e1482a7eec1">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91981cff8 @deleted_at="2020-06-05T11:46:13Z", @entity_def_id="organization", @identifier=[], @uuid="7a6a5e41-d396-437a-9dfb-8539ef554268">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91981c6e8 @deleted_at="2020-06-05T11:45:21Z", @entity_def_id="organization", @identifier=[], @uuid="10db5120-a638-40eb-b636-e7cca20708e0">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91982fd88 @deleted_at="2020-06-05T11:45:01Z", @entity_def_id="organization", @identifier=[], @uuid="86c09840-b344-4687-a5ee-e5ea851b0b94">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91982f478 @deleted_at="2020-06-05T11:44:07Z", @entity_def_id="organization", @identifier=[], @uuid="2ac345e0-f6a0-4352-b66b-3254d4616c87">,
   #<Crunchbase::Models::DeletedEntity:0x00007fa91982eb68 @deleted_at="2020-06-05T11:43:23Z", @entity_def_id="organization", @identifier=[], @uuid="9fa9c806-bc1b-49e6-81f4-719cbfd7928e">,
   ....]
pry(main)> response.entities
pry(main)> response.count
pry(main)> response.total_count

# Get deleted people and funding rounds
pry(main)> response = client.deleted_entities(collection_ids: 'people')
pry(main)> response = client.deleted_entities(collection_ids: 'funding_rounds')
```

### Daily CSV Export

* https://api.crunchbase.com/bulk/v4/bulk_export.tar.gz?user_key=user_key


```ruby
pry(main)> response = client.download_bulk(dir, extract: true)
```

After running the download operation, you will see `bulk_export.tar.gz` in your provided folder.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Changelog

If you want to know what update, please check the [Changelog](https://github.com/ekohe/crunchbase4/blob/master/CHANGELOG.md).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ekohe/crunchbase4. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected.

To see all contributors from https://github.com/ekohe/crunchbase4/graphs/contributors

## License

Crunchbase is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Crunchbase project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ekohe/crunchbase4/blob/master/CODE_OF_CONDUCT.md).
