# frozen_string_literal: true

module Crunchbase
  # Whole Searches endpoints
  module Searches
    # Send request for entities endpoints
    class Organization < Client
      include ::Crunchbase::Utilities::Request

      def endpoint
        ::Crunchbase::Models::Organization::RESOURCE_LIST
      end

      def query_conditions
        {
          "field_ids": field_ids,
          "order": orders,
          "query": conditions,
          "limit": LIMIT
        }
      end

      private

      def field_ids
        ::Crunchbase::Models::Organization.new.basis_fields
      end

      def orders
        [
          {
            "field_id": 'name',
            "sort": 'asc'
          }
        ]
      end

      def conditions
        [
          {
            "type": 'predicate',
            "field_id": @field,
            "operator_id": 'includes',
            "values": [
              @value
            ]
          }
        ]
      end
    end
  end
end
