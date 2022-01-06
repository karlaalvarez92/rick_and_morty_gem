# frozen_string_literal: true
require_relative "rick_and_morty/version"
require "byebug"
require_relative "print_histogram"

module RickAndMorty
  class Error < StandardError; end

  class HistogramByStatus
    include PrintHistogram
  end
end
