# frozen_string_literal: true

require_relative 'terminal'
require_relative 'bunny'
require_relative 'map'
require_relative 'position'
require_relative 'tile'

module RKTheory
  # Implements a simple game engine loop with hooks for game logic and rendering
  class Engine
    SPEED = 10
    def initialize
      @map_manager = MapManager.new('level1')
      @map = @map_manager.map
      @bunny = Bunny.new(@map_manager.player_position, @map)
      @terminal = Terminal.new(@map.height, @map.width)
    end

    def run
      accumulator = 0
      while !@bunny.ate?
        delta = current_step - last_step
        render
        if delta > 1000.0 / SPEED
          gap = delta - 1000.0 / SPEED
          accumulator += (delta - 1000.0 / SPEED)
          RKTheory.logger.info("#{sprintf('%.4f', current_step)} | delta: #{sprintf('%.7f', delta)} | gap: #{sprintf('%.6f', gap)} | accumulator: #{sprintf('%.6f', accumulator)}")
          @last_step = current_step
          tick
        end
        @current_step = nil
      end
      sleep
    ensure
      @terminal.close
    end

    def tick
      @bunny.tick
      @bunny.ate?
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
      @current_step ||= Time.now.to_f * 1000
    end
  end
end
