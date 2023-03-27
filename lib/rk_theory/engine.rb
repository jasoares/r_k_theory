# frozen_string_literal: true

require_relative 'terminal'
require_relative 'bunny'
require_relative 'map'
require_relative 'position'
require_relative 'tile'

module RKTheory
  # Implements a simple game engine loop with hooks for game logic and rendering
  class Engine
    SPEED = 20
    def initialize
      @map = Map.from_file('level0')
      @players = @map.players
      @terminal = Terminal.new(@map.height, @map.width)
    end

    def run
      until @players.all?(&:ate?)
        delta = current_step - last_step
        if delta > (1000.0 / SPEED)
          @last_step = current_step
          step
        end
      end
      sleep
    ensure
      @terminal.close
    end

    def step
      @terminal.render do |window|
        @map.render(window)
        @players.map { |p| p.render(window) }
      end
      @players.map(&:tick)
    end

    private

    def last_step
      @last_step ||= current_step
    end

    def current_step
      Time.now.to_f * 1000
    end
  end
end
