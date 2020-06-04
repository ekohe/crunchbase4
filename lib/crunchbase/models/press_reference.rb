# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class PressReference < Entity
      RESOURCE_LIST = 'press_references'

      def field_ids
        %w[
          activity_entities
          created_at
          entity_def_id
          identifier
          thumbnail_url
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          url
          title
          author
          posted_on
          publisher
        ]
      end

      def full_cards
        %w[]
      end
    end
  end
end
