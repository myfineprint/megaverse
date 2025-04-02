# typed: false

require 'spec_helper'
require_relative '../../../../lib/services/editors/soloon_editor'

RSpec.describe SoloonEditor do
  let(:subject) { described_class }
  let(:base_url) { ENV.fetch('BASE_URL') }

  describe '.add' do
    before do
      stub_request(:post, "#{base_url}/soloons").with(
        body: {
          'column' => 1,
          'row' => 2,
          'color' => 'purple',
          'candidateId' => ENV.fetch('CANDIDATE_ID')
        }
      ).to_return(status: 200, body: '{}', headers: {})
    end

    it 'makes a POST request with correct parameters' do
      response = subject.add(1, 2, { 'color' => 'purple' })
      expect(response.code).to eq('200')
    end

    it 'does not raise NotImplementedError since api is defined' do
      expect { subject.add(1, 2, 'color' => 'purple') }.not_to raise_error
    end

    it 'raises error if integers are not passed' do
      expect { subject.add('1', '2') }.to raise_error
    end

    it 'raises error if direction is not passed' do
      expect { subject.add(1, 2) }.to raise_error
    end
  end

  describe '.remove' do
    before do
      stub_request(:delete, "#{base_url}/soloons").with(
        body: {
          'column' => 1,
          'row' => 2,
          'candidateId' => ENV.fetch('CANDIDATE_ID')
        }
      ).to_return(status: 200, body: '{}', headers: {})
    end

    it 'makes a DELETE request with correct parameters' do
      response = subject.remove(1, 2)
      expect(response.code).to eq('200')
    end

    it 'does not raise NotImplementedError since api is defined' do
      expect { subject.remove(1, 2) }.not_to raise_error
    end

    it 'raises error if integers are not passed' do
      expect { subject.remove('1', '2') }.to raise_error
    end
  end
end
