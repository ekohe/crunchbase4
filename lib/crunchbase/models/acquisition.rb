# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class Acquisition < Entity
      RESOURCE_LIST = 'acquisitions'

      def field_ids
        %w[
          acquiree_categories
          acquiree_last_funding_type
          acquiree_locations
          acquiree_num_funding_rounds
          acquiree_revenue_range
          acquiree_short_description
          acquirer_categories
          acquirer_funding_total
          acquirer_identifier
          acquirer_locations
          acquirer_num_funding_rounds
          acquirer_short_description
          created_at
          disposition_of_acquired
          entity_def_id
          num_relationships
          rank
          rank_acquisition
          status
          terms
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          permalink
          identifier
          announced_on
          completed_on
          acquisition_type
          price
          short_description
          acquiree_funding_total
          acquiree_identifier
          acquirer_revenue_range
        ]
      end

      def full_cards
        %w[
          acquiree_organization
          acquirer_organization
          press_references
        ]
      end
    end
  end
end
