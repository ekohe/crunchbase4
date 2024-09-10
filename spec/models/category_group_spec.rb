# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Crunchbase::Models::CategoryGroup do
  context 'category_group' do
    it 'returns category_group as endpoint' do
      expect(described_class::RESOURCE_LIST).to eq('category_groups')
    end

    it 'returns all fields' do
      category_group = described_class.new

      expect(category_group.field_ids.size).to eq(8)
      expect(category_group.field_ids).to eq(
        %w[
          categories
          created_at
          entity_def_id
          identifier
          rank
          updated_at
          uuid
          name
        ]
      )
    end

    it 'returns basis fields' do
      category_group = described_class.new

      expect(category_group.basis_fields.size).to eq(2)
      expect(category_group.basis_fields).to eq(
        %w[
          uuid
          name
        ]
      )
    end

    it 'returns full cards' do
      category_group = described_class.new

      expect(category_group.full_cards.size).to eq(0)
      expect(category_group.full_cards).to eq(
        %w[]
      )
    end
  end
end
