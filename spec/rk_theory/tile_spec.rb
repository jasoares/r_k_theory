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
      it 'returns true for same type and same position' do
        expect(tile == described_class::Grass.new(2, 1)).to be true
      end

      it 'returns false for different types even with same position' do
        expect(tile == described_class::Wall.new(2, 1)).to be false
      end

      it 'returns false for same type and different position' do
        expect(tile == described_class::Grass.new(1, 2)).to be false
      end
    end

    describe '#eql?' do
      it 'returns true for same type and same position' do
        expect(tile.eql?(described_class::Grass.new(2, 1))).to be true
      end

      it 'returns false for different types even with same position' do
        expect(tile.eql?(described_class::Wall.new(2, 1))).to be false
      end

      it 'returns false for same type and different position' do
        expect(tile.eql?(described_class::Grass.new(1, 2))).to be false
      end
    end
  end
end
