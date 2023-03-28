# frozen_string_literal: true

module RKTheory
  class PathFinding
    # Implementation of a flood fill algorithm
    class FloodFill < PathFinding

      def initialize(origin, map)
        super
        @next_position = Hash.new(nil)
        @visited = Hash.new(false)
        @frontier = [@map.goal.position]
      end

      def next_position(current_position)
        super do
          @next_position[current_position]
        end
      end

      def iterate_search
        return if @path_found || @frontier.empty?
        curr_pos = @frontier.pop
        check_neighbours(curr_pos)
        @visited[curr_pos] = true
        curr_pos
      end

      def check_neighbours(curr_pos)
        neighbours(curr_pos).each do |neighbour|
          next if @visited[neighbour] || @frontier.include?(neighbour)

          @frontier.unshift(neighbour)
          @next_position[neighbour] = curr_pos
          @path_found = true if neighbour == @origin
        end
      end
    end
  end
end
