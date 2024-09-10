# frozen_string_literal: true

require 'spec_helper'

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

      expect(funding_round.permalink).to eq('facebook-post-ipo-secondary--371c20af')
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

    it 'be able to get organization data with ipos' do
      organization = VCR.use_cassette('organization-facebook-with-ipos') do
        client.organization('facebook', { card_id: 'ipos' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.ipos.size).to eq(1)
      expect(organization.ipos[0].uuid).to eq('8fd30bb3-9eb9-839d-4526-85f82c1bfdf7')
      expect(organization.ipos[0].amount_raised).to eq(18_400_000_000)
    end

    it 'raise error when with a invalid card_id' do
      expect do
        VCR.use_cassette('organization-facebook-with-funding_rounds') do
          client.organization('facebook', { card_id: 'funding_rounds' })
        end
      end.to raise_error(Crunchbase::Error, 'Invalid card_id')
    end

    it 'be able to get organization data with raised_funding_rounds' do
      organization = VCR.use_cassette('organization-facebook-with-raised_funding_rounds') do
        client.organization('facebook', { card_id: 'raised_funding_rounds' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.raised_funding_rounds.size).to eq(17)
      expect(organization.raised_funding_rounds[0].announced_on).to eq('2014-10-17')
      expect(organization.raised_funding_rounds[0].investment_type).to eq('post_ipo_equity')
      expect(organization.raised_funding_rounds[0].uuid).to eq('0a7ca04f-9bd5-4134-b06b-112deaaa4dc8')
      expect(organization.raised_funding_rounds.map(&:pre_money_valuation).compact).to eq(
        [48_500_000_000, 13_800_000_000, 9_800_000_000, 14_760_000_000, 14_760_000_000, 475_000_000, 85_300_000]
      )
      expect(organization.raised_funding_rounds.map(&:funded_organization_diversity_spotlights).compact.flatten!).to eq(
        nil
      )
    end

    it 'be able to get pre_money_valuation and diversity_spotlights data from raised_funding_rounds' do
      organization = VCR.use_cassette('organization-calendly-with-raised_funding_rounds') do
        client.organization('calendly', { card_id: 'raised_funding_rounds' })
      end

      expect(organization.permalink).to eq('calendly')
      expect(organization.raised_funding_rounds.map(&:pre_money_valuation).compact).to eq(
        [2_650_000_000]
      )
      expect(organization.raised_funding_rounds.map(&:funded_organization_diversity_spotlights).compact.flatten!.uniq).to eq(
        ['Black / African American Founded', 'Black / African American Led']
      )
    end

    it 'be able to get a funding_round with investments data' do
      funding_round = VCR.use_cassette('funding_round-371c20af-8aa9-4bcb-a8da-0694d138f247-with_investments') do
        client.funding_round('371c20af-8aa9-4bcb-a8da-0694d138f247', card_id: 'investments')
      end

      expect(funding_round.uuid).to eq('371c20af-8aa9-4bcb-a8da-0694d138f247')
      expect(funding_round.investments.size).to eq(1)
      expect(funding_round.investments[0].uuid).to eq('1368da0c-07b0-46ef-9a86-b518367e60d6')
      expect(funding_round.investments[0].announced_on).to eq('2013-06-30')
      expect(funding_round.investments[0].investor_type).to eq(['angel'])
      expect(funding_round.investments[0].organization_identifier).to eq('Facebook')
    end

    it 'be able to get a person with participated_investments data' do
      person = VCR.use_cassette('people-mark-zuckerberg-with-participated_investments') do
        client.person('mark-zuckerberg', card_id: 'participated_investments')
      end

      expect(person.uuid).to eq('a01b8d46-d311-3333-7c34-aa3ae9c03f22')
      expect(person.participated_investments.size).to eq(8)
      expect(person.participated_investments[0].uuid).to eq('53b33599-f875-47e8-8671-22683122aaba')
      expect(person.participated_investments[0].investor_stage).to eq(['seed'])
      expect(person.participated_investments[0].name).to eq('Mark Zuckerberg investment in Angel Round - LEANLAB Education')
    end

    it 'be able to get organization data with raised_funds' do
      organization = VCR.use_cassette('organization-facebook-with-raised_funds') do
        client.organization('facebook', { card_id: 'raised_funds' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.raised_funds.size).to eq(0)
    end

    it 'be able to get organization data with participated_funds' do
      organization = VCR.use_cassette('organization-facebook-with-participated_funds') do
        client.organization('facebook', { card_id: 'participated_funds' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.participated_funds.size).to eq(1)
      expect(organization.participated_funds[0].permalink).to eq('the-news-integrity-initiative-raised-the-news-integrity-initiative-fund-i--aeaac12b')
      expect(organization.participated_funds[0].uuid).to eq('aeaac12b-df56-7039-40f9-f1992f88e20e')
      expect(organization.participated_funds[0].money_raised).to eq(14_000_000)
      expect(organization.participated_funds[0].announced_on).to eq('2017-04-03')
    end

    it 'be able to get fund data' do
      fund = VCR.use_cassette('fund-aeaac12b-df56-7039-40f9-f1992f88e20e') do
        client.fund('aeaac12b-df56-7039-40f9-f1992f88e20e')
      end

      expect(fund.permalink).to eq('the-news-integrity-initiative-raised-the-news-integrity-initiative-fund-i--aeaac12b')
      expect(fund.uuid).to eq('aeaac12b-df56-7039-40f9-f1992f88e20e')
    end

    it 'be able to get organization data with parent_ownership' do
      organization = VCR.use_cassette('organization-facebook-with-parent_ownership') do
        client.organization('facebook', { card_id: 'parent_ownership' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.parent_ownership.size).to eq(0)
    end

    it 'be able to get organization data with child_ownerships' do
      organization = VCR.use_cassette('organization-facebook-with-child_ownerships') do
        client.organization('facebook', { card_id: 'child_ownerships' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.child_ownerships.size).to eq(4)
      expect(organization.child_ownerships[0].permalink).to eq('facebook-owns-instagram--4506d9ce')
      expect(organization.child_ownerships[0].uuid).to eq('4506d9ce-85d3-4a8f-89cd-07a225359d55')
      expect(organization.child_ownerships[0].name).to eq('Facebook owns Instagram')
      expect(organization.child_ownerships[0].ownee_identifier).to eq('Instagram')
      expect(organization.child_ownerships[0].owner_identifier).to eq('Facebook')
    end

    it 'be able to get ownership data' do
      ownership = VCR.use_cassette('ownership-4506d9ce-85d3-4a8f-89cd-07a225359d55') do
        client.ownership('4506d9ce-85d3-4a8f-89cd-07a225359d55')
      end

      expect(ownership.permalink).to eq('facebook-owns-instagram--4506d9ce')
      expect(ownership.uuid).to eq('4506d9ce-85d3-4a8f-89cd-07a225359d55')
      expect(ownership.ownee_identifier).to eq('Instagram')
      expect(ownership.owner_identifier).to eq('Facebook')
    end

    it 'be able to get organization data with founders' do
      organization = VCR.use_cassette('organization-facebook-with-founders') do
        client.organization('facebook', { card_id: 'founders' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.founders.size).to eq(5)
      expect(organization.num_founders).to eq(5)
      expect(organization.founders.map(&:name)).to eq(['Andrew McCollum', 'Chris Hughes', 'Dustin Moskovitz', 'Eduardo Saverin', 'Mark Zuckerberg'])
      expect(organization.founders.map(&:uuid)).to eq(%w[
                                                        76742b37-a375-321b-1ddc-de1c929894fa
                                                        5ac8203a-540a-ab6c-46ee-84463834fe72
                                                        084aaa07-0795-1fe8-9c46-98bbeb02cd64
                                                        fb5b458c-0aab-a977-71b9-ecf78d3ec756
                                                        a01b8d46-d311-3333-7c34-aa3ae9c03f22
                                                      ])
      expect(organization.founders[0].permalink).to eq('andrew-mccollum')
    end

    it 'be able to get organization data with event_appearances' do
      organization = VCR.use_cassette('organization-facebook-with-event_appearances') do
        client.organization('facebook', { card_id: 'event_appearances' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.num_event_appearances).to eq(230)
      expect(organization.event_appearances.size).to eq(100)
      expect(organization.event_appearances[0].appearance_type).to eq('sponsor')
      expect(organization.event_appearances[0].event_starts_on).to eq('2020-12-09')
      expect(organization.event_appearances[0].identifier).to eq([
                                                                   '7f9884b3-31be-4c1f-b911-546da9913d35',
                                                                   "The AI Summit New York 2020's sponsor - Facebook",
                                                                   'facebook-sponsor-the-ai-summit-new-york-2020--7f9884b3'
                                                                 ])
      expect(organization.event_appearances[0].name).to eq("The AI Summit New York 2020's sponsor - Facebook")
      expect(organization.event_appearances[0].permalink).to eq('facebook-sponsor-the-ai-summit-new-york-2020--7f9884b3')
    end

    it 'be able to get organization data with investors' do
      organization = VCR.use_cassette('organization-facebook-with-investors') do
        client.organization('facebook', { card_id: 'investors' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.investors.size).to eq(25)
      expect(organization.num_investors).to eq(25)
      expect(organization.investors[0].aliases).to eq(['Accel Partners'])
      expect(organization.investors[0].categories).to eq(['Finance', 'Online Portals', 'Venture Capital'])
      expect(organization.investors[0].facebook).to eq('http://www.facebook.com/accel')
      expect(organization.investors[0].linkedin).to eq('https://www.linkedin.com/company/accel-vc/')
      expect(organization.investors[0].name).to eq('Accel')
      expect(organization.investors[0].website).to eq('http://www.accel.com')
      expect(organization.investors[0].uuid).to eq('b08efc27-da40-505a-6f9d-c9e14247bf36')
    end

    it 'be able to get organization data with jobs' do
      organization = VCR.use_cassette('organization-facebook-with-jobs') do
        client.organization('facebook', { card_id: 'jobs' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.jobs.size).to eq(100)
      expect(organization.jobs[0].title).to eq('Founder & CEO')
      expect(organization.jobs[0].started_on).to eq('2004-01-01')
      expect(organization.jobs[0].person_identifier).to eq('Mark Zuckerberg')
      expect(organization.jobs[0].permalink).to eq('mark-zuckerberg-executive-facebook--befc22de')
      expect(organization.jobs[0].organization_identifier).to eq('Facebook')
      expect(organization.jobs[0].name).to eq('Mark Zuckerberg Founder & CEO @ Facebook')
      expect(organization.jobs[0].is_current).to eq(true)
      expect(organization.jobs[0].job_type).to eq('executive')
    end

    it 'be able to get organization data with headquarters_address' do
      organization = VCR.use_cassette('organization-facebook-with-headquarters_address') do
        client.organization('facebook', { card_id: 'headquarters_address' })
      end

      expect(organization.permalink).to eq('facebook')
      expect(organization.headquarters_address.size).to eq(1)
      expect(organization.headquarters_address[0].identifier).to eq(%w[fb31a5f3-80fd-4298-becd-6224e7174c28 Headquarters])
      expect(organization.headquarters_address[0].location_identifiers).to eq(['Menlo Park', 'California', 'United States', 'North America'])
      expect(organization.headquarters_address[0].name).to eq('Headquarters')
      expect(organization.headquarters_address[0].street_1).to eq('1 Hacker Way')
      expect(organization.headquarters_address[0].uuid).to eq('fb31a5f3-80fd-4298-becd-6224e7174c28')
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
        client.autocomplete('ekohe', { collection_ids: 'organizations' })
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
        client.autocomplete('maxime', { collection_ids: 'people' })
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
        client.autocomplete('facebook', { collection_ids: 'funding_rounds' })
      end

      funding_rounds = response.entities
      expect(response.count).to eq(25)
      expect(response.total_count).to eq(29)
      expect(funding_rounds[0].permalink).to eq('facebook-series-b--6fae3958')
      expect(funding_rounds[0].uuid).to eq('6fae3958-a001-27c0-fb7e-666266aedd78')
      expect(funding_rounds[0].identifier).to eq(['6fae3958-a001-27c0-fb7e-666266aedd78', 'Series B - Facebook', 'facebook-series-b--6fae3958'])
    end
  end

  context 'Deleted Entities' do
    it 'returns deleted organizations' do
      response = VCR.use_cassette('deleted_entities_of_organizations') do
        client.deleted_entities(collection_ids: 'organizations')
      end

      entities = response.entities
      expect(response.count).to eq(1000)
      expect(response.total_count).to eq(1000)
      expect(entities[0].uuid).to eq('31e5d1dd-3a7d-4c8c-b7dc-4780d391bbc3')
      expect(entities[0].entity_def_id).to eq('organization')
      expect(entities[0].deleted_at).to eq('2020-06-06T11:51:34Z')
    end

    it 'returns deleted people' do
      response = VCR.use_cassette('deleted_entities_of_people') do
        client.deleted_entities(collection_ids: 'people')
      end

      entities = response.entities
      expect(response.count).to eq(1000)
      expect(response.total_count).to eq(1000)
      expect(entities[0].uuid).to eq('784c1e28-6fab-2f54-1bbe-b27c8817eaaa')
      expect(entities[0].entity_def_id).to eq('person')
      expect(entities[0].deleted_at).to eq('2020-06-04T22:07:42Z')
    end

    it 'returns deleted funding rounds' do
      response = VCR.use_cassette('deleted_entities_of_funding_rounds') do
        client.deleted_entities(collection_ids: 'funding_rounds')
      end

      entities = response.entities
      expect(response.count).to eq(1000)
      expect(response.total_count).to eq(1000)
      expect(entities[0].uuid).to eq('a7c30804-eb6f-4828-a0a7-b2fd5fa3c789')
      expect(entities[0].entity_def_id).to eq('funding_round')
      expect(entities[0].deleted_at).to eq('2020-06-05T22:33:32Z')
    end
  end
end
