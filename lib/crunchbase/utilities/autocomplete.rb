# frozen_string_literal: true

require_relative '../autocompletes/client'

module Crunchbase
  # Utilities
  module Utilities
    # Autocomplete on Searches
    module Autocomplete
      # endpoint: /autocompletes
      #
      #  Suggests matching Identifier entities based on the query and entity_def_ids provided.
      #
      #  query * string
      #     Value to perform the autocomplete search with.
      #  collection_ids string
      #     A comma separated list of collection ids to search against.
      #     Leaving this blank means it will search across all identifiers.
      #     Entity defs can be constrained to specific facets by providing them as facet collections.
      #     Relationship collections will resolve to their underlying entity def.
      #
      #     Collection ids are:
      #       organizations, people, funding_rounds, acquisitions, investments, events,
      #       press_references, funds, event_appearances, ipos, ownerships, categories,
      #       category_groups, locations, jobs
      #  limit integer
      #     Number of results to retrieve; default = 10, max = 25
      #
      #
      #  Example for organizations
      #
      #  raw_data = {
      #     query: keyword,
      #     collection_ids: 'organizations'
      #  }
      def autocomplete_organizations(keyword)
        autocompletes(wrapper_query_data(keyword, 'organizations'))
      end

      def autocomplete_people(keyword)
        autocompletes(wrapper_query_data(keyword, 'people'))
      end

      def autocomplete_funding_rounds(keyword)
        autocompletes(wrapper_query_data(keyword, 'funding_rounds'))
      end

      def autocomplete_press_references(keyword)
        autocompletes(wrapper_query_data(keyword, 'press_references'))
      end

      private

      def autocompletes(raw_data)
        Crunchbase::Autocompletes::Client.new(raw_data).autocompletes
      end

      def wrapper_query_data(keyword, collection_ids)
        {
          query: keyword,
          collection_ids: collection_ids
        }
      end
    end
  end
end
