# Change Log

## [0.1.4] - 2020-06-12

### Added
- Implemented a API to get the fund data of Entity (`client.fund(entity_id)`)
- Implemented a API to get the ownership data of Entity (`client.ownership(entity_id)`)
- Implemented a API to get the founders data of Entity (`client.founders(entity_id)`)
- Implemented a API to get the event_appearances data of Entity (`client.event_appearances(entity_id)`)
- Implemented a API to get the investors data of Entity (`client.investors(entity_id)`)
- Implemented a API to get the jobs data of Entity (`client.jobs(entity_id)`)
- Implemented a API to get the headquarters_address data of Entity (`client.headquarters_address(entity_id)`)

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
