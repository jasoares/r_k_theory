module RKTheory
  class Tile
    class Wall < Tile
      def render(window)
        window.attron(color_pair(2)) { window << 'W' }
      end

      def walkable?
        false
      end
    end
  end
end
