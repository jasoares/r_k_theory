# frozen_string_literal: true

require_relative 'position'

module RKTheory
  # Class that describes an abstract tile, used for subclassing other tiles
  class Tile
    require_relative 'tile/grass'
    require_relative 'tile/wall'
    require_relative 'tile/carrot'

    attr_reader :position

    def initialize(x, y)
      @position = Position.new(x, y)
    end

    def render(_window)
      raise "#{self.class.name} must implement Tile#render"
    end

    def walkable?
      raise "#{self.class.name} must implement Tile#walkable?"
    end
  end
end
