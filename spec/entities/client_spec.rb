# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Crunchbase::Entities::Client do
  it 'be able to get organization data' do
    org = VCR.use_cassette('organization_ekohe') do
      described_class.new('ekohe', Crunchbase::Models::Organization).fetch
    end

    expect(org.uuid).to eq('9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9')
    expect(org.website).to eq('https://ekohe.com')
    expect(org.twitter).to eq('https://twitter.com/ekohe')
    expect(org.categories).to eq([
                                   'Apps', 'Artificial Intelligence', 'Big Data', 'Blockchain', 'Cryptocurrency', 'Enterprise Software',
                                   'iOS', 'Machine Learning', 'Retail', 'UX Design'
                                 ])
    expect(org.category_groups).to eq([
                                        'Apps', 'Artificial Intelligence', 'Commerce and Shopping', 'Data and Analytics', 'Design',
                                        'Financial Services', 'Mobile', 'Other', 'Payments', 'Platforms', 'Science and Engineering', 'Software'
                                      ])
    expect(org.company_type).to eq('for_profit')
    expect(org.status).to eq('operating')
    expect(org.contact_email).to eq('info@ekohe.com')
    expect(org.created_at).to eq('2013-05-14T14:28:38Z')
    expect(org.updated_at).to eq('2022-07-19T01:29:26Z')
    expect(org.rank).to eq(296_890)
    expect(org.rank_delta_d30).to eq(-0.2)
    expect(org.rank_delta_d7).to eq(-0.4)
    expect(org.rank_delta_d90).to eq(-0.4)
    expect(org.rank_principal).to eq(296_889)
    expect(org.phone_number).to eq('+81-3-6427-6105')
    expect(org.short_description).to eq('Creating cutting-edge, useful technical solutions to move you forward -- we deliver on the promise of AI.')
    expect(org.description).to include('At Ekohe, we believe in the positive, transformational power of technology.')
    expect(org.entity_def_id).to eq('organization')
    expect(org.permalink_aliases).to eq([])
    expect(org.permalink).to eq('ekohe')
    expect(org.override_layout_id).to eq('default')
    expect(org.operating_status).to eq('active')
    expect(org.num_founders).to eq(1)
    expect(org.num_event_appearances).to eq(1)
    expect(org.num_employees_enum).to eq('c_00051_00100')
    expect(org.employees_range).to eq('51-100')
    expect(org.num_current_positions).to eq(1)
    expect(org.name).to eq('Ekohe')
    expect(org.identifier).to eq(%w[9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9 Ekohe ekohe])
    expect(org.image_id).to eq('v1500646625/zhionn8nlgbkz4lj7ilz.png')
    expect(org.image_url).to eq('https://res.cloudinary.com/crunchbase-production/image/upload/v1500646625/zhionn8nlgbkz4lj7ilz.png')
    expect(org.location_identifiers).to eq(%w[Shanghai Shanghai China Asia])
    expect(org.location_group_identifiers).to eq(['Asia-Pacific (APAC)'])
    expect(org.linkedin).to eq('https://www.linkedin.com/company/ekohe')
    expect(org.ipo_status).to eq('private')
  end

  it 'be able to get person data' do
    person = VCR.use_cassette('person-mark-zuckerberg') do
      described_class.new('mark-zuckerberg', Crunchbase::Models::Person).fetch
    end

    expect(person.name).to eq('Mark Zuckerberg')
    expect(person.permalink).to eq('mark-zuckerberg')
    expect(person.uuid).to eq('a01b8d46-d311-3333-7c34-aa3ae9c03f22')
    expect(person.aliases).to eq(['Zuck'])
    expect(person.born_on).to eq('1984-05-14')
    expect(person.identifier).to eq(['a01b8d46-d311-3333-7c34-aa3ae9c03f22', 'Mark Zuckerberg', 'mark-zuckerberg'])
    expect(person.first_name).to eq('Mark')
    expect(person.last_name).to eq('Zuckerberg')
    expect(person.gender).to eq('male')
    expect(person.entity_def_id).to eq('person')
    expect(person.facebook).to eq('https://www.facebook.com/zuck')
    expect(person.image_url).to eq('https://res.cloudinary.com/crunchbase-production/image/upload/v1448830269/gzcifut4c2xah95x0ewd.jpg')
    expect(person.twitter).to eq('https://twitter.com/finkd')
    expect(person.facebook).to eq('https://www.facebook.com/zuck')
    expect(person.created_at).to eq('2007-05-26T04:51:46Z')
    expect(person.description).to include('Mark Zuckerberg is the founder and CEO of Facebook')
    expect(person.facet_ids).to eq(%w[investor rank])
    expect(person.image_id).to eq('v1448830269/gzcifut4c2xah95x0ewd.jpg')
    expect(person.investor_stage).to eq(['seed'])
    expect(person.investor_type).to eq(%w[investment_partner angel])
    expect(person.layout_id).to eq('investor')
    expect(person.location_group_identifiers).to eq(['San Francisco Bay Area', 'Silicon Valley', 'West Coast', 'Western US'])
    expect(person.location_identifiers).to eq(['Palo Alto', 'California', 'United States', 'North America'])
    expect(person.num_articles).to eq(31_052)
    expect(person.num_current_advisor_jobs).to eq(4)
    expect(person.num_current_jobs).to eq(7)
    expect(person.num_event_appearances).to eq(6)
    expect(person.num_founded_organizations).to eq(8)
    expect(person.num_investments).to eq(8)
    expect(person.num_investments_funding_rounds).to eq(8)
    expect(person.num_jobs).to eq(14)
    expect(person.num_lead_investments).to eq(1)
    expect(person.num_partner_investments).to eq(2)
    expect(person.num_past_advisor_jobs).to eq(2)
    expect(person.num_past_jobs).to eq(1)
    expect(person.num_portfolio_organizations).to eq(7)
    expect(person.permalink_aliases).to eq([])
    expect(person.primary_job_title).to eq('Founder & CEO')
    expect(person.primary_organization).to eq('Facebook')
    expect(person.rank).to eq(21_000)
    expect(person.rank_delta_d30).to eq(1.1)
    expect(person.rank_delta_d7).to eq(1.1)
    expect(person.rank_delta_d90).to eq(1.2)
    expect(person.rank_person).to eq(61)
    expect(person.rank_principal).to eq(21_000)
    expect(person.short_description).to eq('Mark Zuckerberg is the founder and CEO of Facebook, which he started in his college dorm room in 2004 with roomates Dustin Moskovitz and Chr...')
    expect(person.updated_at).to eq('2018-12-13T14:05:34Z')
  end

  it 'be able to get funding round data' do
    funding_round = VCR.use_cassette('funding_round-371c20af-8aa9-4bcb-a8da-0694d138f247') do
      described_class.new('371c20af-8aa9-4bcb-a8da-0694d138f247', Crunchbase::Models::FundingRound).fetch
    end

    expect(funding_round.announced_on).to eq('2013-06-30')
    expect(funding_round.closed_on).to eq(nil)
    expect(funding_round.created_at).to eq('2020-04-02T12:17:59Z')
    expect(funding_round.entity_def_id).to eq('funding_round')
    expect(funding_round.funded_organization_categories).to eq(['Mobile Apps', 'Social', 'Social Media', 'Social Network'])
    expect(funding_round.funded_organization_description).to eq('Facebook is an online social networking service that enables its users to connect with friends and family.')
    expect(funding_round.funded_organization_funding_stage).to eq('ipo')
    expect(funding_round.funded_organization_funding_total).to eq(16_122_817_488)
    expect(funding_round.funded_organization_identifier).to eq('Facebook')
    expect(funding_round.funded_organization_location).to eq(['Menlo Park', 'California', 'United States', 'North America'])
    expect(funding_round.funded_organization_revenue_range).to eq('r_10000000')
    expect(funding_round.identifier).to eq(['371c20af-8aa9-4bcb-a8da-0694d138f247', 'Post-IPO Secondary - Facebook', 'facebook-post-ipo-secondary--371c20af'])
    expect(funding_round.image_id).to eq('rde5yhdgakaqryj6zpu6')
    expect(funding_round.investment_stage).to eq(nil)
    expect(funding_round.investment_type).to eq('post_ipo_secondary')
    expect(funding_round.investor_identifiers).to eq(['Jon Hassan'])
    expect(funding_round.is_equity).to eq(false)
    expect(funding_round.lead_investor_identifiers).to eq(nil)
    expect(funding_round.money_raised).to eq(nil)
    expect(funding_round.name).to eq('Post-IPO Secondary - Facebook')
    expect(funding_round.num_investors).to eq(1)
    expect(funding_round.num_partners).to eq(nil)
    expect(funding_round.num_relationships).to eq(nil)
    expect(funding_round.permalink).to eq('facebook-post-ipo-secondary--371c20af')
    expect(funding_round.pre_money_valuation).to eq(nil)
    expect(funding_round.rank).to eq(2_394_928)
    expect(funding_round.rank_funding_round).to eq(88_656)
    expect(funding_round.short_description).to eq('Facebook raised an undisclosed amount on 2013-06-30 in Post-IPO Secondary')
    expect(funding_round.target_money_raised).to eq(nil)
    expect(funding_round.updated_at).to eq('2020-11-03T17:59:34Z')
    expect(funding_round.uuid).to eq('371c20af-8aa9-4bcb-a8da-0694d138f247')
  end

  it 'be able to get acquisition data' do
    acquisition = VCR.use_cassette('acquisition-7638eae9-07b7-4fc6-ad20-5d99de3ff928') do
      described_class.new('7638eae9-07b7-4fc6-ad20-5d99de3ff928', Crunchbase::Models::Acquisition).fetch
    end

    expect(acquisition.acquiree_categories).to eq(['Communities', 'Internet', 'Photo Sharing', 'Publishing', 'Search Engine', 'Social Media'])
    expect(acquisition.acquiree_funding_total).to eq(150_949_998)
    expect(acquisition.acquiree_identifier).to eq('Giphy')
    expect(acquisition.acquiree_last_funding_type).to eq('series_d')
    expect(acquisition.acquiree_locations).to eq(['New York', 'New York', 'United States', 'North America'])
    expect(acquisition.acquiree_num_funding_rounds).to eq(4)
    expect(acquisition.acquiree_revenue_range).to eq('r_00010000')
    expect(acquisition.acquiree_short_description).to eq('Giphy is an online database and search engine that allows users to search, share, and discover GIFs.')
    expect(acquisition.acquirer_categories).to eq(['Augmented Reality', 'Social Media', 'Social Network', 'Virtual Reality'])
    expect(acquisition.acquirer_funding_total).to eq(26_122_817_488)
    expect(acquisition.acquirer_identifier).to eq('Meta')
    expect(acquisition.acquirer_locations).to eq(['Menlo Park', 'California', 'United States', 'North America'])
    expect(acquisition.acquirer_num_funding_rounds).to eq(17)
    expect(acquisition.acquirer_revenue_range).to eq('r_10000000')
    expect(acquisition.acquirer_short_description).to eq('Meta is a social technology company that enables people to connect, find communities, and grow businesses.')
    expect(acquisition.acquisition_type).to eq('acquisition')
    expect(acquisition.announced_on).to eq('2020-05-15')
    expect(acquisition.completed_on).to eq('2021-03-29')
    expect(acquisition.created_at).to eq('2020-05-15T15:44:26Z')
    expect(acquisition.disposition_of_acquired).to eq('subsidiary')
    expect(acquisition.entity_def_id).to eq('acquisition')
    expect(acquisition.identifier).to eq(['7638eae9-07b7-4fc6-ad20-5d99de3ff928', 'Giphy acquired by Meta', 'facebook-acquires-giphy--7638eae9'])
    expect(acquisition.num_relationships).to eq(nil)
    expect(acquisition.permalink).to eq('facebook-acquires-giphy--7638eae9')
    expect(acquisition.price).to eq(400_000_000)
    expect(acquisition.rank).to eq(4_093_705)
    expect(acquisition.rank_acquisition).to eq(121_927)
    expect(acquisition.short_description).to eq('Meta acquires Giphy on 2020-05-15 for $400000000')
    expect(acquisition.status).to eq('complete')
    expect(acquisition.terms).to eq(nil)
    expect(acquisition.updated_at).to eq('2021-03-31T19:47:01Z')
    expect(acquisition.uuid).to eq('7638eae9-07b7-4fc6-ad20-5d99de3ff928')
  end

  it 'be able to get press_reference data' do
    press_reference = VCR.use_cassette('press_reference-0171b30e-9cf8-4ad5-8288-2993e4308e0f') do
      described_class.new('0171b30e-9cf8-4ad5-8288-2993e4308e0f', Crunchbase::Models::PressReference).fetch
    end

    expect(press_reference.activity_entities.map(&:name)).to eq(['Facebook', 'General Atlantic', 'KKR', 'Reliance Industries', 'Vista Equity Partners'])
    expect(press_reference.author).to eq(nil)
    expect(press_reference.created_at).to eq('2020-06-05T17:41:10Z')
    expect(press_reference.entity_def_id).to eq('press_reference')
    expect(press_reference.identifier).to eq(['0171b30e-9cf8-4ad5-8288-2993e4308e0f', 'Jio Platforms to receive $1.2b from Abu Dhabi’s sovereign investment firm'])
    expect(press_reference.posted_on).to eq('2020-06-05')
    expect(press_reference.publisher).to eq('Tech in Asia')
    expect(press_reference.thumbnail_url).to eq('https://cdn.techinasia.com/wp-content/uploads/2016/07/Flickr_-_World_Economic_Forum_-_Ambani.jpg')
    expect(press_reference.title).to eq('Jio Platforms to receive $1.2b from Abu Dhabi’s sovereign investment firm')
    expect(press_reference.updated_at).to eq('2020-06-05T17:41:10Z')
    expect(press_reference.url).to eq('https://ift.tt/3cByFh1')
    expect(press_reference.uuid).to eq('0171b30e-9cf8-4ad5-8288-2993e4308e0f')
  end

  it 'be able to get investment data' do
    investment = VCR.use_cassette('investment-1368da0c-07b0-46ef-9a86-b518367e60d6') do
      described_class.new('1368da0c-07b0-46ef-9a86-b518367e60d6', Crunchbase::Models::Investment).fetch
    end

    expect(investment.announced_on).to eq('2013-06-30')
    expect(investment.created_at).to eq('2020-04-02T12:17:59Z')
    expect(investment.entity_def_id).to eq('investment')
    expect(investment.funding_round_identifier).to eq('Secondary Market - Facebook')
    expect(investment.funding_round_money_raised).to eq(nil)
    expect(investment.identifier).to eq([
                                          '1368da0c-07b0-46ef-9a86-b518367e60d6',
                                          'Jean-Brice Abrial investment in Secondary Market - Facebook',
                                          'jean-brice-abrial-invested-in-facebook-secondary-market--371c20af--1368da0c'
                                        ])
    expect(investment.investor_identifier).to eq('Jean-Brice Abrial')
    expect(investment.investor_stage).to eq(%w[early_stage_venture seed])
    expect(investment.investor_type).to eq(['angel'])
    expect(investment.is_lead_investor).to eq(nil)
    expect(investment.money_invested).to eq(1_951_851.7217284038)
    expect(investment.name).to eq('Jean-Brice Abrial investment in Secondary Market - Facebook')
    expect(investment.organization_identifier).to eq('Facebook')
    expect(investment.partner_identifiers).to eq(nil)
    expect(investment.permalink).to eq('jean-brice-abrial-invested-in-facebook-secondary-market--371c20af--1368da0c')
    expect(investment.updated_at).to eq('2020-04-02T12:17:59Z')
    expect(investment.uuid).to eq('1368da0c-07b0-46ef-9a86-b518367e60d6')
  end

  it 'be able to get ipo data' do
    ipo = VCR.use_cassette('ipo-8fd30bb3-9eb9-839d-4526-85f82c1bfdf7') do
      described_class.new('8fd30bb3-9eb9-839d-4526-85f82c1bfdf7', 'ipo').fetch
    end

    expect(ipo.amount_raised).to eq(18_400_000_000)
    expect(ipo.created_at).to eq('2014-05-26T07:34:47Z')
    expect(ipo.delisted_on).to eq(nil)
    expect(ipo.entity_def_id).to eq('ipo')
    expect(ipo.identifier).to eq(['8fd30bb3-9eb9-839d-4526-85f82c1bfdf7', 'FB', 'facebook-ipo--8fd30bb3'])
    expect(ipo.image_id).to eq('rde5yhdgakaqryj6zpu6')
    expect(ipo.permalink).to eq('facebook-ipo--8fd30bb3')
    expect(ipo.rank).to eq(2_352_885)
    expect(ipo.rank_ipo).to eq(19_178)
    expect(ipo.share_price).to eq(38.0)
    expect(ipo.shares_outstanding).to eq(nil)
    expect(ipo.shares_sold).to eq(nil)
    expect(ipo.short_description).to eq('Facebook went public on 2012-05-18 and raised $18400000000. Facebook was valued at $104000000000')
    expect(ipo.stock_exchange_symbol).to eq('nasdaq')
    expect(ipo.stock_full_symbol).to eq('NASDAQ:FB')
    expect(ipo.stock_symbol).to eq('FB')
    expect(ipo.updated_at).to eq('2018-02-12T23:54:07Z')
    expect(ipo.uuid).to eq('8fd30bb3-9eb9-839d-4526-85f82c1bfdf7')
    expect(ipo.valuation).to eq(104_000_000_000)
    expect(ipo.went_public_on).to eq('2012-05-18')
  end
end
