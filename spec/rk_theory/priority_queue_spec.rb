# frozen_string_literal: true

module RKTheory
  RSpec.describe PriorityQueue do
    subject(:queue) do
      q = PriorityQueue.new
      q.<<('Abraham', 5)
      q.<<('Jack', 3)
      q.<<('Evan', 10)
      q.<<('John', 1)
      q
    end

    describe 'bug' do
      let(:queue) do
        q = PriorityQueue.new
        q.<<(Position.new(15, 44), 21)
        q.<<(Position.new(18, 43), 21)
        q.<<(Position.new(16, 43), 21)
        q.<<(Position.new(19, 43), 22)
        q
      end

      it 'returns the following elements' do
        expect(queue.instance_variable_get(:@elements)[1..-1].join(', ')).to eq(
          '[21:(16, 43)], [21:(15, 44)], [21:(18, 43)], [22:(19, 43)]'
        )
      end

      it 'reproduces the bug when we pop an element' do
        queue.pop
        queue.pop
        expect(queue.instance_variable_get(:@elements)[1..-1].join(', ')).to eq(
          '[21:(15, 44)], [22:(19, 43)]'
        )
      end
    end

    describe '#to_a' do
      it 'returns the queue elements sorted by priority' do
        expect(queue.to_a).to eq(['John', 'Jack', 'Abraham', 'Evan'])
      end
    end

    describe '#sort' do
      it 'returns the queue elements sorted by their values comparable <=> (alphabetically for strings)' do
        expect(queue.sort).to eq(['Abraham', 'Evan', 'Jack', 'John'])
      end
    end

    describe '#count' do
      it 'returns the number of elements in the array, discarding the nil leading element' do
        expect(queue.count).to eq(4)
      end
    end

    describe '#pop' do
      it 'returns the value of the element and not the element itself' do
        expect(queue.pop).to be_an_instance_of(String)
      end

      it 'returns the elements from highest to lowest priority' do
        expect(queue.pop).to eq('John')
        expect(queue.pop).to eq('Jack')
        expect(queue.pop).to eq('Abraham')
      end

      it 'removes the popped element from the queue' do
        expect(queue.pop).to eq('John')
        expect(queue.entries).not_to include('John')
      end
    end

    describe '::new' do
      subject(:queue) { PriorityQueue.new }

      it 'responds with a priority queue object' do
        expect(queue).to be_an_instance_of PriorityQueue
      end

      it 'responds with an empty queue' do
        expect(queue.count).to be(0)
      end
    end
  end
end
