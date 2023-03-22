module RKTheory
  class Tile
    class Carrot < Tile
      def render(window)
        window.attron(color_pair(4)) { window << 'T' }
      end

      def walkable?
        true
      end
    end
  end
end
