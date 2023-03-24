# frozen_string_literal: true

module RKTheory
  class PathFinding
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
  end
end

require_relative 'path_finding/random'