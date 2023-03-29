# frozen_string_literal: true

module RKTheory
  class Tile
    # Class that describes the wall tile an obstacle for walking
    class Wall < Tile
      MAP_CHAR = 'X'
      RENDER_CHAR = 'X'

      def render(window)
        window.attron(Curses.color_pair(2)) { window << RENDER_CHAR }
      end

      def walkable?
        false
      end
    end
  end
end
