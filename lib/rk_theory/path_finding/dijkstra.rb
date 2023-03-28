# frozen_string_literal: true

module RKTheory
  class PathFinding::Dijkstra < PathFinding
    attr_reader :cost_to_reach, :frontier

    def initialize(origin, map)
      super
      @next_position = Hash.new(nil)
      @cost_to_reach = { @map.goal.position => 0 }
      @frontier = PriorityQueue.new
      @frontier.<<(@map.goal.position, 1)
    end

    def next_position(current_position)
      super do
        @next_position[current_position]
      end
    end

    def iterate_search
      return if @path_found || @frontier.to_a.empty?
      curr_pos = @frontier.pop
      check_neighbours(curr_pos)
      curr_pos
    end

    def check_neighbours(curr_pos)
      neighbours(curr_pos).each do |neighbour|
        cost = @cost_to_reach[curr_pos] + @map[neighbour.row][neighbour.col].cost
        if !@cost_to_reach.key?(neighbour) || cost < @cost_to_reach[neighbour]
          @cost_to_reach[neighbour] = cost
          @frontier.<<(neighbour, cost)
          @next_position[neighbour] = curr_pos;
          @path_found = true if neighbour == @origin
        end
      end
    end
  end
end
