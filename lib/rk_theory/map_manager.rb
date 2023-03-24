# frozen_string_literal: true

require_relative 'map'
require_relative 'position'
require_relative 'tile'

module RKTheory
  # Implements helpers to read and load level map files
  class MapManager
    PLAYER_CHAR = 'B'
    GOAL_CHAR = 'T'
    TILE_MAPPING = {
      'B' => Tile::Grass, # Player needs a walkable tile
      'G' => Tile::Grass,
      'W' => Tile::Wall,
      'T' => Tile::Carrot
    }.freeze

    attr_reader :player_position

    def initialize(level)
      @file_path = "#{__dir__}/maps/#{level}.lvl"
      @grid = File.open(@file_path).readlines.map.with_index do |line, row|
        line.chomp.chars.map.with_index do |char, col|
          @player_position = Position.new(row, col) if char == PLAYER_CHAR
          @goal_position = Position.new(row, col) if char == GOAL_CHAR
          TILE_MAPPING[char].new(row, col)
        end
      end
    end

    def map
      Map.new(@grid, @goal_position)
    end
  end
end
