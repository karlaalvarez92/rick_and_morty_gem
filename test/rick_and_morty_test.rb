# frozen_string_literal: true

require "test_helper"

class RickAndMortyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RickAndMorty::VERSION
  end

  def test_it_prints_histogram_deaths
    data = <<~HEREDOC

                Rick and Morty deaths statistics:

                Human: 134
                Alien: 85
                Mythological Creature: 10
                Humanoid: 27
                Robot: 35
                Disease: 6
                Animal: 14
                Cronenberg: 1
                unknow: 2

                Total deaths: 287
                Total characters: 826
                34% has died

              HEREDOC

    assert_equal data, RickAndMorty::Histogram.new().deaths
  end
end
