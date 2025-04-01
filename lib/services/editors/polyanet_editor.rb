# typed: strict

require_relative 'megaverse_editor'

class PolyanetEditor < MegaverseEditor

  sig { returns(String) }
  def self.api
    "#{ENV.fetch('BASE_URL')}/polyanets"
  end

  private_class_method :api 
end
