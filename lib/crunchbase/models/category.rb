# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class Category < Entity
      RESOURCE_LIST = 'categories'

      def field_ids
        %w[
        ] + basis_fields
      end

      def basis_fields
        %w[
        ]
      end

      def full_cards
        %w[
        ]
      end
    end
  end
end
