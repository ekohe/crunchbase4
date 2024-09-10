# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the Principal data from API
    class Job < Entity
      RESOURCE_LIST = 'jobs'

      def field_ids
        %w[
          created_at
          employee_featured_order
          entity_def_id
          identifier
          short_description
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          name
          title
          started_on
          ended_on
          permalink
          job_type
          is_current
          organization_identifier
          person_identifier
        ]
      end

      def full_cards
        %w[]
      end
    end
  end
end
