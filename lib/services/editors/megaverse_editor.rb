# typed: strict

require 'json'
require 'net/http'
require 'dotenv/load'
require 'sorbet-runtime'
require_relative '../megaverse'

class MegaverseEditor
  extend T::Sig

  CANDIDATE_ID = T.let(ENV.fetch('CANDIDATE_ID'), String)

  sig do
    params(
      column: Integer,
      row: Integer,
      extra_params: T::Hash[String, String]
    ).returns(Net::HTTPResponse)
  end
  def self.add(column, row, extra_params = {})
    params = build_params(column, row, extra_params)

    post(params)
  end

  sig do
    params(column: Integer, row: Integer).returns(T.nilable(Net::HTTPResponse))
  end
  def self.remove(column, row)
    params = build_params(column, row)

    delete(params)
  end

  sig { returns(String) }
  def self.api
    raise NotImplementedError, 'Subclasses must define their own API endpoint'
  end

  sig do
    params(params: T::Hash[String, T.any(Integer, String)]).returns(
      Net::HTTPResponse
    )
  end
  def self.post(params)
    uri = URI.parse(api)

    Net::HTTP.post_form(uri, params)
  end

  sig do
    params(params: T::Hash[String, T.any(Integer, String)]).returns(
      T.nilable(Net::HTTPResponse)
    )
  end
  def self.delete(params)
    uri = URI(api)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    headers = { 'Content-Type' => 'application/json' }

    request = Net::HTTP::Delete.new(uri, headers)
    request.set_form_data(params)

    begin
      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        response
      else
        puts("Error: #{response.code} #{response.message}")
      end
    end
  end

  sig do
    params(
      column: Integer,
      row: Integer,
      extra_params: T::Hash[String, String]
    ).returns(T::Hash[String, T.any(Integer, String)])
  end
  def self.build_params(column, row, extra_params = {})
    { 'column' => column, 'row' => row, 'candidateId' => CANDIDATE_ID }.merge(
      extra_params
    )
  end

  private_class_method :api, :post, :delete, :build_params
end
