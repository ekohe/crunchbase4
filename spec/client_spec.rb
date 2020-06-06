# frozen_string_literal: true

RSpec.describe Crunchbase::Client do
  let(:client) { described_class.new }

  context 'Entity API' do
    it 'be able to get organization data' do
      org = VCR.use_cassette('organization_ekohe') do
        client.organization('ekohe')
      end

      expect(org.name).to eq('Ekohe')
      expect(org.permalink).to eq('ekohe')
      expect(org.uuid).to eq('9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9')
    end

    it 'returns not found when with a wrong organization uuid' do
      expect do
        VCR.use_cassette('organization_ekohe-encore-2020') do
          client.person('ekohe-encore-2020')
        end
      end.to raise_error(Crunchbase::Error, 'Not Found')
    end

    it 'be able to get person data' do
      person = VCR.use_cassette('person-mark-zuckerberg') do
        client.person('mark-zuckerberg')
      end

      expect(person.name).to eq('Mark Zuckerberg')
      expect(person.permalink).to eq('mark-zuckerberg')
      expect(person.uuid).to eq('a01b8d46-d311-3333-7c34-aa3ae9c03f22')
    end

    it 'returns not found when with a wrong person uuid' do
      expect do
        VCR.use_cassette('person-encore-shao-2020') do
          client.person('person-encore-shao-2020')
        end
      end.to raise_error(Crunchbase::Error, 'Not Found')
    end

    it 'be able to get funding round data' do
      funding_round = VCR.use_cassette('funding_round-371c20af-8aa9-4bcb-a8da-0694d138f247') do
        client.funding_round('371c20af-8aa9-4bcb-a8da-0694d138f247')
      end

      expect(funding_round.permalink).to eq('facebook-secondary-market--371c20af')
      expect(funding_round.uuid).to eq('371c20af-8aa9-4bcb-a8da-0694d138f247')
    end

    it 'returns not found when with a wrong funding round uuid' do
      expect do
        VCR.use_cassette('funding_round-a01b8d46-d311-3333-7c34-aa3ae9c03f22') do
          client.funding_round('a01b8d46-d311-3333-7c34-aa3ae9c03f22')
        end
      end.to raise_error(Crunchbase::Error, 'Not Found')
    end

    it 'be able to get acquisition data' do
      acquisition = VCR.use_cassette('acquisition-7638eae9-07b7-4fc6-ad20-5d99de3ff928') do
        client.acquisition('7638eae9-07b7-4fc6-ad20-5d99de3ff928')
      end

      expect(acquisition.permalink).to eq('facebook-acquires-giphy--7638eae9')
      expect(acquisition.uuid).to eq('7638eae9-07b7-4fc6-ad20-5d99de3ff928')
    end

    it 'be able to get press_reference data' do
      press_reference = VCR.use_cassette('press_reference-0171b30e-9cf8-4ad5-8288-2993e4308e0f') do
        client.press_reference('0171b30e-9cf8-4ad5-8288-2993e4308e0f')
      end

      expect(press_reference.title).to eq('Jio Platforms to receive $1.2b from Abu Dhabi’s sovereign investment firm')
      expect(press_reference.uuid).to eq('0171b30e-9cf8-4ad5-8288-2993e4308e0f')
    end

    it 'be able to get investment data' do
      investment = VCR.use_cassette('investment-1368da0c-07b0-46ef-9a86-b518367e60d6') do
        client.investment('1368da0c-07b0-46ef-9a86-b518367e60d6')
      end

      expect(investment.name).to eq('Jean-Brice Abrial investment in Secondary Market - Facebook')
      expect(investment.uuid).to eq('1368da0c-07b0-46ef-9a86-b518367e60d6')
    end
  end

  context 'Search API' do
    it 'be able to search organization' do
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
        client.search_organizations(post_data_raw)
      end

      orgs = response.entities
      expect(response.count).to eq(10)
      expect(response.total_count).to eq(44_867)
      expect(orgs.map(&:name)[0]).to eq('360VUZ')
      expect(orgs.map(&:website)[0]).to eq('http://www.360VUZ.com')
      expect(orgs.map(&:uuid)[0]).to eq('cb32a4d7-2bd0-1727-a055-63aa6a545380')
      expect(orgs.map(&:company_type)[0]).to eq('for_profit')
    end

    it 'be able to search funding rounds' do
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
        client.search_funding_rounds(post_data_raw)
      end
      funding_rounds = response.entities

      expect(response.count).to eq(100)
      expect(response.total_count).to eq(202_561)
      expect(funding_rounds[0].permalink).to eq('xerox-post-ipo-equity--54708936')
      expect(funding_rounds[0].uuid).to eq('54708936-6f24-484c-9b31-3ba530a8bfb4')
      expect(funding_rounds[0].identifier).to eq(['xerox-post-ipo-equity--54708936', '54708936-6f24-484c-9b31-3ba530a8bfb4'])
      expect(funding_rounds[0].money_raised).to eq(24_000_000_000)
    end
  end
end
