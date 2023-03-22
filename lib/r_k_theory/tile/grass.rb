module RKTheory
  class Tile
    class Grass < Tile
      def render(window)
        window.attron(color_pair(1)) { window << '.' }
      end

      def walkable?
        true
      end
    end
  end
end
