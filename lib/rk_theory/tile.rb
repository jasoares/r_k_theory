# frozen_string_literal: true

require_relative 'position'

module RKTheory
  # Class that describes an abstract tile, used for subclassing other tiles
  class Tile
    attr_reader :position

    def initialize(row, col)
      @position = Position.new(row, col)
    end

    def render(_window)
      raise "#{self.class.name} must implement Tile#render"
    end

    def walkable?
      raise "#{self.class.name} must implement Tile#walkable?"
    end

    def ==(other)
      self.class == other.class && position == other.position
    end
    alias eql? ==
  end
end

require_relative 'tile/grass'
require_relative 'tile/wall'
require_relative 'tile/carrot'
