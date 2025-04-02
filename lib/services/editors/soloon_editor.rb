# typed: strict

require_relative 'megaverse_editor'

class SoloonEditor < MegaverseEditor
  sig do
    params(
      column: Integer,
      row: Integer,
      extra_params: T::Hash[String, String]
    ).returns(Net::HTTPResponse)
  end
  def self.add(column, row, extra_params = {})
    color = extra_params.fetch('color', nil)

    raise NotImplementedError if color.nil?

    super(column, row, { 'color' => color })
  end

  sig { returns(String) }
  def self.api
    "#{ENV.fetch('BASE_URL')}/soloons"
  end

  private_class_method :api
end
