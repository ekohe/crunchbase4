# frozen_string_literal: true

require_relative '../utilities/request'

module Crunchbase
  # Whole Searches endpoints
  module Searches
    # Send request for entities endpoints
    class Client
      include ::Crunchbase::Utilities::Request

      ROOT_LIST = 'searches'
      LIMIT = 100

      def initialize(field_id, value)
        @field_id = field_id
        @value = value
      end

      # Will include all attribute from API document
      def search
        search(root_uri, query_conditions)
      end

      private

      def root_uri
        [ROOT_LIST, endpoint].compact.join('/')
      end
    end
  end
end
