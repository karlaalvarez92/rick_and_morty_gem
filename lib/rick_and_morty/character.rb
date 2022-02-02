# frozen_string_literal: true

module RickAndMorty
  class Character
    def initialize
      @client = Client.new
    end

    def all
      (1..info["pages"]).map do |page|
        Thread.new { list(page: page) }
      end.map(&:value)
    end

    def list(page: nil)
      client.get(path, page: page)["results"]
    end

    def find(id)
      client.get("#{path}/#{id}")["results"]
    end

    def info
      @info ||= client.get(path)["info"]
    end

    def total_count
      info["count"]
    end

    private

    attr_reader :client

    def path
      "/api/characters"
    end
  end
end