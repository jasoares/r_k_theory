# frozen_string_literal: true

module RKTheory
  # Describes a position on the map with x and y coordinates
  class Position
    attr_reader :row, :col

    def initialize(row, col)
      @row = row
      @col = col
    end

    def hash
      [row, col].hash
    end

    def ==(other)
      self.class == other.class && [row, col] == [other.row, other.col]
    end
    alias_method :eql?, :==

    def up
      self.class.new(row - 1, col)
    end

    def down
      self.class.new(row + 1, col)
    end

    def left
      self.class.new(row, col - 1)
    end

    def right
      self.class.new(row, col + 1)
    end

    def to_s
      "(#{row}, #{col})"
    end
    alias_method :inspect, :to_s
  end
end
