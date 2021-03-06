# frozen_string_literal: true

module Crunchbase
  # Models
  module Models
    autoload :Entity,                       'crunchbase/models/concerns/entity'
    autoload :AutocompleteEntity,           'crunchbase/models/autocomplete_entity'
    autoload :DeletedEntity,                'crunchbase/models/deleted_entity'
    autoload :Organization,                 'crunchbase/models/organization'
    autoload :Person,                       'crunchbase/models/person'
    autoload :FundingRound,                 'crunchbase/models/funding_round'
    autoload :Acquisition,                  'crunchbase/models/acquisition'
    autoload :Investment,                   'crunchbase/models/investment'
    autoload :PressReference,               'crunchbase/models/press_reference'
    autoload :CategoryGroup,                'crunchbase/models/category_group'
    autoload :Category,                     'crunchbase/models/category'
    autoload :Ipo,                          'crunchbase/models/ipo'
    autoload :Fund,                         'crunchbase/models/fund'
    autoload :Ownership,                    'crunchbase/models/ownership'
    autoload :EventAppearance,              'crunchbase/models/event_appearance'
    autoload :Principal,                    'crunchbase/models/principal'
    autoload :Job,                          'crunchbase/models/job'
    autoload :Address,                      'crunchbase/models/address'
  end
end
