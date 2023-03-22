#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require 'r_k_theory'

game = RKTheory::Engine.new
game.run
