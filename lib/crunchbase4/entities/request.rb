# frozen_string_literal: true

require_relative '../utils/attributes'

module Crunchbase4
  # Whole entities endpoints
  module Entities
    # Send request for entities endpoints
    class Request
      include ::Crunchbase4::Request
      include ::Crunchbase4::Response
      include ::Crunchbase4::Utils::Attributes

      ROOT_LIST = 'entities'

      def initialize(entity_id)
        @entity_id = entity_id
      end

      # Will include all attribute from API document
      def fetch
        parse_response(request(
                         root_uri,
                         field_ids: field_ids.join(',')
                       ))
      end

      # Only include a part basis fields of endpoint
      def fetch_cards(card_names = [])
        parse_cards_response(request(
                               root_uri,
                               field_ids: basis_fields.join(','),
                               cards: (full_cards & card_names).join(',')
                             ))
      end

      def cards(card_id)
        parse_response(request(
                         root_uri(name: __method__, id: card_id)
                       ))
      end

      private

      def root_uri(args = {})
        [
          ROOT_LIST, self.class::RESOURCE_LIST,
          @entity_id, args[:name], args[:id]
        ].compact.join('/')
      end
    end
  end
end
