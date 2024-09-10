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
      def autocomplete(keyword, args = {})
        crunchbase_autocompletes(
          wrapper_autocompletes_data(keyword, args)
        )
      end

      private

      def crunchbase_autocompletes(raw_data)
        Crunchbase::Autocompletes::Client.new(raw_data).autocompletes
      end

      def wrapper_autocompletes_data(keyword, args)
        { query: keyword }.merge(args)
      end
    end
  end
end
