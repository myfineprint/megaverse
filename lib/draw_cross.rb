# typed: strict

require 'json'
require 'net/http'
require 'sorbet-runtime'
require_relative 'services/megaverse'
require_relative 'services/editors/polyanet_editor'

class DrawCross
  extend T::Sig

  sig do
    params(draw_start: Integer, draw_end: Integer).void
  end
  def initialize(draw_start:, draw_end:)
    @megaverse = T.let(Megaverse.get_megaverse, T::Array[T::Array[String]])
    @draw_start = draw_start
    @draw_end = draw_end
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
