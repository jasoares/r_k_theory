# frozen_string_literal: true

module RKTheory
  class PathFinding
    # Implementation of a flood fill algorithm
    class FloodFill < PathFinding
      def initialize(origin, map)
        super
        @next_position = Hash.new(nil)
        @visited = Hash.new(false)
      end

      def next_position
        super do
          next_position = @next_position[@current_position]
        end
      end

      def render_find_path(window)
        @frontier = [@map.goal.position]
        while !@path_found && @frontier.any?
          curr_pos = @frontier.pop
          render_curr_position(window, curr_pos)
          check_neighbours(curr_pos)
          @visited[curr_pos] = true
          sleep 0.01
        end
      end

      def check_neighbours(curr_pos)
        neighbours(curr_pos).each do |neighbour|
          next if @visited[neighbour] || @frontier.include?(neighbour)

          @frontier.unshift(neighbour)
          @next_position[neighbour] = curr_pos
          @path_found = true if neighbour == @current_position
        end
      end

      def render_curr_position(window, curr_pos)
        window.setpos(curr_pos.row, curr_pos.col)
        window.attron(Curses.color_pair(4)) { window << '*' }
        window.refresh
      end
    end
  end
end
