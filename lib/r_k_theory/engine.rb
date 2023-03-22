# frozen_string_literal: true

require_relative 'bunny'
require_relative 'map'
require_relative 'position'
require_relative 'tile'

module RKTheory
  # Implements a simple game engine loop with hooks for game logic and rendering
  class Engine
    attr_reader :window

    def initialize
      grid = MapManager.load('level1')
      @screen_size_y = grid.size
      @screen_size_x = grid[0].size
      @map = Map.new(grid)
      @bunny = Bunny.new(3, 2)
      @screen = Curses.init_screen
      Curses.start_color
      Curses.curs_set(0)
      Curses.noecho
      Curses.cbreak
      @border = Curses::Window.new(@screen_size_y + 2, @screen_size_x + 2, 0, 1)
      @border.box('K', 'R')
      @border.refresh
      @window = Curses::Window.new(@screen_size_y, @screen_size_x, 1, 2)
      Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_GREEN)
      Curses.init_pair(2, Curses::COLOR_BLACK, Curses::COLOR_YELLOW)
      Curses.init_pair(3, Curses::COLOR_BLACK, Curses::COLOR_WHITE)
      Curses.init_pair(4, Curses::COLOR_GREEN, Curses::COLOR_RED)
    end

    def run
      last_step = (Time.now.to_f * 1000).to_i
      loop do
        curr_step = (Time.now.to_f * 1000).to_i
        sleep 0.05 unless curr_step - last_step > 1000 / 50

        last_step = (Time.now.to_f * 1000).to_i
        render(@window)
        tick
      end
    ensure
      Curses.close_screen
    end

    def tick
      @bunny.tick(@map)
    end

    def render(window)
      @map.render(window)
      @bunny.render(window)
      window.refresh
    end
  end
end
