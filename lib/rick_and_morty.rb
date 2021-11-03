# frozen_string_literal: true

require_relative "rick_and_morty/version"
require 'net/http'
require 'json'

module RickAndMorty
  class Error < StandardError; end

  class Histogram
    def initialize
      @base_uri = "https://rickandmortyapi.com/api/character"
      @species = %w(Human Alien Mythological\ Creature Humanoid Robot Disease Animal Cronenberg unknow)
    end

    def deaths
      data = ["\nRick and Morty deaths statistics:\n"]
      @species.each do |specie|
        specie_data = get_data(@base_uri+"?species=#{specie}&status=dead")
        specie_deaths = count_characters(specie_data)
        data << "\n#{specie}: #{specie_deaths}"
      end

      total_deaths = count_characters(get_data(@base_uri+"?status=dead"))
      total_characters = count_characters(get_data(@base_uri))
      data << "\n\nTotal deaths: #{total_deaths}"
      data << "\nTotal characters: #{total_characters}"
      data << "\n#{percentage(total_characters, total_deaths)}% has died\n\n"

      data = data.join

      print_histogram(data)
      data


    end

    private

    def print_histogram(data)
      puts data
    end

    def get_data(uri)
      uri = URI(uri)
      request = Net::HTTP.get(uri)
      JSON.parse(request)
    end

    def percentage(total, part)
      (part*100)/total
    end

    def count_characters(data)
      data["info"]["count"]
    end
  end
end
