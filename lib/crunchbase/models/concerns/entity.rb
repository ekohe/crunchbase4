# frozen_string_literal: true

require_relative '../../utilities/response'
require_relative './mappings'

module Crunchbase
  # Get the Organization data from API
  module Models
    # Root
    class Entity
      include ::Crunchbase::Utilities::Response
      include Mappings

      def fields
        field_ids.map(&:to_sym)
      end

      def parse_response(response, request_field_ids = [], cards = [])
        extract_fields = (request_field_ids.empty? ? field_ids : request_field_ids)

        dynamic_attributes(self, extract_fields, response.dig('properties'))
        setup_relationships(self, cards, response.dig('cards'))
        self
      end

      def setup_relationships(object, request_card_ids, response_cards)
        request_card_ids.each do |card_id|
          card_data = response_cards.dig(card_id)
          card_model = model_mappings[card_id]
          card_objects = if card_data.is_a?(Array)
                           card_data.each_with_object([]) do |data, objects|
                             new_card_instance = card_model.new
                             objects << dynamic_attributes(new_card_instance, new_card_instance.basis_fields, data)
                           end
                         else
                           card_data.nil? ? nil : dynamic_attributes(card_model.new, extract_fields, data)
                         end

          dynamic_define_method(object, card_id, card_objects)
        end
      end

      def as_json
        fields.each_with_object({}) { |item, hash| hash[item] = send(item) }
      end
    end
  end
end
