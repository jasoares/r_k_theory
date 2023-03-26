# frozen_string_literal: true

require_relative 'path_finding'

module RKTheory
  # Class describing the player
  class Bunny
    CHAR = 'B'

    attr_reader :position

    def initialize(row, col, map)
      @loading = true
      @position = Position.new(row, col)
      @map = map
      @strategy = PathFinding::Random.new(@position, @map)
      @old_position = @position
      @ate = false
    end

    def ate?
      !!@ate
    end

    def tick
      @old_position = @position
      @position = @strategy.next_position
      @ate = @position == @map.goal.position
    end

    def render(window)
      window.setpos(@old_position.row, @old_position.col)
      window.attron(Curses.color_pair(5)) { window << '.' }
      # window.attron(Curses.color_pair(5)) { window << "#{(@strategy.path.size % 10)}" } # debug path
      window.setpos(@position.row, @position.col)
      window.attron(Curses.color_pair(3)) { window << '@' }
      # Loading animation
      # 5.times do
      #   window.refresh
      #   sleep 0.3

      #   window << "\b@"
      #   window.refresh
      #   sleep 0.3
      #   window.attron(Curses.color_pair(3)) { window << "\b@" }
      # end if @loading
      @loading = false
    end
  end
end
