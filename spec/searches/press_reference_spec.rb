# frozen_string_literal: true

RSpec.describe Crunchbase::Searches::Client do
  it 'be able search press references with raw params by search client' do
    post_data_raw = {
      'field_ids' => %w[
        uuid
        title
        author
        url
        posted_on
        publisher
        thumbnail_url
        entity_def_id
        created_at
        updated_at
        activity_entities
      ],
      'order' => [
        {
          'field_id' => 'posted_on',
          'sort' => 'desc',
          'nulls' => 'last'
        }
      ],
      'query' => [
        {
          'type' => 'predicate',
          'field_id' => 'posted_on',
          'operator_id' => 'gte',
          'values' => [
            '2023-04-04'
          ]
        }
      ],
      'limit' => 100
    }

    response = VCR.use_cassette('searches_press_references_with_posted_on_order_posted_on') do
      described_class.new(post_data_raw, 'press_reference').searches
    end

    press_references = response.entities

    # search limit cannot exceed 1000
    expect(response.count).to eq(100)
    expect(response.total_count).to eq(190_152)
    expect(press_references[0].title).to eq('Lifshitz Law PLLC Announces Investigations of SURF, NETI, NEX, and PTEN')
    expect(press_references[0].posted_on).to eq('2023-06-25')
  end

  it 'be able search press references with sort by client' do
    response = VCR.use_cassette('recent_updates_press_references_with_posted_on_order_posted_on') do
      Crunchbase::Client.new.recent_updates({
                                              scope_name: 'press_reference',
                                              field_ids: %w[title author url posted_on publisher thumbnail_url entity_def_id activity_entities],
                                              order_field_ids: ['posted_on'],
                                              date: '2023-04-04',
                                              limit: 100
                                            })
    end

    press_references = response.entities

    # search limit cannot exceed 1000
    expect(response.count).to eq(100)
    expect(response.total_count).to eq(190_157)
    expect(press_references[0].title).to eq('Lifshitz Law PLLC Announces Investigations of SURF, NETI, NEX, and PTEN')
    expect(press_references[0].posted_on).to eq('2023-06-25')
  end

  it 'be able search press references with multiple sort' do
    response = VCR.use_cassette('recent_updates_press_references_with_posted_on_order_posted_on_and_updated_at') do
      Crunchbase::Client.new.recent_updates({
                                              scope_name: 'press_reference',
                                              field_ids: %w[title author url posted_on publisher thumbnail_url entity_def_id activity_entities],
                                              order_field_ids: %w[posted_on updated_at],
                                              date: '2023-04-04',
                                              limit: 100
                                            })
    end

    press_references = response.entities

    # search limit cannot exceed 1000
    expect(response.count).to eq(100)
    expect(response.total_count).to eq(213_453)
    expect(press_references[0].title).to eq('FSD Pharma Appoints Zeeshan Saeed as Chief Executive Officer, Anthony Durkacz to Serve as Executive Co-Chairman of the Board of Directors')
    expect(press_references[0].posted_on).to eq('2023-07-04')
  end
end
