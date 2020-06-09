# frozen_string_literal: true

module Crunchbase
  # Utilities
  module Utilities
    # All Entity API endpoints
    module EntityEndpoints
      # For Entity
      #
      # API Parameters
      #
      #   entity_id:  UUID or permalink of desired entity
      #   card_id:    A card to include on the resulting entity
      #   order:      Field name with order direction (asc/desc)
      #   limit:      Number of rows to return. Default is 100, min is 1, max is 100.

      # Lookup an Organization or single card
      def organization(entity_id, card_id: nil)
        lookup_for('organization', entity_id, card_id)
      end

      # Lookup Organization's all cards
      def organization_cards(entity_id, cards: [])
        entities('organization', entity_id).fetch_cards(cards)
      end

      # Lookup a Person or single card
      def person(entity_id, card_id: nil)
        lookup_for('person', entity_id, card_id)
      end

      # Lookup Person's all cards
      def person_cards(entity_id, cards: [])
        entities('person', entity_id).fetch_cards(cards)
      end

      # Lookup a Funding Round or single card
      def funding_round(entity_id, card_id: nil)
        lookup_for('funding_round', entity_id, card_id)
      end

      # Lookup Funding Round's all cards
      def funding_round_cards(entity_id, cards: [])
        entities('funding_round', entity_id).fetch_cards(cards)
      end

      # Lookup an Acquisition or Single card
      def acquisition(entity_id, card_id: nil)
        lookup_for('acquisition', entity_id, card_id)
      end

      # Lookup Acquisition's all card
      def acquisition_cards(entity_id, cards: [])
        entities('acquisition', entity_id).fetch_cards(cards)
      end

      # Lookup an Investment or Single card
      def investment(entity_id, card_id: nil)
        lookup_for('investment', entity_id, card_id)
      end

      # Lookup Investment's all card
      def investment_cards(entity_id, cards: [])
        entities('investment', entity_id).fetch_cards(cards)
      end

      # Lookup an PressReference or Single card
      def press_reference(entity_id, card_id: nil)
        lookup_for('press_reference', entity_id, card_id)
      end

      # Lookup PressReference's all card
      def press_reference_cards(entity_id, cards: [])
        entities('press_reference', entity_id).fetch_cards(cards)
      end

      # Lookup an Ipo or Single card
      def ipo(entity_id, card_id: nil)
        lookup_for('ipo', entity_id, card_id)
      end

      # Lookup Ipo's all card
      def ipo_cards(entity_id, cards: [])
        entities('ipo', entity_id).fetch_cards(cards)
      end

      private

      def entities(entity_type, entity_id)
        Crunchbase::Entities::Client.new(entity_id, entity_type)
      end

      def lookup_for(entity_type, entity_id, card_id)
        kobject = entities(entity_type, entity_id)
        return kobject.fetch if card_id.nil?

        kobject.cards(card_id)
      end
    end
  end
end
