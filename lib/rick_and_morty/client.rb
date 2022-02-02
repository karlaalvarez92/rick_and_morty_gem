# frozen_string_literal: true

require "net/http"
require "json"

module RickAndMorty
  class Client
    def initialize(base_url: "https://rickandmortyapi.com")
      @base_url = base_url
    end
  
    def get(path, **query_items)
      uri = URI.join(base_url, path)
      query_items.compact!
      uri.query = URI.encode_www_form(query_items.compact) unless query_items.empty?
      request = Net::HTTP.get_response(uri)
      JSON.parse(request.body) if request.code == "200"
    end

    private

    attr_reader :base_url
  end  
end
