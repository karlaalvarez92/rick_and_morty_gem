require_relative "statistic"

module PrintHistogram
  include Statistic
  STATUS = {
              "Dead" => ["deaths", "has died"],
              "Alive" => ["alive", "they are alive"],
              "unknown" => ["unknown", "they are unknown"]
            }

  def print_histogram(status)
    uri = "https://rickandmortyapi.com/api/character"
    statistic = StatisticByStatus.new(uri, status).statistic_by_status
    data = ["\nRick and Morty #{STATUS[status].first} statistic:\n"]
    data << statistic_by_specie(statistic[:species])
    data << "\n\nTotal #{STATUS[status].first}: #{statistic[:total_by_status]}"
    data << "\nTotal characters: #{statistic[:total_characters]}"
    data << "\n#{statistic[:percentage_by_status]}% #{STATUS[status].last}\n\n"

    data.join
  end

  private

  def statistic_by_specie(statistic)
    statistic.map do | specie, total |
      "\n#{specie}: #{total}"
    end.join
  end
end