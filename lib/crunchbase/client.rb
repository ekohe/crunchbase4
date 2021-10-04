# frozen_string_literal: true

require_relative 'utilities/entity_endpoints'
require_relative 'utilities/search_endpoints'
require_relative 'utilities/autocomplete'
require_relative 'utilities/deleted_entities'
require_relative 'utilities/downloads'

module Crunchbase
  # API Request
  class Client
    include Utilities::EntityEndpoints
    include Utilities::SearchEndpoints
    include Utilities::Autocomplete
    include Utilities::DeletedEntities
    include Utilities::Downloads
  end
end
