# Change Log

## [0.1.5] - 2020-06-26

### Refactoring
- Add more query condition support for card query (limit, order, before_id, after_id)
    * Before
      - Get organzation's fund: (`client.organization(entity_id, 'fund')`)
    * After
      - Get organzation's fund: (`client.organization(entity_id, card_id: 'fund')`)
- Method for uniformly obtaining deleted entities data and support more query condition
    * Get deleted organzations
      - Before:  (`client.deleted_organzations`)
      - After :  (`client.deleted_entities(collection_ids: 'organizations', limit: 20)`)
- Method for uniformly obtaining autocompletes entities data and support more query condition
    * Get autocompletes organzations
      - Before:  (`client.autocomplete_organzations`)
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
  - organzations
  - people
  - funding rounds
- Implemented `autocompletes` API to allow user filter entities by keyword
  - organzations
  - people
  - funding rounds

## [0.1.1] - 2020-06-06

### Added
- Implemented APIs to get acquisition and investment of Entity
- Implemented APIs to search organzations and funding rounds of Search

### Changed
- Refactor the API client to support search API

## [0.1.0] - 2020-06-04

### Added

- Implemented APIs to get organzation and funding round of Entity

## [0.0.0] - 2020-06-01

- Learning the Crunchbase V4 API changes then creating the Gem
