# typed: false

require 'spec_helper'
require_relative '../../../../lib/services/editors/megaverse_editor'

RSpec.describe MegaverseEditor do
  let(:subject) { described_class }

  describe '.add' do
    it 'calls post with correct params' do
      expect(subject).to receive(:post).with(
        hash_including(
          'column' => 1,
          'row' => 2,
          'candidateId' => ENV.fetch('CANDIDATE_ID')
        )
      )

      subject.add(1, 2)
    end

    it 'raises NotImplementedError when api is not defined' do
      expect { subject.add(1, 2) }.to raise_error(NotImplementedError)
    end
  end

  describe '.remove' do
    it 'calls delete with correct params' do
      expect(subject).to receive(:delete).with(
        hash_including(
          'column' => 3,
          'row' => 4,
          'candidateId' => ENV.fetch('CANDIDATE_ID')
        )
      )

      subject.remove(3, 4)
    end

    it 'raises NotImplementedError when api is not defined' do
      expect { subject.remove(1, 2) }.to raise_error(NotImplementedError)
    end
  end
end
