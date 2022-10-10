# frozen_string_literal: true

RSpec.describe Crunchbase::Models::Organization do
  context 'organization' do
    it 'returns organizations as endpoint' do
      expect(described_class::RESOURCE_LIST).to eq('organizations')
    end

    it 'returns all fields' do
      org = described_class.new

      expect(org.field_ids.size).to eq(102)
      expect(org.field_ids).to include('name')
      expect(org.field_ids).to include('permalink')
      expect(org.field_ids).to include('uuid')
    end

    it 'returns basis fields' do
      org = described_class.new

      expect(org.basis_fields.size).to eq(14)
      expect(org.basis_fields).to eq(
        %w[
          uuid
          identifier
          permalink
          permalink_aliases
          name
          legal_name
          aliases
          website
          linkedin
          twitter
          rank_org
          short_description
          description
          rank_org_company
        ]
      )
    end

    it 'returns full cards' do
      org = described_class.new

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
