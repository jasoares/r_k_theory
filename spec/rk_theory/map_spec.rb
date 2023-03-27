# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module RKTheory
  RSpec.describe Map do
    level = <<~FILE
      GWGWGG
      GWGGGW
      GGBWWW
      WGWGWW
      WGGGGT
      WWWWWW
    FILE

    let(:grid) do
      [
        %w[G W G W G G],
        %w[G W G G G W],
        %w[G G B W W W],
        %w[W G W G W W],
        %w[W G G G G T],
        %w[W W W W W W]
      ]
    end
    let(:t) do
      { B: Tile::Grass, G: Tile::Grass, W: Tile::Wall, T: Tile::Carrot }
    end
    let(:tilemap) do
      m = instance_double(described_class)
      [
        # rubocop:disable Layout/LineLength
        [t[:G].new(0, 0, m), t[:W].new(0, 1, m), t[:G].new(0, 2, m), t[:W].new(0, 3, m), t[:G].new(0, 4, m), t[:G].new(0, 5, m)],
        [t[:G].new(1, 0, m), t[:W].new(1, 1, m), t[:G].new(1, 2, m), t[:G].new(1, 3, m), t[:G].new(1, 4, m), t[:W].new(1, 5, m)],
        [t[:G].new(2, 0, m), t[:G].new(2, 1, m), t[:B].new(2, 2, m), t[:W].new(2, 3, m), t[:W].new(2, 4, m), t[:W].new(2, 5, m)],
        [t[:W].new(3, 0, m), t[:G].new(3, 1, m), t[:W].new(3, 2, m), t[:G].new(3, 3, m), t[:W].new(3, 4, m), t[:W].new(3, 5, m)],
        [t[:W].new(4, 0, m), t[:G].new(4, 1, m), t[:G].new(4, 2, m), t[:G].new(4, 3, m), t[:G].new(4, 4, m), t[:T].new(4, 5, m)],
        [t[:W].new(5, 0, m), t[:W].new(5, 1, m), t[:W].new(5, 2, m), t[:W].new(5, 3, m), t[:W].new(5, 4, m), t[:W].new(5, 5, m)]
        # rubocop:enable Layout/LineLength
      ]
    end

    subject(:map) { described_class.new(grid) }

    describe '#tilemap' do
      context "with the following 2D grid \n#{level}" do
        it 'returns the expect 2D tilemap' do
          expect(map.tilemap).to eq(tilemap)
        end
      end
    end

    describe '#player' do
      context "with the following 2D grid \n#{level}" do
        it 'returns an instance of Bunny' do
          expect(map.player).to be_an_instance_of(Bunny)
        end

        it 'has a postion of (2, 2)' do
          expect(map.player.position).to eq(Position.new(2, 2))
        end
      end
    end

    describe '#valid?' do
      it 'returns true when given the valid Grass position (0, 0)' do
        expect(map.valid?(Position.new(0, 0))).to be true
      end

      it 'returns true when given the valid Wall position (5, 5)' do
        expect(map.valid?(Position.new(5, 5))).to be true
      end

      it 'returns false when given the invalid position (-1, 0)' do
        expect(map.valid?(Position.new(-1, 5))).to be false
      end

      it 'returns false when given the invalid position (5, 6)' do
        expect(map.valid?(Position.new(5, 6))).to be false
      end
    end

    describe '#valid_move?' do
      it 'returns false when given G(0, 0) and W(0, 1)' do
        expect(map.valid_move?(Position.new(0, 0), Position.new(0, 1))).to be false
      end

      it 'returns false when given W(0, 1) and G(0, 0)' do
        expect(map.valid_move?(Position.new(0, 1), Position.new(0, 0))).to be false
      end

      it 'returns false when given non neighbour positions (0, 0) (0, 2)' do
        expect(map.valid_move?(Position.new(0, 0), Position.new(0, 2))).to be false
      end

      it 'returns false when given non neighbour positions G(4, 4) G(0, 0)' do
        expect(map.valid_move?(Position.new(4, 4), Position.new(0, 0))).to be false
      end

      it 'returns true when given contiguous positions G(0, 2) G(1, 2)' do
        expect(map.valid_move?(Position.new(0, 2), Position.new(1, 2))).to be true
      end

      it 'returns true when given contiguous positions G(1, 2) G(1, 3)' do
        expect(map.valid_move?(Position.new(1, 2), Position.new(1, 3))).to be true
      end

      it 'returns false when given at least one of bounds position' do
        expect(map.valid_move?(Position.new(-1, 0), Position.new(0, 0))).to be false
      end

      it 'returns false when given countiguous out of bounds positions' do
        expect(map.valid_move?(Position.new(0, 5), Position.new(0, 6))).to be false
      end
    end

    describe '#walkable?' do
      it 'returns false when given an invalid position (-1, 0)' do
        expect(map.walkable?(Position.new(-1, 0))).to be false
      end

      it 'returns false when given an invalid position (0, 6)' do
        expect(map.walkable?(Position.new(0, 6))).to be false
      end

      it 'returns false when given an unwalkable position W(0, 1)' do
        expect(map.walkable?(Position.new(0, 1))).to be false
      end

      it 'returns true when given a walkable position G(4, 4)' do
        expect(map.walkable?(Position.new(4, 4))).to be true
      end

      it 'returns true when given a walkable position T(4, 5)' do
        expect(map.walkable?(Position.new(4, 5))).to be true
      end
    end

    describe '#[]' do
      it 'returns the row of the tilemap requested' do
        expect(map[2]).to eq(map.tilemap[2])
      end
    end

    describe '#neighbour_positions' do
      context 'when given the position (0, 0)' do
        let(:position) { Position.new(0, 0) }

        it 'returns the neighbour positions (1, 0) and (0, 1)' do
          expect(map.neighbour_positions(position)).to contain_exactly(Position.new(1, 0), Position.new(0, 1))
        end
      end

      context 'when given the position (2, 2)' do
        let(:position) { Position.new(2, 2) }

        it 'returns the neighbour positions (1, 2), (3, 2), (2, 1) and (2, 3)' do
          expect(map.neighbour_positions(position)).to contain_exactly(
            Position.new(1, 2), Position.new(3, 2), Position.new(2, 1), Position.new(2, 3)
          )
        end
      end
    end

    describe '::from_file' do
      context "with the file \n#{level}" do
        let(:filename) { 'test1' }
        let(:filepath) { "#{__dir__}/../../lib/rk_theory/maps/#{filename}.lvl" }

        before do
          File.open(filepath, 'w') { |f| level.each_line { |line| f.write line } }
        end

        after do
          File.delete(filepath)
        end

        it 'calls new with a 2D array matching the file content' do
          expect(described_class).to receive(:new).with(grid)
          described_class.from_file(filename)
        end
      end
    end
  end
end
# rubocop:enable Metrics/ModuleLength
