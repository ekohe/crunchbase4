# frozen_string_literal: true

require_relative 'utilities/entity_endpoints'
require_relative 'utilities/search_endpoints'

module Crunchbase
  # API Request
  class Client
    include Utilities::EntityEndpoints
    include Utilities::SearchEndpoints
  end
end
