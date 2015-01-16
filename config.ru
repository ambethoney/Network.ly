require 'uri'
require 'httparty'


require 'sinatra/base'
require 'sinatra/reloader'

require_relative 'server'
require_relative 'databasehelper'


run ProjectDashboard::Server



