# frozen_string_literal: true

require_relative 'path_finding'

module RKTheory
  # Class describing the player
  class Bunny
    MAP_CHAR = 'B'
    RENDER_CHAR = '@'

    attr_reader :position, :strategy

    def initialize(position, map, strategy=PathFinding::FloodFill)
      @loading = true
      @position = position
      @search_position
      @map = map
      @algorithm = strategy
      @prev_position = @position
      @invalid_positions = []
      @ate = false
    end

    def path_found?
      @strategy.path_found
    end

    def ate?
      !!@ate
    end

    def iterate_search
      @strategy ||= @algorithm.new(@position, @map)
      @search_position = @strategy.iterate_search
    end

    def render_path_finding(window)
      return unless @search_position

      window.setpos(@search_position.row, @search_position.col)
      if @algorithm == PathFinding::Dijkstra
        window.attron(Curses.color_pair(5)) { window << (@strategy.cost_to_reach[@search_position] % 10).to_s }
      else
        window.attron(Curses.color_pair(4)) { window << '*' }
      end
    end

    def iterate_move
      new_position = @strategy.next_position(@position)
      if @map.valid_move?(@position, new_position)
        @prev_position = @position
        @position = new_position
        @ate = @position == @map.goal.position
      else
        RKTheory.logger.warn "Invalid position returned by strategy #{new_position} for #{@position}"
        @invalid_positions << new_position
        RKTheory.logger.warn "Invalid positions so far #{@invalid_positions}"
      end
    end

    def render_path_walking(window)
      window.setpos(@prev_position.row, @prev_position.col)
      window.attron(Curses.color_pair(5)) { window << @map[@prev_position.row][@prev_position.col].char }
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
    end

    def render_invalid_positions(window)
      @invalid_positions.each do |pos|
        window.setpos(pos.row, pos.col)
        window.attron(Curses.color_pair(4)) { window << '@' }
      end
    end
  end
end
