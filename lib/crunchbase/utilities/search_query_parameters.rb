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
      #   order_field_ids: sort field, default field will be updated_at
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
        order_field_ids = args[:order_field_ids] || ['updated_at']
        order_conditions = order_field_ids.map do |field_id|
          {
            'field_id' => field_id,
            'sort' => (args[:sort] || 'desc'),
            'nulls' => 'last'
          }
        end

        params = {
          'field_ids' => default_field_ids + (args[:field_ids] || []).uniq,
          'order' => order_conditions,
          'limit' => args[:limit] || 1000
        }
        # Pagination
        params['before_id'] = args[:before_id] unless args[:before_id].nil?
        params['after_id'] = args[:after_id] unless args[:after_id].nil?

        # Date Ranges
        unless (queries = build_predicate_queries(args, order_field_ids)).empty?
          params['query'] = queries
        end

        params
      end

      private

      def default_field_ids
        @default_field_ids ||= %w[
          uuid
          created_at
          updated_at
        ]
      end

      def build_predicate_queries(args, order_field_ids)
        # Date Ranges
        queries = []
        if !args[:date].nil? || !args[:from_date].nil?
          queries << {
            'type' => 'predicate',
            'field_id' => order_field_ids[0],
            'operator_id' => 'gte',
            'values' => [
              args[:date] || args[:from_date]
            ]
          }
        end

        unless args[:to_date].nil?
          queries << {
            'type' => 'predicate',
            'field_id' => order_field_ids[0],
            'operator_id' => 'lte',
            'values' => [
              args[:to_date]
            ]
          }
        end

        queries
      end
    end
  end
end
