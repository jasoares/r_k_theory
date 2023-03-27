# frozen_string_literal: true

require_relative 'path_finding'

module RKTheory
  # Class describing the player
  class Bunny
    CHAR = 'B'

    attr_reader :position, :strategy

    def initialize(row, col, map, strategy=PathFinding::FloodFill)
      @loading = true
      @position = Position.new(row, col)
      @map = map
      @strategy = strategy.new(@position, @map)
      @old_position = @position
      @invalid_positions = []
      @ate = false
    end

    def ate?
      !!@ate
    end

    def tick
      new_position = @strategy.next_position
      if @map.valid_move?(@position, new_position)
        @old_position = @position
        @position = new_position
        @ate = @position == @map.goal.position
      else
        return if new_position.nil?

        @invalid_positions << new_position
      end
    end

    def render(window)
      window.setpos(@old_position.row, @old_position.col)
      window.attron(Curses.color_pair(5)) { window << '.' }
      # window.attron(Curses.color_pair(5)) { window << "#{(@strategy.path.size % 10)}" } # debug path
      window.setpos(@position.row, @position.col)
      window.attron(Curses.color_pair(3)) { window << '@' }
      render_invalid_positions(window)
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
      @strategy.render_find_path(window) unless @strategy.path_found
    end

    def render_invalid_positions(window)
      @invalid_positions.each do |pos|
        window.setpos(pos.row, pos.col)
        window.attron(Curses.color_pair(4)) { window << '@' }
      end
    end
  end
end
