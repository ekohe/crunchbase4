# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the EventAppearances data from API
    class EventAppearance < Entity
      RESOURCE_LIST = 'event_appearances'

      def field_ids
        %w[
          created_at
          updated_at
          entity_def_id
          event_identifier
          event_location_identifiers
          participant_identifier
        ] + basis_fields
      end

      def basis_fields
        %w[
          appearance_type
          identifier
          name
          permalink
          short_description
          event_starts_on
          uuid
        ]
      end

      def full_cards
        %w[]
      end
    end
  end
end
