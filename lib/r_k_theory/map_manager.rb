# frozen_string_literal: true

require_relative 'map'
require_relative 'tile'

module RKTheory
  # Implements helpers to read and load level map files
  class MapManager
    def self.load(level)
      file = File.open("#{__dir__}/maps/#{level}.lvl")
      grid = file.readlines.map.with_index do |line, row|
        line.chomp.chars.map.with_index do |char, col|
          Tile::TYPES[char].new(row, col)
        end
      end
      Map.new(grid)
    end
  end
end
