# frozen_string_literal: true

RSpec.describe Crunchbase::Models::Investment do
  context 'investment' do
    it 'returns investments as endpoint' do
      expect(described_class::RESOURCE_LIST).to eq('investments')
    end

    it 'returns all fields' do
      investment = described_class.new

      expect(investment.field_ids.size).to eq(17)
      expect(investment.field_ids).to eq(
        %w[
          created_at
          entity_def_id
          identifier
          investor_identifier
          is_lead_investor
          funding_round_identifier
          updated_at
          uuid
          name
          permalink
          money_invested
          investor_stage
          investor_type
          funding_round_money_raised
          organization_identifier
          partner_identifiers
          announced_on
        ]
      )
    end

    it 'returns basis fields' do
      investment = described_class.new

      expect(investment.basis_fields.size).to eq(10)
      expect(investment.basis_fields).to eq(
        %w[
          uuid
          name
          permalink
          money_invested
          investor_stage
          investor_type
          funding_round_money_raised
          organization_identifier
          partner_identifiers
          announced_on
        ]
      )
    end

    it 'returns full cards' do
      investment = described_class.new

      expect(investment.full_cards.size).to eq(4)
      expect(investment.full_cards).to eq(
        %w[
          investor
          organization
          funding_round
          partner
        ]
      )
    end
  end
end
