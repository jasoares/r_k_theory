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
      @map_manager = MapManager.new('level1')
      @map = @map_manager.map
      @bunny = Bunny.new(@map_manager.player_position, @map)
      @terminal = Terminal.new(@map.height, @map.width)
    end

    def run
      loop do
        sleep 0.1 if current_step - last_step < 1000 / 60
        @last_step = current_step
        render
        tick
      end
    ensure
      @terminal.close
    end

    def tick
      @bunny.tick
    end

    def render
      @terminal.render do |window|
        @map.render(window)
        @bunny.render(window)
      end
    end

    private

    def last_step
      @last_step ||= current_step
    end

    def current_step
      (Time.now.to_f * 1000).to_i
    end
  end
end
