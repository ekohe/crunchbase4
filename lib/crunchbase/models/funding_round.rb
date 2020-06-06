# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class FundingRound < Entity
      RESOURCE_LIST = 'funding_rounds'

      def field_ids
        %w[
          created_at
          entity_def_id
          funded_organization_categories
          funded_organization_description
          funded_organization_funding_stage
          funded_organization_funding_total
          funded_organization_identifier
          funded_organization_location
          funded_organization_revenue_range
          identifier
          image_id
          investor_identifiers
          is_equity
          lead_investor_identifiers
          num_partners
          num_relationships
          pre_money_valuation
          rank
          rank_funding_round
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          name
          permalink
          announced_on
          closed_on
          investment_stage
          investment_type
          money_raised
          target_money_raised
          num_investors
          short_description
        ]
      end

      def full_cards
        %w[
          investments
          lead_investors
          investors
          organization
          partners
          press_references
        ]
      end
    end
  end
end
