# frozen_string_literal: true

module RKTheory
  # Class describing the player
  class Bunny
    def initialize(x, y)
      @loading = true
      @position = Position.new(x, y)
      @old_position = Position.new(x, y)
    end

    def tick(map)
      move(map)
    end

    def move(map)
      new_position = Position.new(-1, -1)
      while map.invalid?(new_position)
        delta_x = Random.rand(3).floor - 1
        delta_y = Random.rand(3).floor - 1
        new_position = Position.new(@position.x + delta_x, @position.y + delta_y)
      end
      @old_position = @position
      @position = new_position
    end

    def render(window)
      window.setpos(@old_position.y, @old_position.x)
      window.attron(Curses.color_pair(1)) { window << '.' }
      window.setpos(@position.y, @position.x)
      window.attron(Curses.color_pair(3)) { window << '@' }
      # Loading animation
      # 2.times do
      #   window.refresh
      #   sleep 0.3

      #   window << "\b@"
      #   window.refresh
      #   sleep 0.3
      #   window.attron(color_pair(3)) { window << "\b@" }
      # end if @loading
      @loading = false
    end
  end
end
