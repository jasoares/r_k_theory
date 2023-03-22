# frozen_string_literal: true
module RKTheory
  class Position
    attr_reader :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def to_s
      return "(#{x}, #{y})\n"
    end
  end
end
