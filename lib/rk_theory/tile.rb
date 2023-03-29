# frozen_string_literal: true

require_relative 'position'
require_relative 'tile/grass'
require_relative 'tile/forest'
require_relative 'tile/wall'
require_relative 'tile/carrot'

module RKTheory
  # Class that describes an abstract tile, used for subclassing other tiles
  class Tile
    TYPES = {
      'B' => Tile::Grass,
      '_' => Tile::Grass,
      ';' => Tile::Forest,
      'X' => Tile::Wall,
      'T' => Tile::Carrot
    }.freeze

    class << self
      def from_char(row, col, map, char)
        TYPES[char].new(row, col, map)
      end
    end

    attr_reader :position, :cost

    def initialize(row, col, map, cost=1)
      @map = map
      @position = Position.new(row, col)
      @cost = cost
    end

    def char
      self.class::RENDER_CHAR
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

    def hash
      [position, self.class].hash
    end

    def to_s
      "#<#{self.class}:#{(object_id << 1).to_s(16)} char=#{char} @position=#{position.inspect} walkable=#{walkable?}"
    end
    alias inspect to_s
  end
end
