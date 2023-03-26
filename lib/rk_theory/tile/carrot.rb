# frozen_string_literal: true

module RKTheory
  class Tile
    # Class describing the carrot tile that serves as the goal of the game
    class Carrot < Tile
      CHAR = 'T'

      def render(window)
        window.attron(Curses.color_pair(4)) { window << 'T' }
      end

      def walkable?
        true
      end
    end
  end
end
