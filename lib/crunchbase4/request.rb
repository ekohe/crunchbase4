# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

# Crunchbase API
module Crunchbase4
  # API Request
  module Request
    module_function

    def request(uri, *args)
      response = Faraday.new(url: BASE_URI, headers: headers) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.response :json
      end.get(uri, *args)

      return response.body if response.status == 200
      raise Error, response.reason_phrase
    end

    private

    def headers
      {
        'X-cb-user-key' => Crunchbase4.config.user_key
      }
    end
  end
end
