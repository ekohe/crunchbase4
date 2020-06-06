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

      ROOT_LIST = 'searches'
      LIMIT = 100

      def initialize(data_raw_body, model_name)
        @data_raw_body = data_raw_body
        @model_name = model_name
      end

      # Will include all attribute from API document
      def searches
        response = search(root_uri, data_raw.to_s.gsub('=>', ':'))

        response.dig('entities').each_with_object([]) do |entity, objects|
          objects << cbobject.parse_response(entity)
        end
      end

      private

      def root_uri
        [ROOT_LIST, kclass_name::RESOURCE_LIST].compact.join('/')
      end

      # Post request raw datas
      def field_ids
        cbobject.basis_fields
      end

      def parse_response(response)
        cbobject.parse_response(response)
      end

      def data_raw
        {
          'field_ids' => @data_raw_body['field_ids'] || field_ids,
          'order' => @data_raw_body['order'],
          'query' => @data_raw_body['query'],
          'limit' => @data_raw_body['limit'] || LIMIT
        }
      end
    end
  end
end
