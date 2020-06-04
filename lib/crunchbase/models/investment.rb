# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class Investment < Entity
      RESOURCE_LIST = 'investments'

      def field_ids
        %w[
          created_at
          entity_def_id
          identifier
          investor_identifier
          is_lead_investor
          funding_round_identifier
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          name
          permalink
          money_invested
          investor_stage
          investor_type
          funding_round_money_raised
          organization_identifier
          partner_identifiers
          announced_on
        ]
      end

      def full_cards
        %w[
          investor
          organization
          funding_round
          partner
        ]
      end
    end
  end
end
