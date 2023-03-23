# frozen_string_literal: true

require 'curses'

module RKTheory
  # Implements the curses interface with the terminal
  class Terminal
    include Curses

    attr_reader :window

    def initialize(screen_height, screen_width)
      @screen_width = screen_width
      @screen_height = screen_height
      @screen = init_screen
      @window = Window.new(@screen_height, @screen_width, 1, 2)
      start_color
      curs_set(0)
      noecho
      cbreak
      init_border
      init_colors
    end

    def init_border
      @border = Window.new(@screen_height + 2, @screen_width + 2, 0, 1)
      @border.box('K', 'R')
      @border.refresh
    end

    def init_colors
      init_pair(1, COLOR_WHITE, COLOR_GREEN)
      init_pair(2, COLOR_BLACK, COLOR_YELLOW)
      init_pair(3, COLOR_BLACK, COLOR_WHITE)
      init_pair(4, COLOR_GREEN, COLOR_RED)
    end

    def render
      yield(@window)
      @window.refresh
    end

    def close
      close_screen
    end
  end
end
