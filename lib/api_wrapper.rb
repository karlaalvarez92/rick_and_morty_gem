require_relative "client"

module ApiWrapper
  include Client

  def all_characters(uri)
    pages = get(uri)["info"]["pages"]
    data = []

    (1..pages).map do | page |
      Thread.new do
        current_uri = uri + "?page=#{page}"
        data << get(current_uri)["results"]
      end
    end.map(&:join)

    data.flatten
  end
end
