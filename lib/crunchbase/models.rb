# frozen_string_literal: true

module Crunchbase
  # Models
  module Models
    autoload :Entity,                       'crunchbase/models/entity'
    autoload :Organization,                 'crunchbase/models/organization'
    autoload :Person,                       'crunchbase/models/person'
    autoload :FundingRound,                 'crunchbase/models/funding_round'
    autoload :Acquisition,                  'crunchbase/models/acquisition'
    autoload :Investment,                   'crunchbase/models/investment'
    autoload :PressReference,               'crunchbase/models/press_reference'
    autoload :CategoryGroup,                'crunchbase/models/category_group'
    autoload :Category,                     'crunchbase/models/category'
  end
end
