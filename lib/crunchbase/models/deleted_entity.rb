# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # For AutocompleteEntity
    class DeletedEntity < Entity
      def field_ids
        basis_fields
      end

      def basis_fields
        %w[
          uuid
          entity_def_id
          deleted_at
          identifier
        ]
      end

      def parse_response(response)
        dynamic_attributes(self, field_ids, response)
      end
    end
  end
end
