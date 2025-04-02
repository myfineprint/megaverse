# typed: strict

require 'json'
require 'net/http'
require 'dotenv/load'
require 'sorbet-runtime'

class Megaverse
  extend T::Sig

  CANDIDATE_ID = T.let(ENV.fetch('CANDIDATE_ID'), String)
  API_URL =
    T.let("#{ENV.fetch('BASE_URL')}/map/#{CANDIDATE_ID}/goal".freeze, String)

  sig { returns(T::Array[T::Array[String]]) }
  def self.megaverse
    fetch_megaverse
  end

  sig { returns(T::Array[T::Array[String]]) }
  def self.fetch_megaverse
    uri = URI.parse(API_URL)

    goal_matrix = Net::HTTP.get(uri)

    JSON.parse(goal_matrix)['goal']
  end

  private_class_method :fetch_megaverse
end
