# frozen_string_literal: true

RSpec.describe RKTheory::Position do
  describe '#row' do
    context 'given a Position (0, 0)' do
      let(:position) { RKTheory::Position.new(0, 0) }

      it 'returns the row referenced by the position' do
        expect(position.row).to eq(0)
      end
    end

    context 'given a Position (1, 2)' do
      let(:position) { RKTheory::Position.new(1, 2) }

      it 'returns the row referenced by the position' do
        expect(position.row).to eq(1)
      end
    end
  end

  describe '#col' do
    context 'given a Position (0, 0)' do
      let(:position) { RKTheory::Position.new(0, 0) }

      it 'returns the col referenced by the position' do
        expect(position.col).to eq(0)
      end
    end

    context 'given a Position (1, 2)' do
      let(:position) { RKTheory::Position.new(1, 2) }

      it 'returns the col referenced by the position' do
        expect(position.col).to eq(2)
      end
    end
  end

  describe '#==' do
    context 'given two positions (0, 0) and (0, 0)' do
      let(:position_a) { RKTheory::Position.new(0, 0) }
      let(:position_b) { RKTheory::Position.new(0, 0) }

      it 'returns true' do
        expect(position_a == position_b).to eq(true)
      end
    end

    context 'given two positions (1, 2) and (2, 1)' do
      let(:position_a) { RKTheory::Position.new(1, 2) }
      let(:position_b) { RKTheory::Position.new(2, 1) }

      it 'returns false' do
        expect(position_a == position_b).to eq(false)
      end
    end
  end

  describe '#eql?' do
    context 'given two positions (0, 0) and (0, 0)' do
      let(:position_a) { RKTheory::Position.new(0, 0) }
      let(:position_b) { RKTheory::Position.new(0, 0) }

      it 'returns true' do
        expect(position_a.eql?(position_b)).to eq(true)
      end
    end

    context 'given two positions (1, 2) and (2, 1)' do
      let(:position_a) { RKTheory::Position.new(1, 2) }
      let(:position_b) { RKTheory::Position.new(2, 1) }

      it 'returns false' do
        expect(position_a.eql?(position_b)).to eq(false)
      end
    end
  end

  describe '#to_s' do
    context 'given a Position (1, 2)' do
      let(:position) { RKTheory::Position.new(1, 2) }

      it 'returns "(1, 2)" as a string' do
        expect(position.to_s).to eq("(1, 2)")
      end
    end

    context 'given an array of 2 positions' do
      let(:positions) do
        [
          RKTheory::Position.new(0, 0),
          RKTheory::Position.new(1, 0)
        ]
      end

      it 'returns "[(0, 0), (1, 0)]" as a string' do
        expect(positions.to_s).to eq('[(0, 0), (1, 0)]')
      end
    end
  end

  context 'given an array of 4 positions with 1 duplicate' do
    let(:positions) do
      [
        RKTheory::Position.new(0, 0),
        RKTheory::Position.new(1, 0),
        RKTheory::Position.new(1, 1),
        RKTheory::Position.new(1, 0)
      ]
    end

    describe '#uniq' do
      it 'returns 3 unique positions' do
        expect(positions.uniq).to eq [
          RKTheory::Position.new(0, 0),
          RKTheory::Position.new(1, 0),
          RKTheory::Position.new(1, 1)
        ]
      end
    end
  end
end
