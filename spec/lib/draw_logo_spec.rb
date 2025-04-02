# typed: false

require 'spec_helper'
require_relative '../../lib/draw_logo'

RSpec.describe DrawLogo do
  let(:map) do
    [
      %w[SPACE POLYANET SPACE],
      %w[UP_COMETH BLUE_SOLOON RIGHT_COMETH],
      %w[SPACE SPACE POLYANET]
    ]
  end

  subject { described_class.new }

  before do
    allow(Megaverse).to receive(:map).and_return(map)

    allow(PolyanetEditor).to receive(:add)
    allow(ComethEditor).to receive(:add)
    allow(SoloonEditor).to receive(:add)
  end

  describe '#generate_logo' do
    it 'calls the correct editors with expected parameters' do
      subject.generate_logo

      expect(PolyanetEditor).to have_received(:add).with(1, 0)
      expect(PolyanetEditor).to have_received(:add).with(2, 2)

      expect(ComethEditor).to have_received(:add).with(
        0,
        1,
        { 'direction' => 'up' }
      )
      expect(ComethEditor).to have_received(:add).with(
        2,
        1,
        { 'direction' => 'right' }
      )

      expect(SoloonEditor).to have_received(:add).with(
        1,
        1,
        { 'color' => 'blue' }
      )
    end
  end
end
