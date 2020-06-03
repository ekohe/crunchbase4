# frozen_string_literal: true

RSpec.describe Crunchbase4::Entities::Organization do
  context 'fields and cards' do
    it 'returns all fields' do
      org = described_class.new('ekohe')

      expect(org.field_ids.size).to eq(94)
      expect(org.field_ids).to include('name')
      expect(org.field_ids).to include('permalink')
      expect(org.field_ids).to include('uuid')
    end

    it 'returns basis fields' do
      org = described_class.new('ekohe')

      expect(org.basis_fields.size).to eq(10)
      expect(org.basis_fields).to eq(
        %w[
          uuid
          permalink
          permalink_aliases
          name
          legal_name
          aliases
          website
          rank
          short_description
          description
        ]
      )
    end

    it 'returns full cards' do
      org = described_class.new('ekohe')

      expect(org.full_cards.size).to eq(19)
      expect(org.full_cards).to eq(
        %w[
          raised_investments
          participated_funds
          child_organizations
          participated_investments
          investors
          parent_organization
          raised_funding_rounds
          ipos
          event_appearances
          raised_funds
          acquiree_acquisitions
          acquirer_acquisitions
          parent_ownership
          jobs
          founders
          child_ownerships
          participated_funding_rounds
          press_references
          headquarters_address
        ]
      )
    end
  end
end
