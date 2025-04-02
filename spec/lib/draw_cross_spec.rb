# typed: false

require 'spec_helper'
require_relative '../../lib/draw_cross'

RSpec.describe DrawCross do
  let(:base_url) { ENV.fetch('BASE_URL') }
  let(:map) { [%w[SPACE SPACE], %w[SPACE SPACE]] }

  subject { described_class.new }

  before do
    allow(Megaverse).to receive(:map).and_return(map)

    allow(PolyanetEditor).to receive(:add)

    allow(PolyanetEditor).to receive(:remove)
  end

  describe '#draw_cross' do
    it 'calls PolyanetEditor.add with the correct parameters' do
      subject.draw_cross

      expect(PolyanetEditor).to have_received(:add).with(0, 0)
      expect(PolyanetEditor).to have_received(:add).with(1, 1)
    end
  end

  describe '#delete_cross' do
    it 'calls PolyanetEditor.remove with the correct parameters' do
      subject.delete_cross

      expect(PolyanetEditor).to have_received(:remove).with(0, 0)
      expect(PolyanetEditor).to have_received(:remove).with(1, 1)
    end
  end

  describe 'auxillary methods' do
    context 'smaller maps' do
      it 'does not apply padding to smaller maps' do
        expect(subject.megaverse_size).to eq(2)
        expect(subject.draw_start).to eq(0)
        expect(subject.draw_end).to eq(1)
      end
    end

    context 'bigger maps' do
      let(:map) do
        [
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE],
          %w[SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE SPACE]
        ]
      end

      it 'applies padding of 2 columns to bigger maps' do
        expect(subject.megaverse_size).to eq(10)
        expect(subject.draw_start).to eq(2)
        expect(subject.draw_end).to eq(7)
      end
    end
  end
end
