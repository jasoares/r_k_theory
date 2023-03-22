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

require_relative 'r_k_theory/version'
require_relative 'r_k_theory/engine'

RKTheory.logger = Logger.new($stdout)
RKTheory.logger.level = Logger::WARN
