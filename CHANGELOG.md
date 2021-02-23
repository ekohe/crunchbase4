# Change Log

## [0.1.8] - 2021-02-23

### Add new fields on funding_rounds
- Adding diversity_spotlights and pre_money_valuation on raised_funding_rounds endpoint

## [0.1.7] - 2020-12-02

### Improve press_reference API response for activity_entities
- Returns relationship data for activity_entities
    * Before returns all names for activity_entities
    * After returns related organzation or person object

## [0.1.5] - 2020-06-26

### Refactoring
- Add more query condition support for card query (limit, order, before_id, after_id)
    * Before
      - Get organzation's fund: (`client.organization(entity_id, 'fund')`)
    * After
      - Get organzation's fund: (`client.organization(entity_id, card_id: 'fund')`)
- Method for uniformly obtaining deleted entities data and support more query condition
    * Get deleted organizations
      - Before:  (`client.deleted_organizations`)
      - After :  (`client.deleted_entities(collection_ids: 'organizations', limit: 20)`)
- Method for uniformly obtaining autocompletes entities data and support more query condition
    * Get autocompletes organizations
      - Before:  (`client.autocomplete_organizations`)
      - After :  (`client.autocomplete('ekohe', collection_ids: 'organizations', limit: 3)`)

## [0.1.4] - 2020-06-12

### Added
- Implemented APIs to get the cards data of Entity
  - fund: (`client.organization(entity_id, 'fund')`)
  - ownership: (`client.organization(entity_id, 'ownership')`)
  - founders: (`client.organization(entity_id, 'founders')`)
  - investors: (`client.organization(entity_id, 'investors')`)
  - jobs: (`client.organization(entity_id, 'jobs')`)
  - headquarters_address: (`client.organization(entity_id, 'headquarters_address')`)

## [0.1.3] - 2020-06-09

### Added
- Implemented `deleted_entities` API to allow user get deleted entities by collection_ids
- Implemented `fetch(entity_id, card_id)` API, allow user get the entity with card_id data

## [0.1.2] - 2020-06-07

### Added
- Implemented searches APIs to get the recent updates entities on Search
  - organizations
  - people
  - funding rounds
- Implemented `autocompletes` API to allow user filter entities by keyword
  - organizations
  - people
  - funding rounds

## [0.1.1] - 2020-06-06

### Added
- Implemented APIs to get acquisition and investment of Entity
- Implemented APIs to search organizations and funding rounds of Search

### Changed
- Refactor the API client to support search API

## [0.1.0] - 2020-06-04

### Added

- Implemented APIs to get organzation and funding round of Entity

## [0.0.0] - 2020-06-01

- Learning the Crunchbase V4 API changes then creating the Gem
