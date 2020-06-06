# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require_relative '../errors'

module Crunchbase
  # Utilities
  module Utilities
    # API Request
    module Request
      module_function

      def entity(uri, *args)
        response = Faraday.new(url: BASE_URI, headers: headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
        end.get(uri, *args)

        return response.body if response.status == 200

        raise Error, response.reason_phrase
      end

      def search(uri, args)
        response = Faraday.new(url: BASE_URI, headers: headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
        end.post(uri, args)

        return response.body if response.status == 200

        raise Error, response.reason_phrase
      end

      private

      def headers
        {
          'X-cb-user-key' => Crunchbase.config.user_key
        }
      end
    end
  end
end
