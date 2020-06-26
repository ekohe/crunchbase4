# frozen_string_literal: true

require_relative '../deleted_entities/client'

module Crunchbase
  # Utilities
  module Utilities
    # Autocomplete on Searches
    module DeletedEntities
      # endpoint: /deleted_entities
      #
      #   Retrieve deleted entities
      #   Retrieve deleted entities for a collection id
      #
      # API doc:
      #   https://app.swaggerhub.com/apis-docs/Crunchbase/crunchbase-enterprise_api/1.0.1#/Deleted%20Entities/get_deleted_entities
      #
      # Parameters:
      #   collection_ids: string
      #     Filter by collection id(s). Comma separated list of collection ids.
      #       E.g.
      #         organizations, people, funding_rounds, acquisitions, investments,
      #         events, press_references, funds, event_appearances, ipos, ownerships,
      #         categories, category_groups, locations, jobs
      #   before_id: string
      #     Used to paginate search results to the previous page. before_id should be the uuid of the first item in the current page.
      #       May not be provided simultaneously with after_id.
      #   after_id: string
      #     Used to paginate search results to the next page. after_id should be the uuid of the last item in the current page.
      #       May not be provided simultaneously with before_id.
      #   limit: integer
      #     Number of rows to return. Default is 100, min is 1, max is 1000.
      #   deleted_at_order: string
      #     Direction of sorting by deleted_at property
      #       Available values : asc, desc
      def deleted_entities(**args)
        crunchbase_deleted_entities(args)
      end

      private

      def crunchbase_deleted_entities(args)
        Crunchbase::DeletedEntities::Client.new(args).deleted_entities
      end
    end
  end
end
