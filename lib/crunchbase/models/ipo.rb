# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class Ipo < Entity
      RESOURCE_LIST = 'ipos'

      def field_ids
        %w[
          created_at
          entity_def_id
          image_id
          rank
          rank_ipo
          shares_outstanding
          shares_sold
          stock_exchange_symbol
          stock_full_symbol
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          permalink
          identifier
          amount_raised
          share_price
          stock_symbol
          valuation
          delisted_on
          went_public_on
          short_description
        ]
      end

      def full_cards
        %w[
          organization
          press_references
        ]
      end
    end
  end
end
