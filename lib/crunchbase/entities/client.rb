# frozen_string_literal: true

require_relative '../utilities/request'
require_relative '../utilities/cb_model'

module Crunchbase
  # Whole entities endpoints
  module Entities
    # Send request for entities endpoints
    class Client
      include ::Crunchbase::Utilities::Request
      include ::Crunchbase::Utilities::CbModel

      ROOT_LIST = 'entities'

      def initialize(entity_id, model_name)
        @entity_id  = entity_id
        @model_name = model_name
      end

      # Will include all attribute from API document
      def fetch
        cbobject.parse_response(entity(
                                  root_uri,
                                  field_ids: cbobject.field_ids.join(',')
                                ))
      end

      # Only include a part basis fields of endpoint
      def fetch_cards(card_names = [])
        cbobject.parse_cards_response(entity(
                                        root_uri,
                                        field_ids: cbobject.basis_fields.join(','),
                                        cards: (cbobject.full_cards & card_names).join(',')
                                      ))
      end

      def cards(card_id)
        cbobject.parse_response(entity(
                                  root_uri(name: __method__, id: card_id)
                                ))
      end

      private

      def root_uri(args = {})
        [
          ROOT_LIST, kclass_name::RESOURCE_LIST,
          @entity_id, args[:name], args[:id]
        ].compact.join('/')
      end
    end
  end
end
