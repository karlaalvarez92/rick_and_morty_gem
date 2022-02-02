module RickAndMorty
  class CharacterStats
    def initialize(character_list = [])
      @character_list = character_list
    end

    # Challenge: meta program all percentage methods
    def death_percentage(race: nil)
      if race
        # calc percenctage per race
      else
        # calc total percentage
      end
    end
  
    def alive_percentage(race: nil)
      if race
        # calc percenctage per race
      else
        # calc total percentage
      end
    end

    def unkonw_percentage(race: nil)
      if race
        # calc percenctage per race
      else
        # calc total percentage
      end
    end

    def total
      @total ||= data.sum { |x| x[:total] }
    end

    def data
      @data = calc_data
    end

    private

    attr_reader :data

    # TODO: Implement the following method
    def calc_data
      {
        humans: { total: 0, alive: 0, death: 0, unknown: 0 },
        aliens: { total: 0, alive: 0, death: 0, unknown: 0 },
        # ...
        unknown: { total: 0, alive: 0, death: 0, unknown: 0 }
      }
    end
  end
end