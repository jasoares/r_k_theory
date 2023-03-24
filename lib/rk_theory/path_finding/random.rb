# frozen_string_literal: true

module RKTheory
  class PathFinding
    # Implementation of a random movement algorithm that naively avoids walking
    # the same tiles twice.
    class Random < PathFinding
      DIRECTIONS4 = %w[up down left right]
      DIRECTIONS8 = %w[up up_right right down_right down down_left left up_left]

      def next_position
        super do
          valid_options.values.shuffle.find.with_index do |option, idx|
            next true if idx == valid_options.values.size - 1
            next true unless @path.include?(option)

            false
          end
        end
      end

      def valid_options
        DIRECTIONS4.map(&:to_sym).each_with_object({}) do |option, options|
          option_position = @current_position.send(option)
          options[option] = option_position if @map.valid?(option_position)
        end
      end
    end
  end
end
