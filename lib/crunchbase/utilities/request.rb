# frozen_string_literal: true

require 'faraday'
require 'faraday_curl'
require 'logger'
require_relative '../errors'

module Crunchbase
  # Utilities
  module Utilities
    # Key Reminder
    #
    #   entity_id must be provided in the request
    #   entity_id can be the uuid or the permalink of the entity
    #   you can pass your API key in the request's header if you do not want to pass the API key in the URL
    module Request
      module_function

      # Autocompletes endpoint
      def get(uri, *args)
        fetch_request(uri, *args)
      end

      def deleted(uri, *args)
        fetch_request(uri, *args)
      end

      # Entity endpoints
      #
      #   https://app.swaggerhub.com/apis-docs/Crunchbase/crunchbase-enterprise_api/1.0.1#/Entity/get_entities_organizations__entity_id_
      def entity(uri, *args)
        fetch_request(uri, *args)
      end

      # Search endpoints
      #
      #   https://app.swaggerhub.com/apis-docs/Crunchbase/crunchbase-enterprise_api/1.0.1#/Search/post_searches_organizations
      def search(uri, args)
        response = Faraday.new(url: BASE_URI, headers: post_headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
          faraday.request :curl, ::Logger.new($stdout), :warn if debug_mode?
          faraday.response :logger, ::Logger.new($stdout), bodies: true if debug_mode?
        end.post(uri, args)

        resp_body = response.body
        resp_status = response.status
        return resp_body if resp_status == 200

        raise Error, resp_body.is_a?(Array) ? resp_body[0]['message'] : resp_body['error']
      end

      private

      def fetch_request(uri, *args)
        response = Faraday.new(url: BASE_URI, headers: headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
          faraday.response :logger, ::Logger.new($stdout), bodies: true if debug_mode?
        end.get(uri, *args)

        resp_body = response.body
        resp_status = response.status
        return resp_body if resp_status == 200

        raise Error, resp_body.is_a?(Array) ? resp_body[0]['message'] : resp_body['error']
      end

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
