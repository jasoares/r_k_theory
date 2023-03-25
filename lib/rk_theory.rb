# frozen_string_literal: true

require 'curses'
require 'pry'
require 'logger'

# Module that implements the building blocks to simulate R K Selection Theory
# See https://en.wikipedia.org/wiki/R/K_selection_theory
module RKTheory
  class Error < StandardError; end

  class << self
    attr_accessor :logger
  end
end

require 'rk_theory/version'
require 'rk_theory/engine'

RKTheory.logger = Logger.new('rk_theory.log')
RKTheory.logger.level = Logger::DEBUG
