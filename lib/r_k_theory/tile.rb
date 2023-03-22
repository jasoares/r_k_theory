require_relative 'position'

module RKTheory
  class Tile
    require_relative 'tile/grass'
    require_relative 'tile/wall'
    require_relative 'tile/carrot'

    TYPES = { 'G' => Grass, 'W' => Wall, 'T' => Carrot }

    attr_reader :position

    def initialize(x, y)
      @position = Position.new(x, y)
    end

    def render(window)
      raise "#{self.class.name} must implement Tile#render"
    end

    def walkable?
      raise "#{self.class.name} must implement Tile#walkable?"
    end
  end
end
