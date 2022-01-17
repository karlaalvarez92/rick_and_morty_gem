# frozen_string_literal: true

require "./test/test_helper"

class RickAndMortyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RickAndMorty::VERSION
  end

  def test_it_prints_histogram_deaths
    status = "Dead"
    histogram = RickAndMorty::HistogramByStatus.new().print_histogram(status)
    title = "Rick and Morty deaths statistic:"
    statistic = <<~HEREDOC
                Total deaths: 287
                Total characters: 826
                34% has died

              HEREDOC


    assert_match statistic, histogram
    assert_match title, histogram
  end

  def test_it_prints_histogram_alive
    status = "Alive"
    histogram = RickAndMorty::HistogramByStatus.new().print_histogram(status)
    title = "Rick and Morty alive statistic:"
    statistic = <<~HEREDOC
                Total alive: 439
                Total characters: 826
                53% they are alive

              HEREDOC


    assert_match statistic, histogram
    assert_match title, histogram
  end

  def test_it_prints_histogram_unknown
    status = "unknown"
    histogram = RickAndMorty::HistogramByStatus.new().print_histogram(status)
    title = "Rick and Morty unknown statistic:"
    statistic = <<~HEREDOC
                  Total unknown: 100
                  Total characters: 826
                  12% they are unknown

              HEREDOC


    assert_match statistic, histogram
    assert_match title, histogram
  end
end
