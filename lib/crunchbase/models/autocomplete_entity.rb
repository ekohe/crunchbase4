# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # For AutocompleteEntity
    class AutocompleteEntity < Entity
      def field_ids
        basis_fields
      end

      def basis_fields
        %w[
          identifier
          facet_ids
          short_description
        ]
      end

      def parse_response(response)
        dynamic_attributes(self, field_ids, response)
      end
    end
  end
end
