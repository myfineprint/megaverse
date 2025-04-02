# typed: strict

require 'sorbet-runtime'
require_relative 'services/megaverse'
require_relative 'services/editors/polyanet_editor'

class DrawCross
  extend T::Sig

  sig { void }
  def initialize
    @megaverse = T.let(Megaverse.map, T::Array[T::Array[String]])
    @draw_start = T.let(megaverse_size - (megaverse_size - 2), Integer)
    @draw_end = T.let(megaverse_size - 2, Integer)
  end

  sig { returns(T::Range[Integer]) }
  def draw_cross
    (draw_start..draw_end).each do |pos|
      PolyanetEditor.add(pos, pos)
      PolyanetEditor.add(pos, megaverse_size - 1 - pos)
    end
  end

  sig { returns(T::Range[Integer]) }
  def delete_cross
    (draw_start..draw_end).each do |pos|
      PolyanetEditor.remove(pos, pos)
      PolyanetEditor.remove(pos, megaverse_size - 1 - pos)
    end
  end

  private

  sig { returns(Integer) }
  def megaverse_size
    @megaverse_size ||= T.let(megaverse.size, T.nilable(Integer))
  end

  sig { returns(T::Array[T::Array[String]]) }
  attr_reader :megaverse

  sig { returns(Integer) }
  attr_reader :draw_start

  sig { returns(Integer) }
  attr_reader :draw_end
end
