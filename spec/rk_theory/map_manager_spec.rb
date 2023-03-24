# frozen_string_literal: true

module RKTheory
  RSpec.describe MapManager do
    describe '::new' do
      level = <<~FILE
        GWGWGG
        GWGGGW
        GGBWWW
        WGWGWW
        WGGGGT
        WWWWWW
      FILE

      context "with the file #{level}" do
        let(:filename) { 'test1' }
        let(:filepath) { "#{__dir__}/../../lib/rk_theory/maps/#{filename}.lvl" }
        let(:t) do
          { B: Tile::Grass, G: Tile::Grass, W: Tile::Wall, T: Tile::Carrot }
        end
        let(:grid) do
          [
            [t[:G].new(0, 0), t[:W].new(0, 1), t[:G].new(0, 2), t[:W].new(0, 3), t[:G].new(0, 4), t[:G].new(0, 5)],
            [t[:G].new(1, 0), t[:W].new(1, 1), t[:G].new(1, 2), t[:G].new(1, 3), t[:G].new(1, 4), t[:W].new(1, 5)],
            [t[:G].new(2, 0), t[:G].new(2, 1), t[:B].new(2, 2), t[:W].new(2, 3), t[:W].new(2, 4), t[:W].new(2, 5)],
            [t[:W].new(3, 0), t[:G].new(3, 1), t[:W].new(3, 2), t[:G].new(3, 3), t[:W].new(3, 4), t[:W].new(3, 5)],
            [t[:W].new(4, 0), t[:G].new(4, 1), t[:G].new(4, 2), t[:G].new(4, 3), t[:G].new(4, 4), t[:T].new(4, 5)],
            [t[:W].new(5, 0), t[:W].new(5, 1), t[:W].new(5, 2), t[:W].new(5, 3), t[:W].new(5, 4), t[:W].new(5, 5)]
          ]
        end

        before do
          File.open(filepath, 'w') { |f| level.each_line { |line| f.write line } }
        end

        after do
          File.delete(filepath)
        end

        it 'returns the expected grid' do
          described_class.new(filename).map.grid.each.with_index do |row, index|
            expect(row).to eq(grid[index])
          end
        end
      end
    end
  end
end
