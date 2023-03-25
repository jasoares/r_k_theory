# frozen_string_literal: true

module RKTheory
  # Implements boilerplate code for multiple path finding algorithms and strategies
  class PathFinding
    DIRECTIONS4 = %w[up down left right]

    attr_reader :path

    def initialize(origin, map)
      @origin = origin
      @current_position = @origin
      @map = map
      @path = [@current_position]
    end

    def next_position
      raise 'Must implement #next_position for any PathFinding algorithm' unless block_given?

      position = yield
      @path |= [position]
      @current_position = position
    end

    def valid_options
      DIRECTIONS4.map(&:to_sym).each_with_object({}) do |option, options|
        option_position = @current_position.send(option)
        options[option] = option_position if @map.valid?(option_position)
      end
    end
  end
end

require_relative 'path_finding/random'
