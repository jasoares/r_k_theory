require_relative 'tile'

module RKTheory
  class Map
    attr_reader :grid

    def initialize(level)
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      @loading = true
      rows = level.size
      cols = level[0].size
      logger.info("Level size #{rows}x#{cols}")
      logger.info("Environment: #{ENV.inspect}")
      r = 0
      @grid = Array.new(rows) do |row|
        c = 0
        row = Array.new(cols) do |col|
          tile = RKTheory::Tile::TYPES[level[r][c]].new(r, c)
          c = c + 1
          tile
        end
        r += 1
        row
      end
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
