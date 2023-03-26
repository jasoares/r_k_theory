# frozen_string_literal: true

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

    subject { described_class.new(grid) }

    describe '#tilemap' do
      context "with the following 2D grid \n#{level}" do
        it 'returns the expect 2D tilemap' do
          expect(subject.tilemap).to eq(tilemap)
        end
      end
    end

    describe '#player' do
      context "with the following 2D grid \n#{level}" do
        it 'returns an instance of Bunny' do
          expect(subject.player).to be_an_instance_of(Bunny)
        end

        it 'has a postion of (2, 2)' do
          expect(subject.player.position).to eq(Position.new(2, 2))
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
