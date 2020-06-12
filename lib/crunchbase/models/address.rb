# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class Address < Entity
      RESOURCE_LIST = 'addresses'

      def field_ids
        %w[
          created_at
          entity_def_id
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          name
          postal_code
          street_1
          street_2
          identifier
          location_identifiers
        ]
      end

      def full_cards
        %w[
        ]
      end
    end
  end
end
