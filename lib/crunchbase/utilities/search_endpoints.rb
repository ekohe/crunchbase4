# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # All Searches API endpoint
    module SearchEndpoints
      # For Searches

      def searches(keyword, _scope: nil)
        Crunchbase::Searches::Organization.new('name', keyword)
      end

      private

      def lookup_for(model_name, entity_id, card_id)
        kobject = entities(model_name, entity_id)
        return kobject.fetch if card_id.nil?

        kobject.cards(card_id)
      end
    end
  end
end
