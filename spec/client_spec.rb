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
      end.to raise_error(Crunchbase::Error, 'requested resource could not be found')
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
      end.to raise_error(Crunchbase::Error, 'requested resource could not be found')
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
      end.to raise_error(Crunchbase::Error, 'requested resource could not be found')
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

    it 'be able to get ipo data' do
      ipo = VCR.use_cassette('ipo-8fd30bb3-9eb9-839d-4526-85f82c1bfdf7') do
        client.ipo('8fd30bb3-9eb9-839d-4526-85f82c1bfdf7')
      end

      expect(ipo.permalink).to eq('facebook-ipo--8fd30bb3')
      expect(ipo.uuid).to eq('8fd30bb3-9eb9-839d-4526-85f82c1bfdf7')
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

    it 'returns all recently updated organizations' do
      response = VCR.use_cassette('searches_organizations_with_recently_updated_and_limit') do
        client.recent_updates({
                                scope_name: 'organization',
                                field_ids: %w[name website permalink],
                                date: '2020-05-05',
                                limit: 100
                              })
      end

      orgs = response.entities
      expect(response.count).to eq(100)
      expect(response.total_count).to eq(61_556)
      expect(orgs[0].name).to eq('Anavara Limited')
      expect(orgs[0].website).to eq('http://anavara.com/')
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
      expect(funding_rounds[0].identifier).to eq([
                                                   'xerox-post-ipo-equity--54708936',
                                                   '54708936-6f24-484c-9b31-3ba530a8bfb4',
                                                   'Post-IPO Equity - Xerox'
                                                 ])
      expect(funding_rounds[0].money_raised).to eq(24_000_000_000)
    end

    it 'returns all recently updated funding rounds' do
      response = VCR.use_cassette('searches_funding_rounds_with_recently_updated_and_limit') do
        client.recent_updates({
                                scope_name: 'funding_round',
                                field_ids: %w[identifier money_raised permalink],
                                date: '2020-05-05',
                                limit: 100
                              })
      end

      funding_rounds = response.entities
      expect(response.count).to eq(100)
      expect(response.total_count).to eq(9_124)
      expect(funding_rounds[0].permalink).to eq('eventus-systems-pre-seed--fa517725')
      expect(funding_rounds[0].uuid).to eq('fa517725-6ff6-4e74-b7b8-c283efa4c400')
      expect(funding_rounds[0].identifier).to eq([
                                                   'eventus-systems-pre-seed--fa517725',
                                                   'fa517725-6ff6-4e74-b7b8-c283efa4c400',
                                                   'Pre Seed Round - Eventus Systems'
                                                 ])
      expect(funding_rounds[0].money_raised).to eq(nil)
    end

    it 'be able search people by name' do
      post_data_raw = {
        'field_ids' => %w[
          first_name
          last_name
          uuid
          permalink
          name
        ],
        'order' => [
          {
            'field_id' => 'last_name',
            'sort' => 'asc',
            'nulls' => 'last'
          }
        ],
        'query' => [
          {
            'type' => 'predicate',
            'field_id' => 'first_name',
            'operator_id' => 'eq',
            'values' => [
              'Mark'
            ]
          },
          {
            'type' => 'predicate',
            'field_id' => 'last_name',
            'operator_id' => 'eq',
            'values' => [
              'Zuckerberg'
            ]
          }
        ],
        'limit' => 5
      }

      response = VCR.use_cassette('searches_people_with_first_name_and_last_name_order_last_name') do
        client.search_people(post_data_raw)
      end

      people = response.entities

      expect(response.count).to eq(1)
      expect(response.total_count).to eq(1)
      expect(people.map(&:name)).to eq(['Mark Zuckerberg'])
      expect(people.map(&:uuid)).to eq(%w[a01b8d46-d311-3333-7c34-aa3ae9c03f22])
    end

    it 'returns all recently updated people' do
      response = VCR.use_cassette('searches_people_with_recently_updated_and_limit') do
        client.recent_updates({
                                scope_name: 'person',
                                field_ids: %w[name first_name last_name permalink],
                                date: '2020-05-05',
                                limit: 100
                              })
      end

      people = response.entities
      expect(response.count).to eq(100)
      expect(response.total_count).to eq(19_270)
      expect(people[0].permalink).to eq('kritika-sharma-ee62')
      expect(people[0].uuid).to eq('96e7d947-ec04-41a7-8e18-4ea412f1ee62')
      expect(people[0].first_name).to eq('Kritika')
      expect(people[0].name).to eq('Kritika sharma')
    end
  end

  context 'Autocompletes API' do
    it 'returns matched organizations by keyword' do
      response = VCR.use_cassette('autocomplete_organizations_by_keyword-ekohe') do
        client.autocomplete_organizations('ekohe')
      end

      organizations = response.entities
      expect(response.count).to eq(25)
      expect(response.total_count).to eq(33)
      expect(organizations[0].permalink).to eq('ekohe')
      expect(organizations[0].uuid).to eq('9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9')
      expect(organizations[0].identifier).to eq(%w[9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9 Ekohe ekohe])
    end

    it 'returns matched people by keyword' do
      response = VCR.use_cassette('autocomplete_people_by_keyword-maxime') do
        client.autocomplete_people('maxime')
      end

      people = response.entities
      expect(response.count).to eq(25)
      expect(response.total_count).to eq(1_395)
      expect(people[0].permalink).to eq('maxime-leufroy-murat')
      expect(people[0].uuid).to eq('e270e799-052d-60ba-86d4-9c0535556851')
      expect(people[0].identifier).to eq(['e270e799-052d-60ba-86d4-9c0535556851', 'Maxime Leufroy-Murat', 'maxime-leufroy-murat'])
    end

    it 'returns matched funding rounds by facebook' do
      response = VCR.use_cassette('autocomplete_funding_rounds_by_keyword-facebook') do
        client.autocomplete_funding_rounds('facebook')
      end

      funding_rounds = response.entities
      expect(response.count).to eq(25)
      expect(response.total_count).to eq(29)
      expect(funding_rounds[0].permalink).to eq('facebook-series-b--6fae3958')
      expect(funding_rounds[0].uuid).to eq('6fae3958-a001-27c0-fb7e-666266aedd78')
      expect(funding_rounds[0].identifier).to eq(['6fae3958-a001-27c0-fb7e-666266aedd78', 'Series B - Facebook', 'facebook-series-b--6fae3958'])
    end
  end
end
