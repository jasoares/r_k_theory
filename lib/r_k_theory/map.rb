# frozen_string_literal: true

require_relative 'map_manager'

module RKTheory
  # Implements a simple 2D map along with rendering and valid positioning logic
  class Map
    attr_reader :grid, :goal_position

    def initialize(grid, goal_position)
      @grid = grid
      @goal_position = goal_position
      @loading = true
    end

    def height
      @grid.size
    end

    def width
      @grid[0].size
    end

    def render(window)
      return unless @loading

      window.setpos(0, 0)
      grid.each do |row|
        row.each do |tile|
          tile.render(window)
          # Loading animation
          # if @loading
          #   window.refresh
          #   sleep 0.0001
          # end
        end
      end
      @loading = false
    end

    def valid?(pos)
      return false if pos.x < 0 || pos.y < 0

      return false if pos.x >= @grid[0].size || pos.y >= @grid.size

      grid[pos.y][pos.x].walkable?
    end

    def invalid?(pos)
      !valid?(pos)
    end
  end
end
