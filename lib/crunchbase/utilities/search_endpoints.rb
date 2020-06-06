# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # All Searches API endpoint
    module SearchEndpoints
      # For Searches
      def search_organizations(raw_data)
        searches(raw_data, 'organization').searches
      end

      def search_funding_rounds(raw_data)
        searches(raw_data, 'funding_round').searches
      end

      private

      def searches(raw_data, scope_name)
        Crunchbase::Searches::Client.new(raw_data, scope_name)
      end
    end
  end
end
