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
    def initialize(map, algorithm=PathFinding::Dijkstra)
      @map = Map.from_file(map)
      @player = Bunny.new(@map.player_position, @map, algorithm)
      @terminal = Terminal.new(@map.height, @map.width)
      @pause = false
    end

    def run
      thread = start_input_handler
      find
      walk
      thread.join
    ensure
      @terminal.close
    end

    def find
      loop do
        next if @pause

        @player.iterate_search
        @terminal.render do |window|
          @first_render ||= @map.render(window) and true
          @player.render_path_finding(window)
        end
        sleep 0.002
        break if @player.path_found?
      end
    end

    def walk
      loop do
        next if @pause

        delta = current_step - last_step
        if delta > (1000.0 / SPEED)
          @last_step = current_step
          @player.iterate_move
        end
        @terminal.render do |window|
          @map.render(window)
          @player.render_path_walking(window)
        end
        sleep 0.002
        break if @player.ate?
      end
    end

    def start_input_handler
      Thread.new do
        loop do
          @pause = !@pause if @terminal.window.getch == 'p'
        end
      end
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
