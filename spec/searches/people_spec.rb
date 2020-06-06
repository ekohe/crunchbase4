# frozen_string_literal: true

RSpec.describe Crunchbase::Searches::Client do
  it 'be able search people by contains keyword' do
    post_data_raw = {
      'field_ids' => %w[
        first_name
        last_name
        uuid
        permalink
        name
        aliases
        website
        rank
      ],
      'order' => [
        {
          'field_id' => 'first_name',
          'sort' => 'asc',
          'nulls' => 'last'
        }
      ],
      'query' => [
        {
          'type' => 'predicate',
          'field_id' => 'first_name',
          'operator_id' => 'contains',
          'values' => [
            'Maxime'
          ]
        },
        {
          'type' => 'predicate',
          'field_id' => 'last_name',
          'operator_id' => 'contains',
          'values' => [
            'Guilbot'
          ]
        }
      ],
      'limit' => 100
    }

    response = VCR.use_cassette('searches_people_with_first_name_order_first_name') do
      described_class.new(post_data_raw, 'person').searches
    end

    people = response.entities

    expect(response.count).to eq(1)
    expect(response.total_count).to eq(1)
    expect(people.map(&:name)).to eq(['Maxime Guilbot'])
  end

  it 'raise an error when sorting a not permissions field' do
    post_data_raw = {
      'field_ids' => %w[
        first_name
        last_name
        uuid
        permalink
        name
        aliases
        website
        rank
      ],
      'order' => [
        {
          'field_id' => 'name',
          'sort' => 'asc',
          'nulls' => 'last'
        }
      ],
      'query' => [
        {
          'type' => 'predicate',
          'field_id' => 'aliases',
          'operator_id' => 'eq',
          'values' => 'Maxime Guibot'
        }
      ],
      'limit' => 5
    }

    expect do
      VCR.use_cassette('searches_people_with_first_name_and_last_name_order_first_name') do
        described_class.new(post_data_raw, 'person').searches
      end
    end.to raise_error(Crunchbase::Error, 'insufficient permissions to sort field name')
  end

  it 'be able search people by uuid' do
    post_data_raw = {
      'field_ids' => %w[
        first_name
        last_name
        uuid
        permalink
        name
        aliases
        website
        description
      ],
      'order' => [
        {
          'field_id' => 'first_name',
          'sort' => 'asc',
          'nulls' => 'last'
        }
      ],
      'query' => [
        {
          'type' => 'predicate',
          'field_id' => 'uuid',
          'operator_id' => 'eq',
          'values' => [
            'a01b8d46-d311-3333-7c34-aa3ae9c03f22'
          ]
        }
      ],
      'limit' => 5
    }

    response = VCR.use_cassette('searches_people_with_uuid_order_first_name') do
      described_class.new(post_data_raw, 'person').searches
    end

    people = response.entities

    expect(response.count).to eq(1)
    expect(response.total_count).to eq(1)
    expect(people.map(&:name)).to eq(['Mark Zuckerberg'])
    expect(people.map(&:uuid)).to eq(%w[a01b8d46-d311-3333-7c34-aa3ae9c03f22])
  end

  it 'be able search people by uuid' do
    post_data_raw = {
      'field_ids' => %w[
        first_name
        last_name
        uuid
        permalink
        name
        description
      ],
      'order' => [
        {
          'field_id' => 'first_name',
          'sort' => 'asc',
          'nulls' => 'last'
        }
      ],
      'query' => [
        {
          'type' => 'predicate',
          'field_id' => 'description',
          'operator_id' => 'contains',
          'values' => [
            'Mark Zuckerberg is the founder and CEO of Facebook'
          ]
        }
      ],
      'limit' => 5
    }

    response = VCR.use_cassette('searches_people_with_description_order_first_name') do
      described_class.new(post_data_raw, 'person').searches
    end

    people = response.entities

    expect(response.count).to eq(1)
    expect(response.total_count).to eq(1)
    expect(people.map(&:name)).to eq(['Mark Zuckerberg'])
    expect(people.map(&:uuid)).to eq(%w[a01b8d46-d311-3333-7c34-aa3ae9c03f22])
  end
end
