require_relative "statistics"

module PrintHistogram
  include Statistic
  STATUS = {
              "Dead" => ["deaths", "has died"],
              "Alive" => ["alive", "they are alive"],
              "unknown" => ["unknown", "they are unknown"]
            }

  def print_histogram(status)
    uri = "https://rickandmortyapi.com/api/character"
    statistics = StatisticsByStatus.new(uri, status).statistics_by_status
    data = ["\nRick and Morty #{STATUS[status].first} statistics:\n"]
    data << statistics_by_specie(statistics[:species])
    data << "\n\nTotal #{STATUS[status].first}: #{statistics[:total_by_status]}"
    data << "\nTotal characters: #{statistics[:total_characters]}"
    data << "\n#{statistics[:percentage_by_status]}% #{STATUS[status].last}\n\n"

    puts data.join
  end

  private

  def statistics_by_specie(statistics)
    statistics.map do | specie, total |
      "\n#{specie}: #{total}"
    end.join
  end
end