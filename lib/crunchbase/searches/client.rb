# frozen_string_literal: true

require_relative '../utilities/request'
require_relative '../utilities/cb_model'

module Crunchbase
  # Whole Searches endpoints
  module Searches
    # Send request for entities endpoints
    #
    # API doc:
    #   https://app.swaggerhub.com/apis-docs/Crunchbase/crunchbase-enterprise_api/1.0.1#/Search/post_searches_organizations
    #
    # Notes
    #   1. Only can filter `Searchable: Yes` fields
    #   2. 'name', 'website' can not use
    class Client
      include ::Crunchbase::Utilities::Request
      include ::Crunchbase::Utilities::CbModel

      attr_accessor :total_count, :count, :entities, :entity_type, :conditions

      ROOT_LIST = 'searches'
      LIMIT = 100

      def initialize(conditions, entity_type)
        @conditions = conditions
        @entity_type = entity_type
      end

      # Will include all attribute from API document
      def searches
        wrapping!(
          search(
            root_uri,
            data_raw.to_s.gsub('=>', ':')
          )
        )
      end

      private

      def wrapping!(response)
        query_results = search_results(response.dig('entities'))

        self.total_count  = response['count']
        self.entities     = query_results
        self.count        = query_results.size
        self
      end

      def search_results(entities)
        entities.each_with_object([]) do |entity, objects|
          objects << cbobject.parse_response(entity, field_ids)
        end
      end

      def root_uri
        [ROOT_LIST, kclass_name::RESOURCE_LIST].compact.join('/')
      end

      # Post request raw datas
      def field_ids
        @conditions['field_ids'] || cbobject.basis_fields
      end

      def limit
        @conditions['limit'] || LIMIT
      end

      def data_raw
        {
          'field_ids' => field_ids,
          'order' => @conditions['order'],
          'query' => @conditions['query'],
          'limit' => limit
        }
      end
    end
  end
end
