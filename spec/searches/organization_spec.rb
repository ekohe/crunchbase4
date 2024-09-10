# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Crunchbase::Searches::Client do
  it 'be able search organizations' do
    post_data_raw = {
      'field_ids' => %w[
        name
        website
        uuid
        short_description
        company_type
      ],
      'order' => [
        {
          'field_id' => 'company_type',
          'sort' => 'asc'
        }
      ],
      'query' => [
        {
          'type' => 'predicate',
          'field_id' => 'funding_total',
          'operator_id' => 'between',
          'values' => [
            {
              'value' => 1_000_000,
              'currency' => 'usd'
            },
            {
              'value' => 10_000_000,
              'currency' => 'usd'
            }
          ]
        },
        {
          'type' => 'predicate',
          'field_id' => 'facet_ids',
          'operator_id' => 'includes',
          'values' => %w[company investor]
        }
      ],
      'limit' => 10
    }

    response = VCR.use_cassette('searches_organizations_with_funding_total_order_company_type') do
      described_class.new(post_data_raw, 'organization').searches
    end

    orgs = response.entities

    expect(response.count).to eq(10)
    expect(response.total_count).to eq(44_867)
    expect(orgs.map(&:name)).to eq([
                                     '360VUZ', 'HATCHER+', 'Merck', 'Archistar.ai', 'Benzinga',
                                     'Schoola', 'Novartis', 'Berkshire Hathaway', 'PolicyStreet', 'ConsenSys'
                                   ])
    expect(orgs.map(&:website)).to eq(['http://www.360VUZ.com',
                                       'https://h2.hatcher.com',
                                       'http://www.merck.com',
                                       'https://archistar.ai/',
                                       'http://www.benzinga.com',
                                       'http://www.schoola.com/',
                                       'http://www.novartis.com',
                                       'http://www.berkshirehathaway.com',
                                       'https://www.policystreet.com',
                                       'http://www.consensys.net'])
    expect(orgs.map(&:uuid)).to eq(%w[cb32a4d7-2bd0-1727-a055-63aa6a545380
                                      a0ed41b8-8031-adad-dbb3-2e8f8e1e6848
                                      2f9b212a-d3aa-a8c2-6317-516127c8ba88
                                      3be8b43a-1143-4e26-8ecb-660a5a78edc5
                                      6802a8e3-bca8-d9b4-01f2-50290fc3e45b
                                      0a4ba8f5-9c64-b473-ec37-e3e3e4ed9f91
                                      70e9297e-c40a-5679-edcf-5287d6577ca2
                                      1e4f3a23-1eba-00a1-96f9-ea2f43e74b41
                                      2cca54ea-3946-87e1-28fa-cd4ddb6f1fb9
                                      d17e4f27-d1aa-821e-dd0b-1a456dd678e6])
    expect(orgs.map(&:company_type)).to eq(%w[
                                             for_profit for_profit for_profit for_profit for_profit
                                             for_profit for_profit for_profit for_profit for_profit
                                           ])
  end
end
