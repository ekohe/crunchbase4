# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class Fund < Entity
      RESOURCE_LIST = 'funds'

      def field_ids
        %w[
          created_at
          entity_def_id
          image_id
          investor_identifiers
          num_investors
          owner_identifier
          short_description
          started_on
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          name
          announced_on
          money_raised
          permalink
        ]
      end

      def full_cards
        %w[
          investors
          owner
          press_references
        ]
      end
    end
  end
end
