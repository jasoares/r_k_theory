# frozen_string_literal: true

require_relative 'position'
require_relative 'tile'

module RKTheory
  # Implements a simple 2D map along with rendering and valid positioning logic
  class Map
    class << self
      def from_file(filename)
        file_path = "#{__dir__}/maps/#{filename}.lvl"
        grid = File.open(file_path).readlines.map do |line|
          line.chomp.chars.map do |char|
            char
          end
        end
        new(grid)
      end
    end

    attr_reader :tilemap, :player

    def initialize(grid)
      @tilemap = grid.map.with_index do |chars, row|
        chars.map.with_index do |char, col|
          if char == Bunny::CHAR
            @player = Bunny.new(row, col, self)
            char = Tile::Grass::CHAR
          end
          Tile.from_char(row, col, self, char)
        end
      end
      @loading = true
    end

    def goal
      @goal ||= @tilemap.flatten.find { |tile| tile.instance_of?(Tile::Carrot) }
    end

    def height
      @tilemap.size
    end

    def width
      @tilemap[0].size
    end

    def render(window)
      return unless @loading

      window.setpos(0, 0)
      tilemap.each do |row|
        row.each do |tile|
          tile.render(window)
          # Loading animation
          # if @loading
          #   window.refresh
          #   sleep 0.0001
          # end
          # @loading = false
        end
      end
    end

    def to_s
      grid = tilemap.map do |line|
        line.map(&:char).join
      end.join("\n")
      "#<#{self.class}:#{(object_id << 1).to_s(16)} @tilemap=\n#{grid}\n"
    end
    alias inspect to_s

    def valid?(pos)
      return false if pos.row < 0 || pos.col < 0
      return false if pos.row >= @tilemap.size || pos.col >= @tilemap[0].size

      true
    end

    def valid_move?(from_pos, to_pos)
      neighbour_positions(from_pos).include?(to_pos) && [from_pos, to_pos].all? { |pos| walkable?(pos) }
    end

    def walkable?(pos)
      valid?(pos) && tilemap[pos.row][pos.col].walkable?
    end

    def [](row)
      @tilemap[row]
    end

    def neighbour_positions(pos)
      PathFinding::DIRECTIONS4.map { |dir| pos.send(dir) }.select { |new_pos| valid?(new_pos) }
    end
  end
end
