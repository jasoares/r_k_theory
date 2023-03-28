# frozen_string_literal: true

module RKTheory
  class PathFinding
    # Implementation of a random movement algorithm that naively avoids walking
    # the same tiles twice.
    class Random < PathFinding
      def initialize(origin, map)
        super
        @path_found = true
      end

      def next_position(current_position)
        super do
          neighbours(current_position).shuffle.find.with_index do |option, idx|
            next true if idx == neighbours(current_position).size - 1
            next true unless path.include?(option)

            false
          end
        end
      end
    end
  end
end
