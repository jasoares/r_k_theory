require_relative 'bunny'
require_relative 'map'
require_relative 'position'
require_relative 'tile'

module RKTheory
  class Engine
    attr_reader :window

    def initialize
      @screen_size_y = RKTheory::LEVEL1.size
      @screen_size_x = RKTheory::LEVEL1[0].size
      @map = Map.new(RKTheory::LEVEL1)
      @bunny = Bunny.new(3, 2)
      @screen = init_screen
      start_color
      curs_set(0)
      noecho
      cbreak
      @border = Curses::Window.new(@screen_size_y + 2, @screen_size_x + 2, 0, 1)
      @border.box("K", "R")
      @border.refresh
      @window = Curses::Window.new(@screen_size_y, @screen_size_x, 1, 2)
      init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_GREEN)
      init_pair(2, Curses::COLOR_BLACK, Curses::COLOR_YELLOW)
      init_pair(3, Curses::COLOR_BLACK, Curses::COLOR_WHITE)
    end

    def run
      last_step = (Time.now.to_f * 1000).to_i
      loop do
        curr_step = (Time.now.to_f * 1000).to_i
        if ((Time.now.to_f * 1000).to_i - last_step) > 1000 / 50
          last_step = (Time.now.to_f * 1000).to_i
          render(@window)
          tick
        else
          sleep 0.05
        end
      end
    ensure
      close_screen
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
