# frozen_string_literal: true

RSpec.describe Crunchbase::Models::Acquisition do
  context 'acquisition' do
    it 'returns acquisitions as endpoint' do
      expect(described_class::RESOURCE_LIST).to eq('acquisitions')
    end

    it 'returns all fields' do
      acquisition = described_class.new

      expect(acquisition.field_ids.size).to eq(32)
      expect(acquisition.field_ids).to include('price')
      expect(acquisition.field_ids).to include('uuid')
      expect(acquisition.field_ids).to include('acquiree_categories')
    end

    it 'returns basis fields' do
      acquisition = described_class.new

      expect(acquisition.basis_fields.size).to eq(11)
      expect(acquisition.basis_fields).to eq(
        %w[
          uuid
          permalink
          identifier
          announced_on
          completed_on
          acquisition_type
          price
          short_description
          acquiree_funding_total
          acquiree_identifier
          acquirer_revenue_range
        ]
      )
    end

    it 'returns full cards' do
      acquisition = described_class.new

      expect(acquisition.full_cards.size).to eq(3)
      expect(acquisition.full_cards).to eq(
        %w[
          acquiree_organization
          acquirer_organization
          press_references
        ]
      )
    end
  end
end
