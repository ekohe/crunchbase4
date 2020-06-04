# frozen_string_literal: true

module Crunchbase
  # Whole entities endpoints
  module Entities
    # Send request for entities endpoints
    class Client
      include ::Crunchbase::Utilities::Request

      attr_reader :object

      ROOT_LIST = 'entities'

      def initialize(entity_id, model_name)
        @entity_id = entity_id
        @object = model_name.new
      end

      # Will include all attribute from API document
      def fetch
        object.parse_response(entity(
                                root_uri,
                                field_ids: object.field_ids.join(',')
                              ))
      end

      # Only include a part basis fields of endpoint
      def fetch_cards(card_names = [])
        object.parse_cards_response(entity(
                                      root_uri,
                                      field_ids: object.basis_fields.join(','),
                                      cards: (object.full_cards & card_names).join(',')
                                    ))
      end

      def cards(card_id)
        object.parse_response(entity(
                                root_uri(name: __method__, id: card_id)
                              ))
      end

      private

      def root_uri(args = {})
        [
          ROOT_LIST, object.class::RESOURCE_LIST,
          @entity_id, args[:name], args[:id]
        ].compact.join('/')
      end
    end
  end
end
