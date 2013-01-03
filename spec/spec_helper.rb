dir = File.dirname(__FILE__)
require dir + '/../chess'
require 'rubygems'
require 'rspec'
require 'bundler/setup'
require 'sinatra'
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment