# frozen_string_literal: true

require "./test/test_helper"
require "byebug"

class StatisticTest < Minitest::Test
  def uri
    @uri ||= "https://rickandmortyapi.com/api/character"
  end

  def test_statistics_for_deaths
    status = "Dead"
    statistic = Statistic::StatisticByStatus.new(uri, status).statistic_by_status

    assert_equal 287, statistic[:total_by_status]
    assert_equal 107, statistic[:species]["Human"]
  end

  def test_statistics_for_alive
    status = "Alive"
    statistic = Statistic::StatisticByStatus.new(uri, status).statistic_by_status

    assert_equal 439, statistic[:total_by_status]
    assert_equal 211, statistic[:species]["Human"]
  end

  def test_statistics_for_unknown
    status = "unknown"
    statistic = Statistic::StatisticByStatus.new(uri, status).statistic_by_status

    assert_equal 100, statistic[:total_by_status]
    assert_equal 48, statistic[:species]["Human"]
  end
end
