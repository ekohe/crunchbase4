# frozen_string_literal: true

RSpec.describe Crunchbase::Client do
  let(:client) { described_class.new }

  it 'be able to get organization data' do
    org = VCR.use_cassette('organization_ekohe') do
      client.organization('ekohe')
    end

    expect(org.name).to eq('Ekohe')
    expect(org.permalink).to eq('ekohe')
    expect(org.uuid).to eq('9fe491b2-b6a1-5c87-0f4d-226dd0cc97a9')
  end

  it 'be able to get person data' do
    org = VCR.use_cassette('person-mark-zuckerberg') do
      client.person('mark-zuckerberg')
    end

    expect(org.name).to eq('Mark Zuckerberg')
    expect(org.permalink).to eq('mark-zuckerberg')
    expect(org.uuid).to eq('a01b8d46-d311-3333-7c34-aa3ae9c03f22')
  end
end
