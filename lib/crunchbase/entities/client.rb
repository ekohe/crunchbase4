# frozen_string_literal: true

require_relative '../utilities/request'
require_relative '../utilities/cb_model'

module Crunchbase
  # Whole entities endpoints
  module Entities
    # using Crunchbase's Entity Lookup API endpoints
    class Client
      include ::Crunchbase::Utilities::Request
      include ::Crunchbase::Utilities::CbModel

      ROOT_LIST = 'entities'

      def initialize(entity_id, entity_type)
        @entity_id = entity_id
        @entity_type = entity_type
      end

      # Will include all attribute from API document
      def fetch
        cbobject.parse_response(entity(
                                  entity_request_uri,
                                  field_ids: cbobject.field_ids.join(',')
                                ))
      end

      # Only include a part basis fields of endpoint
      def fetch_cards(card_names = [])
        cbobject.parse_response(entity(
                                  entity_request_uri,
                                  field_ids: cbobject.basis_fields.join(','),
                                  cards: (cbobject.full_cards & card_names).join(',')
                                ), cbobject.basis_fields, card_names)
      end

      # Auto combine the card num field to request field_ids
      #
      #   Example: if card_id is investors, will auto add num_investors
      def cards(card_id, args = {})
        raise Crunchbase::Error, 'Invalid card_id' unless cbobject.full_cards.include?(card_id)

        field_ids = cbobject.basis_fields.concat(cbobject.card_num_field(card_id))

        request_args = args.merge(
          field_ids: field_ids.join(','),
          card_field_ids: cbobject.model_mappings[card_id].new.field_ids.join(',')
        )
        cbobject.parse_response(entity(
                                  entity_request_uri(name: __method__, card_id: card_id),
                                  request_args
                                ), field_ids, [card_id])
      end

      private

      def entity_request_uri(args = {})
        [
          ROOT_LIST, kclass_name::RESOURCE_LIST,
          @entity_id, args[:name], args[:card_id]
        ].compact.join('/')
      end
    end
  end
end
