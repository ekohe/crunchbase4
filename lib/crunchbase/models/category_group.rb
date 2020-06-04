# frozen_string_literal: true

module Crunchbase
  # Get the Entities data from API
  module Models
    # Get the person data from API
    class CategoryGroup < Entity
      RESOURCE_LIST = 'category_groups'

      def field_ids
        %w[
          categories
          created_at
          entity_def_id
          identifier
          rank
          updated_at
        ] + basis_fields
      end

      def basis_fields
        %w[
          uuid
          name
        ]
      end

      def full_cards
        %w[]
      end
    end
  end
end
