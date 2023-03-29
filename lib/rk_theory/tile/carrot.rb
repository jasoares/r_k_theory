# frozen_string_literal: true

module RKTheory
  class Tile
    # Class describing the carrot tile that serves as the goal of the game
    class Carrot < Tile
      MAP_CHAR = 'T'
      RENDER_CHAR = 'T'

      def render(window)
        window.attron(Curses.color_pair(4)) { window << RENDER_CHAR }
      end

      def walkable?
        true
      end
    end
  end
end
