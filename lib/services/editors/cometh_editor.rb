# typed: strict

require_relative 'megaverse_editor'

class ComethEditor < MegaverseEditor
  sig do
    params(
      column: Integer,
      row: Integer,
      extra_params: T::Hash[String, String]
    ).returns(T.nilable(Net::HTTPResponse))
  end
  def self.add(column, row, extra_params = {})
    direction = extra_params.fetch('direction', nil)

    raise ArgumentError, "'direction' is a required parameter" if direction.nil?

    super(column, row, { 'direction' => direction })
  end

  sig { returns(String) }
  def self.api
    "#{ENV.fetch('BASE_URL')}/comeths"
  end

  private_class_method :api
end
