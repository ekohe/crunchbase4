# frozen_string_literal: true

require_relative './search_query_parameters'

module Crunchbase
  # Utilities
  module Utilities
    # All Searches API endpoint
    module SearchEndpoints
      include SearchQueryParameters

      # Example to searching organizations
      #
      # {
      #   scope_name: 'organization',
      #   date: '2020-05-05',
      #   field_ids: %w[name website permalink],
      #   sort: 'desc'
      #   before_id: 'uuid'
      #   after_id: 'uuid'
      # }
      def recent_updates(args)
        searches(query_parameters(args), args[:scope_name]).searches
      end

      # For Searches
      def search_organizations(raw_data)
        searches(raw_data, 'organization').searches
      end

      def search_funding_rounds(raw_data)
        searches(raw_data, 'funding_round').searches
      end

      def search_people(raw_data)
        searches(raw_data, 'person').searches
      end

      private

      def searches(raw_data, scope_name)
        Crunchbase::Searches::Client.new(raw_data, scope_name)
      end
    end
  end
end
