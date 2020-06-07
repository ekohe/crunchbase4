# frozen_string_literal: true

require_relative 'utilities/entity_endpoints'
require_relative 'utilities/search_endpoints'
require_relative 'utilities/autocomplete'
require_relative 'utilities/deleted_entities'

module Crunchbase
  # API Request
  class Client
    include Utilities::EntityEndpoints
    include Utilities::SearchEndpoints
    include Utilities::Autocomplete
    include Utilities::DeletedEntities
  end
end
