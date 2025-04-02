# typed: strict

require 'sorbet-runtime'
require_relative 'services/megaverse'
require_relative 'services/editors/cometh_editor'
require_relative 'services/editors/polyanet_editor'
require_relative 'services/editors/soloon_editor'

class DrawLogo
  extend T::Sig

  sig { void }
  def initialize
    @megaverse = T.let(Megaverse.megaverse, T::Array[T::Array[String]])
  end

  sig { returns(T::Array[T::Array[String]]) }
  def generate_logo
    megaverse.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        case cell
        when 'POLYANET'
          PolyanetEditor.add(col_index, row_index)
        when /_COMETH/
          direction = T.must(cell.split('_').first).downcase

          ComethEditor.add(col_index, row_index, { 'direction' => direction })
        when /_SOLOON/
          color = T.must(cell.split('_').first).downcase

          SoloonEditor.add(col_index, row_index, { 'color' => color })
        end
      end
    end
  end

  private

  sig { returns(T::Array[T::Array[String]]) }
  attr_reader :megaverse
end
