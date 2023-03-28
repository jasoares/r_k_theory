# frozen_string_literal: true

module RKTheory
  # Implements boilerplate code for multiple path finding algorithms and strategies
  class PathFinding
    DIRECTIONS4 = %w[up down left right].freeze
    DIRECTIONS8 = %w[up up_right right down_right down down_left left up_left].freeze

    attr_reader :path, :path_found

    def initialize(origin, map)
      @origin = origin
      @map = map
      @path_found = false
    end

    def next_position(current_position)
      raise 'Must implement #next_position for any PathFinding algorithm' unless block_given?

      yield
    end

    def neighbours(position)
      @map.neighbour_positions(position).select do |neighbour|
        @map.valid_move?(position, neighbour)
      end
    end
  end
end

require_relative 'path_finding/random'
require_relative 'path_finding/flood_fill'
require_relative 'priority_queue'
require_relative 'path_finding/dijkstra'
