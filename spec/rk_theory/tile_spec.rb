# frozen_string_literal: true

module RKTheory
  RSpec.describe Tile do
    let(:map) { instance_double(Map) }
    let(:tile) { described_class::Grass.new(2, 1, map) }

    describe '#position' do
      subject { tile.position }
      it { is_expected.to eq(Position.new(2, 1)) }
    end

    describe '#walkable?' do
      it 'returns true for grass' do
        expect(tile.walkable?).to be true
      end

      it 'returns false for wall' do
        expect(Tile::Wall.new(1, 2, map).walkable?).to be false
      end

      it 'returns true for carrot' do
        expect(Tile::Carrot.new(1, 2, map).walkable?).to be true
      end
    end

    describe '#==' do
      it 'returns true for same type and same position' do
        expect(tile == described_class::Grass.new(2, 1, map)).to be true
      end

      it 'returns false for different types even with same position' do
        expect(tile == described_class::Wall.new(2, 1, map)).to be false
      end

      it 'returns false for same type and different position' do
        expect(tile == described_class::Grass.new(1, 2, map)).to be false
      end
    end

    describe '#eql?' do
      it 'returns true for same type and same position' do
        expect(tile.eql?(described_class::Grass.new(2, 1, map))).to be true
      end

      it 'returns false for different types even with same position' do
        expect(tile.eql?(described_class::Wall.new(2, 1, map))).to be false
      end

      it 'returns false for same type and different position' do
        expect(tile.eql?(described_class::Grass.new(1, 2, map))).to be false
      end
    end

    describe '#hash' do
      it 'returns a different hash for two tiles of different types' do
        expect(tile.hash).not_to be described_class::Wall.new(2, 1, map).hash
      end

      it 'returns a different hash for two tiles of different positions' do
        expect(tile.hash).not_to be described_class::Grass.new(1, 2, map).hash
      end

      it 'returns the same hash for two tiles of the same type and position' do
        expect(tile.hash).to be described_class::Grass.new(2, 1, map).hash
      end
    end
  end
end
