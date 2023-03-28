# frozen_string_literal: true

module RKTheory
  class Tile
    # Class that describes the grass tile a clear path for walking
    class Grass < Tile
      MAP_CHAR = 'G'
      RENDER_CHAR = '.'

      def render(window)
        window.attron(Curses.color_pair(1)) { window << '.' }
      end

      def walkable?
        true
      end
    end
  end
end
