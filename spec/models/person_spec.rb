# frozen_string_literal: true

RSpec.describe Crunchbase::Models::Person do
  context 'person' do
    it 'returns all fields' do
      person = described_class.new

      expect(person.field_ids.size).to eq(56)
      expect(person.field_ids).to include('name')
      expect(person.field_ids).to include('permalink')
      expect(person.field_ids).to include('uuid')
    end

    it 'returns basis fields' do
      person = described_class.new

      expect(person.basis_fields.size).to eq(9)
      expect(person.basis_fields).to eq(
        %w[
          uuid
          permalink
          permalink_aliases
          name
          aliases
          website
          rank
          short_description
          description
        ]
      )
    end

    it 'returns full cards' do
      person = described_class.new

      expect(person.full_cards.size).to eq(13)
      expect(person.full_cards).to eq(
        %w[
          partner_funding_rounds
          participated_funds
          participated_investments
          degrees
          primary_job
          founded_organizations
          event_appearances
          jobs
          participated_funding_rounds
          fields
          press_references
          primary_organization
          partner_investments
        ]
      )
    end
  end
end
