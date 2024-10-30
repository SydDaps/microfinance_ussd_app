# frozen_string_literal: true

require 'dotenv/load'
require 'sinatra'
require 'byebug'
require 'rubocop'
require 'phonelib'
require 'date'
require 'json'
require 'active_support/all'
require 'bianchi'

Dir["#{File.dirname(__FILE__)}/ussd/**/*.rb"].sort.each { |file| require file }
require './app'

run Sinatra::Application
