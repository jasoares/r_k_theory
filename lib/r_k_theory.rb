# frozen_string_literal: true
require "curses"
require 'pry'
require 'logger'
include Curses

module RKTheory
  class Error < StandardError; end

  class << self
    attr_accessor :logger
  end
end

RKTheory::logger = Logger.new(STDOUT)
RKTheory::logger.level = Logger::INFO

require_relative 'r_k_theory/version'
require_relative 'r_k_theory/engine'

game = RKTheory::Engine.new
game.run
