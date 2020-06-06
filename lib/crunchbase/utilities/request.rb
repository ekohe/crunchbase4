# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'faraday_curl'
require 'logger'
require_relative '../errors'

module Crunchbase
  # Utilities
  module Utilities
    # API Request
    module Request
      module_function

      # Entity endpoints
      #
      #   https://app.swaggerhub.com/apis-docs/Crunchbase/crunchbase-enterprise_api/1.0.1#/Entity/get_entities_organizations__entity_id_
      def entity(uri, *args)
        response = Faraday.new(url: BASE_URI, headers: headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
        end.get(uri, *args)

        return response.body if response.status == 200

        raise Error, response.body['error']
      end

      # Search endpoints
      #
      #   https://app.swaggerhub.com/apis-docs/Crunchbase/crunchbase-enterprise_api/1.0.1#/Search/post_searches_organizations
      def search(uri, args)
        response = Faraday.new(url: BASE_URI, headers: post_headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
          faraday.request :curl, ::Logger.new(STDOUT), :warn if debug_mode?
          faraday.response :logger, ::Logger.new(STDOUT), bodies: true if debug_mode?
        end.post(uri, args)

        return response.body if response.status == 200

        raise Error, response.body[0]['message']
      end

      private

      def debug_mode?
        Crunchbase.config.debug || false
      end

      def post_headers
        headers.merge(
          'Content-Type' => 'application/json'
        )
      end

      def headers
        {
          'X-cb-user-key' => Crunchbase.config.user_key
        }
      end
    end
  end
end
