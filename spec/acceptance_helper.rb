require File.dirname(__FILE__) + '/spec_helper'
require Sinatra::Application.root + '/chess'
disable :run

require 'capybara/cucumber'
require 'capybara'
require 'capybara/dsl'

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara
end