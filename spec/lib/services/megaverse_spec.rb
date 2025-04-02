# typed: false

require 'spec_helper'
require_relative '../../../lib/services/megaverse'

RSpec.describe Megaverse do
  let(:subject) { described_class }
  let(:base_url) { ENV.fetch('BASE_URL') }
  let(:candidate_id) { ENV.fetch('CANDIDATE_ID') }

  describe '.map' do
    it 'returns a 2D matrix of strings from the fetch_megaverse method' do
      mock_response = {
        'goal' => [%w[SPACE POLYANET], %w[LEFT_COMETH WHITE_SOLOON]]
      }

      stub_request(:get, "#{base_url}/map/#{candidate_id}/goal").to_return(
        body: mock_response.to_json,
        status: 200
      )

      result = described_class.map
      expect(result).to eq(mock_response['goal'])

      expect(result).to have_requested(
        :get,
        "#{base_url}/map/#{candidate_id}/goal"
      ).once
    end
  end
end
