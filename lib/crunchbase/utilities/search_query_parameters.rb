# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # All Searches Query Parameters
    module SearchQueryParameters
      module_function

      # https://app.swaggerhub.com/apis-docs/Crunchbase/crunchbase-enterprise_api/1.0.1#/Search/post_searches_people
      #
      # Search Query Parameters
      #
      #   field_ids: array of field_id strings
      #     Fields to include as columns in the search result entities
      #   query: Search query to perform on the designated entity
      #   order: (field_id, sort, nulls)
      #     Order in which the search results should be returned
      #   limit: integer
      #     Number of rows to return. Default is 100, min is 1, max is 1000.
      #   before_id: string($uuid)
      #     Used to paginate search results to the previous page.
      #     before_id should be the uuid of the first item in the current page. May not be provided simultaneously with after_id.
      #   after_id: string($uuid)
      #     Used to paginate search results to the next page.
      #     after_id should be the uuid of the last item in the current page. May not be provided simultaneously with before_id.
      def query_parameters(args)
        params = {
          'field_ids' => %w[
            uuid
            created_at
            updated_at
          ] + (args[:field_ids] || []).uniq,
          'order' => [
            {
              'field_id' => 'updated_at',
              'sort' => (args[:sort] || 'desc'),
              'nulls' => 'last'
            }
          ],
          'limit' => args[:limit] || 1000
        }

        unless args[:date].nil?
          params.merge!(
            'query' => [
              {
                'type' => 'predicate',
                'field_id' => 'updated_at',
                'operator_id' => 'gte',
                'values' => [
                  args[:date]
                ]
              }
            ]
          )
        end
        params.merge!('before_id' => args[:before_id]) unless args[:before_id].nil?
        params.merge!('after_id' => args[:after_id]) unless args[:after_id].nil?
        params
      end
    end
  end
end
