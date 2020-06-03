# frozen_string_literal: true

# Crunchbase API
module Crunchbase4
  # API Request
  class Client
    # API Parameters
    #
    #   entity_id:  UUID or permalink of desired entity
    #   card_id:    A card to include on the resulting entity
    #   order:      Field name with order direction (asc/desc)
    #   limit:      Number of rows to return. Default is 100, min is 1, max is 100.
    def organization(entity_id, card_id: nil)
      kobject = entities('Organization', entity_id)
      return kobject.fetch if card_id.nil?

      kobject.cards(card_id)
    end

    # Fetching all cards of organization
    def organization_cards(entity_id, cards: [])
      entities('Organization', entity_id).fetch_cards(cards)
    end

    def person(entity_id, card_id: nil)
      kobject = entities('Person', entity_id)
      return kobject.fetch if card_id.nil?

      kobject.cards(card_id)
    end

    # Fetching all cards of people
    def person_cards(entity_id)
      entities('Person', entity_id).fetch_cards
    end

    private

    def entities(kclass_name, entity_id)
      Kernel.const_get("Crunchbase4::Entities::#{kclass_name}").new(entity_id)
    end
  end
end
