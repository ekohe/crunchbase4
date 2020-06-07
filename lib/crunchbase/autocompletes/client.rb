# frozen_string_literal: true

require_relative '../utilities/request'
require_relative '../utilities/cb_model'

module Crunchbase
  # autocompletes endpoints
  module Autocompletes
    # Send request for autocompletes endpoint
    #
    # API doc:
    #   https://app.swaggerhub.com/apis-docs/Crunchbase/crunchbase-enterprise_api/1.0.1#/Autocomplete/get_autocompletes
    class Client
      include ::Crunchbase::Utilities::Request
      include ::Crunchbase::Utilities::CbModel

      attr_accessor :total_count, :count, :entities, :conditions, :entity_type

      ROOT_LIST = 'autocompletes'
      LIMIT = 25

      def initialize(raw_data)
        @conditions = raw_data
        @entity_type = 'autocomplete_entity'
      end

      # Will include all attribute from API document
      def autocompletes
        wrapping!(
          get(
            ROOT_LIST,
            autocompletes_parameters
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

      # One item of organization
      #
      #  {
      #   "facet_ids"=>
      #     ["siftery", "apptopia", "company", "rank", "builtwith", "bombora", "similarweb"],
      #   "identifier"=>
      #     {
      #       "uuid"=>"9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9",
      #       "value"=>"Ekohe",
      #       "image_id"=>"v1500646625/zhionn8nlgbkz4lj7ilz.png",
      #       "permalink"=>"ekohe",
      #       "entity_def_id"=>"organization"
      #      },
      #   "short_description"=>
      #     "Creating cutting-edge, useful technical solutions to move you forward -- we deliver on the promise of AI."
      #   }
      def search_results(entities)
        entities.each_with_object([]) do |entity, objects|
          objects << cbobject.parse_response(entity)
        end
      end

      def autocompletes_parameters
        @conditions.merge(limit: @conditions[:limit] || LIMIT)
      end
    end
  end
end
