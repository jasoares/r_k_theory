# frozen_string_literal: true

module RKTheory
  # Describes a position on the map with x and y coordinates
  class Position
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def to_s
      "(#{x}, #{y})\n"
    end
  end
end
