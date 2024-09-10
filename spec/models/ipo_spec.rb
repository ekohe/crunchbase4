# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Crunchbase::Models::Ipo do
  context 'ipo' do
    it 'returns people as endpoint' do
      expect(described_class::RESOURCE_LIST).to eq('ipos')
    end

    it 'returns all fields' do
      ipo = described_class.new

      expect(ipo.field_ids.size).to eq(20)
      expect(ipo.field_ids).to eq(
        %w[
          created_at
          entity_def_id
          image_id
          rank
          rank_ipo
          shares_outstanding
          shares_sold
          stock_exchange_symbol
          stock_full_symbol
          updated_at
          uuid
          permalink
          identifier
          amount_raised
          share_price
          stock_symbol
          valuation
          delisted_on
          went_public_on
          short_description
        ]
      )
    end

    it 'returns basis fields' do
      ipo = described_class.new

      expect(ipo.basis_fields.size).to eq(10)
      expect(ipo.basis_fields).to eq(
        %w[
          uuid
          permalink
          identifier
          amount_raised
          share_price
          stock_symbol
          valuation
          delisted_on
          went_public_on
          short_description
        ]
      )
    end

    it 'returns full cards' do
      person = described_class.new

      expect(person.full_cards.size).to eq(2)
      expect(person.full_cards).to eq(
        %w[
          organization
          press_references
        ]
      )
    end
  end
end
