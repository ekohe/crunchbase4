# frozen_string_literal: true

module Crunchbase
  # API Request
  class Client
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
      lookup_for('Organization', entity_id, card_id)
    end

    # Lookup Organization's all cards
    def organization_cards(entity_id, cards: [])
      entities('Organization', entity_id).fetch_cards(cards)
    end

    # Lookup a Person or single card
    def person(entity_id, card_id: nil)
      lookup_for('Person', entity_id, card_id)
    end

    # Lookup Person's all cards
    def person_cards(entity_id)
      entities('Person', entity_id).fetch_cards
    end

    # Lookup a Funding Round or single card
    def funding_round(entity_id, card_id: nil)
      lookup_for('FundingRound', entity_id, card_id)
    end

    # Lookup Funding Round's all cards
    def funding_round_cards(entity_id)
      entities('FundingRound', entity_id).fetch_cards
    end

    # Lookup an Acquisition or Single card
    def acquisition(entity_id, card_id: nil)
      lookup_for('Acquisition', entity_id, card_id)
    end

    # Lookup Acquisition's all card
    def acquisition_cards(entity_id)
      entities('Acquisition', entity_id).fetch_cards
    end

    # Lookup an Investment or Single card
    def investment(entity_id, card_id: nil)
      lookup_for('Investment', entity_id, card_id)
    end

    # Lookup Investment's all card
    def investment_cards(entity_id)
      entities('Investment', entity_id).fetch_cards
    end

    # Lookup an PressReference or Single card
    def press_reference(entity_id, card_id: nil)
      lookup_for('PressReference', entity_id, card_id)
    end

    # Lookup PressReference's all card
    def press_reference_cards(entity_id)
      entities('PressReference', entity_id).fetch_cards
    end

    # For Searches
    #

    def searches(keyword, _scope: nil)
      Crunchbase::Searches::Organization.new('name', keyword)
    end

    private

    def lookup_for(model_name, entity_id, card_id)
      kobject = entities(model_name, entity_id)
      return kobject.fetch if card_id.nil?

      kobject.cards(card_id)
    end

    def entities(kclass_name, entity_id)
      model_name = Kernel.const_get("Crunchbase::Models::#{kclass_name}")
      Crunchbase::Entities::Client.new(entity_id, model_name)
    end
  end
end
