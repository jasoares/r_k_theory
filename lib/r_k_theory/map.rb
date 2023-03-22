require_relative 'map_manager'

module RKTheory
  class Map
    attr_reader :grid

    def initialize(grid)
      @grid = grid
      RKTheory::logger.info("Level size #{@grid.size}x#{@grid[0].size}")
      @loading = true
    end

    def render(window)
      return unless @loading
      window.setpos(0, 0)
      grid.each.with_index do |row, y|
        row.each.with_index do |tile, x|
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
      return grid[pos.y][pos.x].walkable?
    end

    def invalid?(pos)
      !valid?(pos)
    end
  end
end
