# frozen_string_literal: true

module RKTheory
  RSpec.describe Tile do
    let(:tile) { Tile::Grass.new(2, 1) }

    describe '#position' do
      subject { tile.position }
      it { is_expected.to eq(Position.new(2, 1)) }
    end

    describe '#walkable?' do
      it 'returns true for grass' do
        expect(tile.walkable?).to be true
      end

      it 'returns false for wall' do
        expect(Tile::Wall.new(1, 2).walkable?).to be false
      end

      it 'returns true for carrot' do
        expect(Tile::Carrot.new(1, 2).walkable?).to be true
      end
    end

    describe '#==' do
      context 'given two tiles of the same type' do
        let(:grass1) { Tile::Grass.new(0, 0) }

        context 'and the same position' do
          let(:grass2) { Tile::Grass.new(0, 0) }

          it 'returns true' do
            expect(grass1 == grass2).to be true
          end
        end

        context 'and a different position' do
          let(:grass2) { Tile::Grass.new(0, 1) }

          it 'returns false' do
            expect(grass1 == grass2).to be false
          end
        end
      end

      context 'given two tiles of the different types' do
        let(:grass1) { Tile::Grass.new(0, 0) }

        context 'and the same position' do
          let(:wall2) { Tile::Wall.new(0, 0) }

          it 'returns true' do
            expect(grass1 == wall2).to be false
          end
        end

        context 'and a different position' do
          let(:wall2) { Tile::Wall.new(0, 1) }

          it 'returns false' do
            expect(grass1 == wall2).to be false
          end
        end
      end
    end

    describe '#eql?' do
      context 'given two tiles of the same type' do
        let(:grass1) { Tile::Grass.new(0, 0) }

        context 'and the same position' do
          let(:grass2) { Tile::Grass.new(0, 0) }

          it 'returns true' do
            expect(grass1.eql?(grass2)).to be true
          end
        end

        context 'and a different position' do
          let(:grass2) { Tile::Grass.new(0, 1) }

          it 'returns false' do
            expect(grass1.eql?(grass2)).to be false
          end
        end
      end

      context 'given two tiles of the different types' do
        let(:grass1) { Tile::Grass.new(0, 0) }

        context 'and the same position' do
          let(:wall2) { Tile::Wall.new(0, 0) }

          it 'returns true' do
            expect(grass1.eql?(wall2)).to be false
          end
        end

        context 'and a different position' do
          let(:wall2) { Tile::Wall.new(0, 1) }

          it 'returns false' do
            expect(grass1.eql?(wall2)).to be false
          end
        end
      end
    end
  end
end
