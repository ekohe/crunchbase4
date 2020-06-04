# frozen_string_literal: true

module Crunchbase
  # Get the Organization data from API
  module Models
    # Root
    class Entity
      include ::Crunchbase::Utilities::Response

      def fields
        field_ids.map(&:to_sym)
      end

      def parse_response(response)
        dynamic_attributes(self, field_ids, response.dig('properties'))
      end

      def parse_cards_response(response)
        parse_response(response, response.dig('properties'))
        # response.dig('cards')
      end

      def as_json
        fields.each_with_object({}) { |item, hash| hash[item] = send(item) }
      end
    end
  end
end
