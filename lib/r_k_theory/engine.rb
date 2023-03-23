# frozen_string_literal: true

require_relative 'terminal'
require_relative 'bunny'
require_relative 'map'
require_relative 'position'
require_relative 'tile'

module RKTheory
  # Implements a simple game engine loop with hooks for game logic and rendering
  class Engine
    def initialize
      @map = MapManager.load('level1')
      @terminal = Terminal.new(@map.height, @map.width)
      @bunny = Bunny.new(3, 2)
    end

    def run
      last_step = (Time.now.to_f * 1000).to_i
      loop do
        curr_step = (Time.now.to_f * 1000).to_i
        if curr_step - last_step > 1000 / 60
          last_step = curr_step
          render
          tick
        else
          sleep 0.05
        end
      end
    ensure
      @terminal.close
    end

    def tick
      @bunny.tick(@map)
    end

    def render
      @terminal.render do |window|
        @map.render(window)
        @bunny.render(window)
      end
    end
  end
end
