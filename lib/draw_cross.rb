# typed: strict

require 'sorbet-runtime'
require_relative 'services/megaverse'
require_relative 'services/editors/polyanet_editor'

class DrawCross
  extend T::Sig

  sig { void }
  def initialize
    @megaverse = T.let(Megaverse.map, T::Array[T::Array[String]])
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

  sig { returns(Integer) }
  def draw_start
    megaverse_size > 4 ? 2 : 0
  end

  sig { returns(Integer) }
  def draw_end
    megaverse_size > 4 ? megaverse_size - 3 : megaverse_size - 1
  end

  sig { returns(Integer) }
  def megaverse_size
    @megaverse_size ||= T.let(megaverse.size, T.nilable(Integer))
  end

  sig { returns(T::Array[T::Array[String]]) }
  attr_reader :megaverse
end

if __FILE__ == $PROGRAM_NAME
  cross = DrawCross.new
  cross.draw_cross
  puts 'Cross generated!'
end
