# frozen_string_literal: true

module RKTheory
  class Tile
    # Class that describes the wall tile an obstacle for walking
    class Wall < Tile
      CHAR = 'W'

      def render(window)
        window.attron(Curses.color_pair(2)) { window << 'W' }
      end

      def walkable?
        false
      end
    end
  end
end
