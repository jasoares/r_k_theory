# frozen_string_literal: true

module RKTheory
  class Tile
    # Class that describes the grass tile a clear path for walking
    class Grass < Tile
      MAP_CHAR = '_'
      RENDER_CHAR = '_'

      def render(window)
        window.attron(Curses.color_pair(1)) { window << RENDER_CHAR }
      end

      def walkable?
        true
      end
    end
  end
end
