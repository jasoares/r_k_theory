# frozen_string_literal: true

module RKTheory
  # Element utility class implemented to be used internally by PriorityQueue only
  class Element
    include Comparable

    attr_accessor :value, :priority, :enqueued_at

    def initialize(value, priority)
      @value, @priority = value, priority
      @enqueued_at = Time.now
    end

    def <=>(other)
      return other.enqueued_at <=> @enqueued_at if @priority == other.priority

      @priority <=> other.priority
    end

    def to_s
      "[#{priority}:#{value}]"
    end
  end

  # PriorityQueue implementation based on https://www.brianstorti.com/implementing-a-priority-queue-in-ruby/
  # Major changes are the interface to enqueue elements which abstracts the Element class not requiring the
  # user to know it even exists and reversing the order of priority to be smaller at the top.
  class PriorityQueue
    include Enumerable

    def initialize
      @elements = [nil]
    end

    def <<(element, priority)
      @elements << Element.new(element, priority)
      bubble_up(@elements.size - 1)
    end

    def bubble_up(index)
      parent_index = (index / 2)

      # return if we reach the root element
      return if index <= 1

      # or if the parent is already smaller than the child
      return if @elements[parent_index] <= @elements[index]

      # otherwise we exchange the child with the parent
      exchange(index, parent_index)

      # and keep bubbling up
      bubble_up(parent_index)
    end

    def each
      @elements[1..-1].sort.map(&:value).each do |value|
        yield value
      end
    end

    def exchange(source, target)
      @elements[source], @elements[target] = @elements[target], @elements[source]
    end

    def pop
      # exchange the root with the last element
      exchange(1, @elements.size - 1)

      # remove the last element of the queue
      min = @elements.pop

      # and make sure the tree is ordered again
      bubble_down(1)
      min.value
    end

    def bubble_down(index)
      child_index = (index * 2)

      # stop if we reach the bottom of the tree
      return if child_index > @elements.size - 1

      # make sure we get the smallest child
      not_the_last_element = child_index < @elements.size - 1
      left_element = @elements[child_index]
      right_element = @elements[child_index + 1]
      child_index += 1 if not_the_last_element && left_element > right_element

      # there is no need to continue if the parent element is already bigger
      # than its children
      return if @elements[index] <= @elements[child_index]

      exchange(index, child_index)

      bubble_down(child_index)
    end
  end
end
