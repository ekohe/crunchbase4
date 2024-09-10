# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Crunchbase::Models::PressReference do
  context 'press_reference' do
    it 'returns press_reference as endpoint' do
      expect(described_class::RESOURCE_LIST).to eq('press_references')
    end

    it 'returns all fields' do
      press_reference = described_class.new

      expect(press_reference.field_ids.size).to eq(12)
      expect(press_reference.field_ids).to eq(
        %w[
          activity_entities
          created_at
          entity_def_id
          identifier
          thumbnail_url
          updated_at
          uuid
          url
          title
          author
          posted_on
          publisher
        ]
      )
    end

    it 'returns basis fields' do
      press_reference = described_class.new

      expect(press_reference.basis_fields.size).to eq(6)
      expect(press_reference.basis_fields).to eq(
        %w[
          uuid
          url
          title
          author
          posted_on
          publisher
        ]
      )
    end

    it 'returns full cards' do
      press_reference = described_class.new

      expect(press_reference.full_cards.size).to eq(0)
      expect(press_reference.full_cards).to eq(
        %w[]
      )
    end
  end
end
