# frozen_string_literal: true

module RKTheory
  RSpec.describe MapManager do
    describe '::new' do
      context 'given a file' do
        let(:filename) { 'test1' }
        before do
          file = <<~FILE
            GWGWGGWW
            GWGGGWWW
            GGBWWWGW
            WGWGWWGW
            WGGGGGGT
            WWWWWWWG
          FILE
          File.open("#{__dir__}/../lib/r_k_theory/maps/#{filename}.lvl", 'w') { |f| file.each_line { |line| f.write line } }
        end
        after do
          File.delete("#{__dir__}/../lib/r_k_theory/maps/#{filename}.lvl")
        end

        let(:tm) { { 'B' => Tile::Grass, 'G' => Tile::Grass, 'W' => Tile::Wall, 'T' => Tile::Carrot } }

        let(:grid) do
          [
            [tm['G'].new(0, 0), tm['W'].new(0, 1), tm['G'].new(0, 2), tm['W'].new(0, 3), tm['G'].new(0, 4), tm['G'].new(0, 5), tm['W'].new(0, 6), tm['W'].new(0, 7) ],
            [tm['G'].new(1, 0), tm['W'].new(1, 1), tm['G'].new(1, 2), tm['G'].new(1, 3), tm['G'].new(1, 4), tm['W'].new(1, 5), tm['W'].new(1, 6), tm['W'].new(1, 7) ],
            [tm['G'].new(2, 0), tm['G'].new(2, 1), tm['B'].new(2, 2), tm['W'].new(2, 3), tm['W'].new(2, 4), tm['W'].new(2, 5), tm['G'].new(2, 6), tm['W'].new(2, 7) ],
            [tm['W'].new(3, 0), tm['G'].new(3, 1), tm['W'].new(3, 2), tm['G'].new(3, 3), tm['W'].new(3, 4), tm['W'].new(3, 5), tm['G'].new(3, 6), tm['W'].new(3, 7) ],
            [tm['W'].new(4, 0), tm['G'].new(4, 1), tm['G'].new(4, 2), tm['G'].new(4, 3), tm['G'].new(4, 4), tm['G'].new(4, 5), tm['G'].new(4, 6), tm['T'].new(4, 7) ],
            [tm['W'].new(5, 0), tm['W'].new(5, 1), tm['W'].new(5, 2), tm['W'].new(5, 3), tm['W'].new(5, 4), tm['W'].new(5, 5), tm['W'].new(5, 6), tm['G'].new(5, 7) ]
          ]
        end

        it 'returns the expected grid' do
          MapManager.new(filename).map.grid.each.with_index do |row, index|
            expect(row).to eq(grid[index])
          end
        end
      end
    end
  end
end
