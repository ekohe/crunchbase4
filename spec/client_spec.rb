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
  end
end
