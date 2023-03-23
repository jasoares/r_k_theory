# frozen_string_literal: true

module RKTheory
  class PathFinding
    class Random < PathFinding
      def next_position
        super do
          valid_options.values.shuffle.find.with_index do |option, idx|
            next true if idx == valid_options.values.size - 1
            next true if !@path.include?(option)
            next false
          end
        end
      end

      def valid_options
        %w(up down left right).map(&:to_sym).inject({}) do |options, option|
          option_position = @current_position.send(option)
          options[option] = option_position if @map.valid?(option_position)
          options
        end
      end
    end
  end
end
