# frozen_string_literal: true

module RKTheory
  class Tile
    # Class that describes the grass tile a clear path for walking
    class Forest < Tile
      MAP_CHAR = 'F'
      RENDER_CHAR = ';'

      def initialize(row, col, map, cost=4)
        super
      end

      def render(window)
        window.attron(Curses.color_pair(1)) { window << ';' }
      end

      def walkable?
        true
      end
    end
  end
end
