# frozen_string_literal: true

require_relative '../utilities/request'
require_relative '../utilities/cb_model'

module Crunchbase
  # Retrieve deleted entities
  module DeletedEntities
    # Send request for deleted_entities endpoint
    class Client
      include ::Crunchbase::Utilities::Request
      include ::Crunchbase::Utilities::CbModel

      attr_accessor :total_count, :count, :entities, :conditions, :entity_type

      ROOT_LIST = 'deleted_entities'
      LIMIT = 1000

      def initialize(raw_data)
        @conditions = raw_data
        @entity_type = 'deleted_entity'
      end

      # Will include all attribute from API document
      def deleted_entities
        wrapping_deleted_entities!(
          deleted(
            ROOT_LIST,
            deleted_entities_parameters
          )
        )
      end

      private

      def wrapping_deleted_entities!(response)
        query_results = search_results(response)

        self.total_count  = response.size
        self.entities     = query_results
        self.count        = query_results.size
        self
      end

      # One item of organization
      #
      #  {
      #   "identifier"=>
      #     {
      #       "uuid"=>"9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9",
      #       "value"=>"Ekohe",
      #       "image_id"=>"v1500646625/zhionn8nlgbkz4lj7ilz.png",
      #       "permalink"=>"ekohe",
      #       "entity_def_id"=>"organization"
      #      },
      #   "deleted_at"=>  string($date-time)
      #   }
      def search_results(entities)
        entities.each_with_object([]) do |entity, objects|
          objects << cbobject.parse_response(entity)
        end
      end

      def deleted_entities_parameters
        @conditions.merge(limit: @conditions[:limit] || LIMIT)
      end
    end
  end
end
