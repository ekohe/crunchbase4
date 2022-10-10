# frozen_string_literal: true

RSpec.describe Crunchbase::Searches::Client do
  it 'be able search funding rounds order by announced_on' do
    post_data_raw = {
      'field_ids' => %w[
        identifier
        announced_on
        funded_organization_identifier
        money_raised
        investment_type
      ],
      'order' => [
        {
          'field_id' => 'announced_on',
          'sort' => 'desc'
        }
      ],
      'query' => [
        {
          'type' => 'predicate',
          'field_id' => 'announced_on',
          'operator_id' => 'gte',
          'values' => [
            '2018'
          ]
        }
      ],
      'limit' => 100
    }

    response = VCR.use_cassette('searches_funding_rounds_with_announced_on_order_announced_on') do
      described_class.new(post_data_raw, 'funding_round').searches
    end

    funding_rounds = response.entities

    expect(response.count).to eq(100)
    expect(response.total_count).to eq(83_005)
    expect(funding_rounds[0].permalink).to eq('harpers-environmental-debt-financing--3e99d4e3')
    expect(funding_rounds[0].uuid).to eq('3e99d4e3-1aab-4eb3-88ab-ce1c2fc23105')
    expect(funding_rounds[0].identifier).to eq([
                                                 'harpers-environmental-debt-financing--3e99d4e3',
                                                 '3e99d4e3-1aab-4eb3-88ab-ce1c2fc23105',
                                                 'Debt Financing - Harpers Environmental'
                                               ])
    expect(funding_rounds[0].money_raised).to eq(2_509_996)
  end

  it 'be able search funding rounds order by money_raised' do
    post_data_raw = {
      'field_ids' => %w[
        identifier
        announced_on
        funded_organization_identifier
        money_raised
        investment_type
      ],
      'order' => [
        {
          'field_id' => 'money_raised',
          'sort' => 'desc'
        }
      ],
      'query' => [
        {
          'type' => 'predicate',
          'field_id' => 'money_raised',
          'operator_id' => 'gte',
          'values' => [
            '100000'
          ]
        }
      ],
      'limit' => 100
    }

    response = VCR.use_cassette('searches_funding_rounds_with_money_raised_order_money_raised') do
      described_class.new(post_data_raw, 'funding_round').searches
    end

    funding_rounds = response.entities

    expect(response.count).to eq(100)
    expect(response.total_count).to eq(202_561)
    expect(funding_rounds[0].permalink).to eq('xerox-post-ipo-equity--54708936')
    expect(funding_rounds[0].uuid).to eq('54708936-6f24-484c-9b31-3ba530a8bfb4')
    expect(funding_rounds[0].identifier).to eq(['xerox-post-ipo-equity--54708936', '54708936-6f24-484c-9b31-3ba530a8bfb4', 'Post-IPO Equity - Xerox'])
    expect(funding_rounds[0].money_raised).to eq(24_000_000_000)
  end
end
