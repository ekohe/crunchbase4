# frozen_string_literal: true

# Custom method for attributes
module Crunchbase4
  # Utils module
  module Utils
    # Crunchbase4
    module Attributes
      def fields
        field_ids.map(&:to_sym)
      end

      def parse_response(response)
        dynamic_attributes(self, field_ids, response.dig('properties'))
      end

      def as_json
        fields.each_with_object({}) { |item, hash| hash[item] = send(item) }
      end
    end
  end
end
