# frozen_string_literal: true

require_relative "rick_and_morty/version"
require "net/http"
require "json"

module RickAndMorty
  class Error < StandardError; end

  # Class for create Histograms
  class Histogram
    def initialize
      @base_uri = "https://rickandmortyapi.com/api/character"
      @total_characters = count_characters(get_data(@base_uri))

      @count_by_specie = {}
      @index = 1
    end

    def deaths
      uri = "#{@base_uri}?status=dead"
      iterate_pagination(uri)

      data = ["\nRick and Morty deaths statistics:\n"]
      data << specie_histogram
      total_deaths = count_characters(get_data(uri))
      data << "\n\nTotal deaths: #{total_deaths}"
      data << "\nTotal characters: #{@total_characters}"
      data << "\n#{percentage(@total_characters, total_deaths)}% has died\n\n"

      print_histogram(data.join)
    end

    private

    def get_data(uri)
      uri = URI(uri)
      request = Net::HTTP.get(uri)
      JSON.parse(request)
    end

    def count_characters(data)
      data["info"]["count"]
    end

    def iterate_pagination(uri)
      bunch_data = get_data(uri)
      pages = bunch_data["info"]["pages"]

      while @index <= pages
        count_deaths_by_specie(bunch_data["results"])
        bunch_data = get_data(bunch_data["info"]["next"]) unless @index >= pages
        @index += 1
      end
      @index = 1
    end

    def count_deaths_by_specie(data)
      data.each do |character|
        @count_by_specie[character["species"]] = 0 unless @count_by_specie.key?(character["species"])
        @count_by_specie[character["species"]] += 1
      end
    end

    def specie_histogram
      data = []
      @count_by_specie.each do |specie, quantity|
        data << "\n#{specie}: #{quantity}"
      end
      data
    end

    def percentage(total, part)
      (part * 100) / total
    end

    def print_histogram(data)
      puts data
    end
  end
end
