# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class Ownership < Entity
      RESOURCE_LIST = 'ownerships'

      def field_ids
        %w[
          created_at
          entity_def_id
          identifier
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          permalink
          name
          ownee_identifier
          owner_identifier
          ownership_type
        ]
      end

      def full_cards
        %w[
          child_organization
          parent_organization
          press_references
        ]
      end
    end
  end
end
